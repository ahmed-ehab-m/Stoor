import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiDescriptionDialog extends StatelessWidget {
  const GeminiDescriptionDialog({
    super.key,
    required this.geminiDescription,
  });
  final String geminiDescription;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'AI Bot Description',
        style: Styles.textStyle24
            .copyWith(fontWeight: FontWeight.w900, color: kSecondaryColor),
      ),
      content: Text(geminiDescription,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                  .descriptionFontSize)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close', style: Styles.textStyle18),
        ),
      ],
    );
  }
}
