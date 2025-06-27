import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/functions/is_arabic.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorName extends StatelessWidget {
  const AuthorName({super.key, this.authorName});
  final String? authorName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                Colors.white,
                Color(0xffFFD400),
                // Blue
              ],
              tileMode: TileMode.repeated,
            ).createShader(bounds);
          },
          child: Text(
            'By: ',
            style: Styles.textStyle18
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white
                    // fontStyle: FontStyle.italic,
                    ),
          ),
        ),
        Text(
          textAlign: isArabic(authorName ??
                  'No Author Name') // Assuming authorName is defined somewhere
              ? TextAlign.end
              : TextAlign.end,
          authorName ?? 'No Author Name',
          style: TextStyle(
            fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                .descriptionFontSize,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
