import 'dart:io';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_alert_dialog.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_section_title.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_text_field.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          _emailController.text = state.user?.email ?? '';
          _nameController.text = state.user?.name ?? 'User';
          print('ProfileLoaded ');
        }
        if (state is ProfileFailure) {}
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSizeHelper.horizontalPadding,
            vertical: screenSizeHelper.homeVerticalPadding,
          ),
          child: ListView(
            children: [
              BlocConsumer<PickImageCubit, PickImageState>(
                listener: (context, state) {
                  if (state is PickImageFailure) {
                    showSnackBar(context,
                        message: state.message, color: Colors.redAccent);
                  }
                },
                builder: (context, state) {
                  String? imagePath =
                      (state is PickImageSuccess) ? state.path : null;
                  if (state is PickImageLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: InkWell(
                      onTap: () async {
                        await BlocProvider.of<PickImageCubit>(context)
                            .pickProfileImage();
                      },
                      child: imagePath == null || imagePath.isEmpty
                          ? const CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  FileImage(File(imagePath), scale: 1.0),
                              radius: 60,
                              key: ValueKey(
                                  imagePath), // Force rebuild with new image
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  _nameController.text.isEmpty
                      ? 'User'
                      : _nameController.text[0].toUpperCase() +
                          _nameController.text.substring(1),
                  style:
                      Styles.textStyle18.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              CustomSectionTitle(title: 'Profile'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    ProfileTextField(
                      validator: (value) {
                        print('value: $value');
                        return FormValidation.validateName(value!);
                      },
                      fieldController: _nameController,
                      onPressed: () async {
                        print('name Controller text: ${_nameController.text}');
                        await BlocProvider.of<ProfileCubit>(context)
                            .updateName(newName: _nameController.text);
                      },
                    ),
                    Divider(),
                    ProfileTextField(
                      validator: (value) {
                        print('value: $value');
                        return FormValidation.validateEmail(value!);
                      },
                      fieldController: _emailController,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                              emailController: _emailController),
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomSectionTitle(title: 'Style'),
              BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
                builder: (context, state) {
                  int? indexFont =
                      BlocProvider.of<ChangeSettingsCubit>(context).fontIndex;

                  int indexTheme = context.read<ChangeSettingsCubit>().theme ==
                          Brightness.light
                      ? 1
                      : context.read<ChangeSettingsCubit>().theme ==
                              Brightness.dark
                          ? 2
                          : 3;
                  return Container(
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            CustomDropdownMenu(
                                onSelected: (value) {
                                  BlocProvider.of<ChangeSettingsCubit>(context)
                                      .changeTheme(value);
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
      },
    );
  }
}
