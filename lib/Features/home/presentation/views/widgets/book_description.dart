import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/functions/is_arabic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key, this.bookDescription});
  final String? bookDescription;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            // description,
            bookDescription ?? 'No description available yet',
            textAlign:
                isArabic(bookDescription ?? 'No description available yet')
                    ? TextAlign.center
                    : TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                  .descriptionFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
