import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_data_section.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/settings_title.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/style_section.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:flutter/material.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeHelper.horizontalPadding,
        vertical: screenSizeHelper.homeVerticalPadding,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                SettingsTitle(),
                SizedBox(
                  height: 20,
                ),
                ProfileDataSection(),
                StyleSection(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Spacer(),
          const LogoutButton(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
