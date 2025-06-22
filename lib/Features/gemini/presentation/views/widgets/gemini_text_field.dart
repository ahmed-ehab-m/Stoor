import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiTextField extends StatefulWidget {
  const GeminiTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<GeminiTextField> createState() => _GeminiTextFieldState();
}

class _GeminiTextFieldState extends State<GeminiTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<Alignment> _beginAnimation;
  // late Animation<Alignment> _endAnimation;
  String? question;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    // _beginAnimation =
    //     Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
    //         .animate(_controller);
    // _endAnimation = Tween<Alignment>(
    //   begin: Alignment.bottomRight,
    //   end: Alignment.topLeft,
    // ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: TextField(
            focusNode: _focusNode,
            cursorColor: kPrimaryColor,
            controller: widget.controller, // ربط الـ Controller
            style: Styles.textStyle16, // Change the input text style here
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              hintText: 'Ask a Bot...',
              hintStyle: Styles.textStyle14.copyWith(
                  // color: Colors.grey[500],
                  // Lighter color for hint
                  // fontStyle: FontStyle.italic, // Italic for a softer look
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
              suffixIcon: CustomShaderMask(
                child: IconButton(
                  onPressed: () async {
                    question = widget.controller.text;

                    if (widget.controller.text.isEmpty) return;
                    widget.controller.clear();
                    _focusNode.unfocus();
                    // onSend(widget.controller.text);
                    await BlocProvider.of<GeminiCubit>(context)
                        .getRecommendedBook(
                      books:
                          BlocProvider.of<FeaturedBooksCubit>(context).AllBooks,
                      userDescription: question!,
                    );
                  },
                  icon: BlocBuilder<GeminiCubit, GeminiState>(
                    builder: (context, state) {
                      Widget? sendWidget = const Icon(
                        Icons.send,
                        color: Colors.white,
                      );
                      if (state is GeminiLoadingState) {
                        sendWidget = const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return sendWidget;
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
