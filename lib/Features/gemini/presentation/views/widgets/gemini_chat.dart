import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_loading_animation.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/no_match_books.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/user_chat_item.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_result_list_view.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
    super.initState();
  }

  @override
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
          if (state is GeminiMessageSaveFailureState) {
            showSnackBar(context,
                message: state.errorMessage, color: Colors.red);
          }
          if (state is GeminiChatHistoryFailureState) {
            showSnackBar(context,
                message: state.errorMessage, color: Colors.red);
          }
        },
        builder: (context, state) {
          final chatHistory = context.read<GeminiCubit>().chatHistory;

          return ListView.builder(
            key: ValueKey(chatHistory.length),
            reverse: true,
            itemCount: chatHistory.length,
            controller: _scrollController,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final message = chatHistory[index];
              if (message.type == 'bot') {
                if (message.status == 'loading') {
                  return const CustomLoadingAnimation();
                } else if (message.message ==
                    'No relevant books found ,try with different description.') {
                  return NoMatchBooks(errorMessage: message.message ?? '');
                } else if (message.message is List<BookModel>) {
                  return GeminiResultListView(books: message.message);
                } else {
                  return const NoMatchBooks(
                      errorMessage: 'General Error Please Try Again ');
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
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
