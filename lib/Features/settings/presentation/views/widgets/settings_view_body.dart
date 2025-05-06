import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/constants.dart';
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
    // indexFont = await SharedPreferencesHelper.getInt(KFontKey) ?? 2;
    // indexLayout = await SharedPreferencesHelper.getInt(KLayoutKey) ?? 1;
    setState(() {});
  }

  // Future<void> saveFontIndex(int value) async {
  //   await SharedPreferencesHelper.setInt(KFontKey, value);
  // }

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
          SizedBox(height: 10),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
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
          // SizedBox(
          //   height: ResponsiveSpacing.horizontal(20),
          // ),
          // if (indexTheme !=
          //     null) /////////to return to index value to see it again /////////////
          //   Row(
          //     children: [
          //       Text(
          //         'Theme',
          //         style: TextStyle(
          //             fontSize: ResponsiveSpacing.fontSize(18),
          //             fontWeight: FontWeight.bold),
          //       ),
          //       const Spacer(),
          //       CustomDropdownMenu(
          //           onSelected: (value) {
          //             BlocProvider.of<ChangeThemeCubit>(context)
          //                 .changeTheme(value);

          //             setState(() {
          //               indexTheme = value;
          //               saveThemeIndex(value);
          //             });
          //           },
          //           initialSelection: indexTheme!,
          //           firstOption: 'Light',
          //           secondOption: 'Dark',
          //           thridption: 'Default'),
          //     ],
          //   ),
          // SizedBox(
          //   height: ResponsiveSpacing.horizontal(20),
          // ),
          // if (indexLayout != null)
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
