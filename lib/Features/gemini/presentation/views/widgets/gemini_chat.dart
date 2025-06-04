import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_loading_animation.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/no_match_books.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/user_chat_item.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_result_list_view.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
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
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
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
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: BlocConsumer<GeminiCubit, GeminiState>(
        listener: (context, state) {
          if (state is GeminiChatHistoryLoadingState) {
            print('Chat history loading state');
          }
          if (state is GeminiChatHistoryLoadedState) {
            print(
                'Chat history loaded from shared prefs successfully chat history length: ${state.chatHistory.length}');
          }
          if (state is GeminiMessageSaveFailureState) {
            showSnackBar(context,
                message: state.errorMessage, color: Colors.red);
          }
          if (state is GeminiChatHistoryFailureState) {
            showSnackBar(context,
                message: state.errorMessage, color: Colors.red);
          }
          if (state is GeminiLoadedState) {
            print(
                'Gemini loaded successfully, chatHistory length: ${state.chatHistory.length}');
          }
          if (state is GeminiErrorState) {
            print(
                'Gemini error state: ${state.errorMessage}, chatHistory length: ${state.chatHistory.length}');
          }
        },
        builder: (context, state) {
          List<ChatMessageModel> chatHistory = [];
          // if (state is GeminiInitial) {
          //   chatHistory = state.chatHistory;
          //   print('Initial state, chatHistory length: ${chatHistory.length}');
          // }
          if (state is GeminiLoadingState) {
            chatHistory = state.chatHistory;
            print('Loading state, chatHistory length: ${chatHistory.length}');
          } else if (state is GeminiLoadedState) {
            chatHistory = state.chatHistory;
            print('Loaded state, chatHistory length: ${chatHistory.length}');
          } else if (state is GeminiErrorState) {
            chatHistory = state.chatHistory;
            print('Error state, chatHistory length: ${chatHistory.length}');
          } else if (state is GeminiChatHistoryLoadedState) {
            chatHistory = state.chatHistory;
            print(
                'Chat history loaded state, chatHistory length: ${chatHistory.length}');
          } else if (state is GeminiChatHistoryFailureState) {
            chatHistory = context
                .read<GeminiCubit>()
                .chatHistory; // استخدام chatHistory من Cubit
            print('Chat history failure state');
          }

          return ListView.builder(
            key: ValueKey(
                chatHistory.length), // إضافة key لإجبار إعادة الـ build
            reverse: true,
            itemCount: chatHistory.length,
            controller: _scrollController,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              print(
                  'Building item $index, type: ${chatHistory[index].type}, status: ${chatHistory[index].status}, message: ${chatHistory[index].message}');
              final message = chatHistory[index];
              if (message.type == 'bot') {
                if (message.status == 'loading') {
                  return const CustomLoadingAnimation();
                } else if (message.message ==
                    'No relevant books found ,try with different description.') {
                  return NoMatchBooks(errorMessage: message.message ?? '');
                } else if (message.message is List<BookModel>) {
                  print(
                      'Rendering SearchResultListView with ${message.message.length} books');
                  return GeminiResultListView(books: message.message);
                } else {
                  print('Unexpected bot message: ${message.message}');
                  return const SizedBox.shrink(); // تجنب عرض أي شيء غير متوقع
                }
              } else if (message.type == 'user') {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UserChatItem(message: message.message ?? ''),
                  ],
                );
              } else {
                print('Unexpected message type: ${message.type}');
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
