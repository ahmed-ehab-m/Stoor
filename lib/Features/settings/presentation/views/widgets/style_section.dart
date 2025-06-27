import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StyleSection extends StatelessWidget {
  const StyleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomSectionTitle(title: 'Style'),
        BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            int indexFont =
                BlocProvider.of<ChangeSettingsCubit>(context).fontIndex;
            int indexTheme =
                BlocProvider.of<ChangeSettingsCubit>(context).themeIndex;
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
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
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        'Font Size',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      CustomDropdownMenu(
                          onSelected: (value) {
                            BlocProvider.of<ChangeSettingsCubit>(context)
                                .changeFontSize(value);

                            indexFont = value;
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
      ],
    );
  }
}
