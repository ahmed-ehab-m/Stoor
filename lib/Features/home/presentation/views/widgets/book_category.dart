import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCategory extends StatelessWidget {
  const BookCategory({super.key, this.categoryName});
  final String? categoryName;
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
            'Category: ',
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          categoryName ?? 'No Category',
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
