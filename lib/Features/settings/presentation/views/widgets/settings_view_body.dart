import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_section_title.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_data_section.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_image.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/settings_title.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: ListView(
        children: [
          SettingsTitle(),
          const SizedBox(
            height: 20,
          ),
          ProfileDataSection(),
          CustomSectionTitle(title: 'Style'),
          BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
            builder: (context, state) {
              int indexFont =
                  BlocProvider.of<ChangeSettingsCubit>(context).fontIndex;
              int indexTheme =
                  BlocProvider.of<ChangeSettingsCubit>(context).themeIndex;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Theme',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        CustomDropdownMenu(
                            onSelected: (value) {
                              BlocProvider.of<ChangeSettingsCubit>(context)
                                  .changeTheme(value);
                              indexTheme = value;
                            },
                            initialSelection: indexTheme,
                            firstOption: 'Light',
                            secondOption: 'Dark',
                            thridption: 'Default'),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          'Font Size',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        CustomDropdownMenu(
                            onSelected: (value) {
                              BlocProvider.of<ChangeSettingsCubit>(context)
                                  .changeFontSize(value);
                              // setState(() {
                              indexFont = value;
                              // });
                              print(value);
                              print('index font $indexFont');
                            },
                            initialSelection: indexFont,
                            firstOption: 'Small',
                            secondOption: 'Medium',
                            thridption: 'Large'),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          LogoutButton(),
        ],
      ),
    );
  }
}
