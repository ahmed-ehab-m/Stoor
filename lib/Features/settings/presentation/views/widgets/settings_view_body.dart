import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/core/helper/font_size_helper.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  int? indexTheme, indexFont, indexLayout;
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ChangeFontSizeCubit>(context).defaultFont();
    loadInitialIndex();
  }

  Future<void> loadInitialIndex() async {
    final prefs = await SharedPreferences.getInstance();
    indexTheme = prefs.getInt(KThemeyKey) ?? 3;
    indexFont = prefs.getInt(KFontKeySize) ?? 2;
    // indexLayout = await SharedPreferencesHelper.getInt(KLayoutKey) ?? 1;
    setState(() {});
  }

  // Future<void> saveLayoutIndex(int value) async {
  //   await SharedPreferencesHelper.setInt(KLayoutKey, value);
  // }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeHelper.horizontalPadding,

        // vertical: screenSizeHelper.homeVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Styles.textStyle30),
          SizedBox(
            height: 40,
          ),
          Text(
            'Style',
            style: TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 137, 136, 150)),
          ),
          const Divider(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Theme',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              CustomDropdownMenu(
                  onSelected: (value) {
                    BlocProvider.of<ChangeThemeCubit>(context)
                        .changeTheme(value);

                    setState(() {
                      indexTheme = value;
                      BlocProvider.of<ChangeThemeCubit>(context)
                          .saveThemeIndex(value);
                    });
                  },
                  initialSelection: indexTheme ?? 3,
                  firstOption: 'Light',
                  secondOption: 'Dark',
                  thridption: 'Default'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if (indexTheme !=
              null) /////////to return to index value to see it again /////////////
            Row(
              children: [
                Text(
                  'Font Size',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                CustomDropdownMenu(
                    onSelected: (value) {
                      setState(() {
                        indexFont = value;
                        FontSizeHelper.changeFontSize(value);
                        print(FontSizeHelper.descriptionFontSize);
                      });
                    },
                    initialSelection: indexFont!,
                    firstOption: 'Small',
                    secondOption: 'Medium',
                    thridption: 'Large'),
              ],
            ),
          SizedBox(
            height: 20,
          ),
          // Spacer(),
          LogoutButton(),

          // CustomButton(
          //     backGroundColor: Colors.grey.withOpacity(0.2),
          //     textColor: Colors.redAccent,
          //     icon: HugeIcons.strokeRoundedLogout02,
          //     text: 'Logout'),
          SizedBox(
            height: 20,
          ),
          // if (indexLayout != null
          //   Row(
          //     children: [
          //       Text(
          //         'Layout',
          //         style: TextStyle(
          //             fontSize: ResponsiveSpacing.fontSize(18),
          //             fontWeight: FontWeight.bold),
          //       ),
          //       const Spacer(),
          //       CustomDropdownMenu(
          //         onSelected: (value) {
          //           BlocProvider.of<NotesCubit>(context).changeLayout(value);
          //           BlocProvider.of<NotesCubit>(context).fetchAllNotes();
          //           setState(() {
          //             indexLayout = value;
          //             saveLayoutIndex(value);
          //           });
          //         },
          //         initialSelection: indexLayout!,
          //         firstOption: 'GridView',
          //         secondOption: 'ListView',
          //       ),
          //     ],
          //   )
        ],
      ),
    );
  }
}
