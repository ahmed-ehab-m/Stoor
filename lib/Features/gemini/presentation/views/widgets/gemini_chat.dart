import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_loading_animation.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/user_chat_item.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({
    super.key,
  });

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  late ScrollController _scrollController;
  List<ChatMessageModel> chatHistory = [];
  //////////////////////////////////
  //initialize the scroll controller
  @override
  void initState() {
    _scrollController = ScrollController();
    //addPostFrameCallBack => to run the code after run the widget first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        //hasClients to check if the scroll controller مرتبط ب Scrollable widget or not
        // it will be a true after building the widget first time
        //and to make code throw an exception
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    super.initState();
  }

  /////////////////////////////
  @override
  // to update the scroll controller after the widget updated or data changed
  void didUpdateWidget(covariant GeminiChat oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: BlocConsumer<GeminiCubit, GeminiState>(
        listener: (context, state) {
          if (state is GeminiLoadedState) {
            chatHistory = state.chatHistory;
          }
          if (state is GeminiChatHistoryLoadingState) {
            print('chat history Loading');
          }
          if (state is GeminiChatHistoryLoadedState) {
            print('chat history loaded');
            print(state.chatHistory.length);
            print(state.chatHistory[0].message);
            print(state.chatHistory[1].message);
            chatHistory = state.chatHistory;
            // print('chat history length ${chatHistory.length}');
          }

          if (state is GeminiChatHistoryFailureState) {
            print('chat history Failure' + state.errorMessage);
          }
        },
        builder: (context, state) {
          // BlocProvider.of<GeminiCubit>(context).chatHistory;

          // final chatHistory = state.chatHistory;
          ChatMessageModel lastMessage;
          if (chatHistory.isNotEmpty) {
            int loadingIndex = chatHistory.length - 1;
            print('loadingIndex $loadingIndex');
            print(chatHistory[0].type);
            lastMessage = chatHistory[loadingIndex];
          }
          return ListView.builder(
              itemCount: chatHistory.length,
              controller: _scrollController,
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var message = chatHistory[index];
                if (message.type == 'bot') {
                  if (message.status == 'loading') {
                    if (index == chatHistory.length - 1) {
                      return const CustomLoadingAnimation();
                    }
                  } else {
                    return SearchResultListView(
                      books: message.message,
                    );
                  }
                } else {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UserChatItem(message: message.message),
                    ],
                  );
                }
                return null;
              });
        },
      ),
    );
  }
}
