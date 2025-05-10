import 'dart:io';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/core/helper/font_size_helper.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  int? indexTheme, indexFont, indexLayout;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  Future<void> pickImagefromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kProfileImage, imageFile!.path);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadInitialIndex();
  }

  Future<void> loadInitialIndex() async {
    final prefs = await SharedPreferences.getInstance();
    indexTheme = prefs.getInt(KThemeyKey) ?? 3;
    indexFont = prefs.getInt(KFontKeySize) ?? 2;
    imageFile = File(prefs.getString(kProfileImage) ?? '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeHelper.horizontalPadding,
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                await pickImagefromGallery();

                // setState(() {});
              },
              child: imageFile == null
                  ? const CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: kPrimaryColor,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,
                      radius: 60,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Ahmed Ehab',
              style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Ahmed Ehab',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'ahmedhoopa22@gmail.com',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Style',
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 137, 136, 150)),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Theme',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Divider(),
                if (indexTheme !=
                    null) /////////to return to index value to see it again /////////////
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
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Spacer(),
          LogoutButton(),
          // SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }
}
