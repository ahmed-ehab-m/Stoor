import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_question.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_subtitle.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsGridView extends StatelessWidget {
  const QuestionsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors =
        BlocProvider.of<ChangeSettingsCubit>(context).questionsColors;
    List<String> recentSearches = [
      'Horror',
      'Historical Fiction',
      'Dystopian ',
      'Fantasy ',
      'Romance Novels',
      "Adventure",
      'Classics',
      'Science Fiction',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const GeminiSubTitle(),
        Text(
          'Recent Questions:',
          style: Styles.textStyle18.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: recentSearches.asMap().entries.map((entry) {
              int index = entry.key;
              String question = entry.value;
              Color selectedGradient = colors[index % colors.length];
              return SizedBox(
                  height: 50,
                  child: CustomQuestion(
                      color: selectedGradient, question: question));
            }).toList()),
      ],
    );
  }
}
