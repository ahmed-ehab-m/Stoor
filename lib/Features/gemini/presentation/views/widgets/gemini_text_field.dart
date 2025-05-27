import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
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
  late Animation<Alignment> _beginAnimation;
  late Animation<Alignment> _endAnimation;
  String? question;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _beginAnimation =
        Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight)
            .animate(_controller);
    _endAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.transparent, // Transparent to show gradient
            ),
            gradient: LinearGradient(
              begin: _beginAnimation.value,
              end: _endAnimation.value,
              colors: const [
                Color(0xFFEC4899), // Pink
                Color(0xFFA855F7), // Purple
                // Color(0xFF3B82F6), // Blue
              ],
            ),
          ),
          child: TextField(
            cursorColor: kPrimaryColor,

            controller: widget.controller, // ربط الـ Controller
            style: Styles.textStyle18, // Change the input text style here
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor:
                  BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor,
              hintText: 'Describe your favorite book...',
              hintStyle: Styles.textStyle14.copyWith(
                color: Colors.grey[500],
                // Lighter color for hint
                fontStyle: FontStyle.italic, // Italic for a softer look
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: CustomShaderMask(
                child: IconButton(
                  onPressed: () async {
                    question = widget.controller.text;

                    if (widget.controller.text.isEmpty) return;
                    widget.controller.clear();

                    // onSend(widget.controller.text);
                    await BlocProvider.of<GeminiCubit>(context)
                        .getRecommendedBook(
                      books: BlocProvider.of<FeaturedBooksCubit>(context)
                          .featuredBooks,
                      userDescription: question!,
                    );
                  },
                  icon: BlocBuilder<GeminiCubit, GeminiState>(
                    builder: (context, state) {
                      Widget? sendWidget = Icon(
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
