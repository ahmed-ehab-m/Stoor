import 'dart:io';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_drop_menu.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/logout_button.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          showSnackBar(context, message: state.message, color: Colors.green);
        }
        if (state is ProfileFailure) {
          showSnackBar(context,
              message: state.message, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded) {
          print('ProfileLoaded in settings view body');

          print(BlocProvider.of<ProfileCubit>(context).userName);
          _emailController.text = state.user?.email ?? '';
          _nameController.text = state.user?.name ?? 'User';
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSizeHelper.horizontalPadding,
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<PickImageCubit, PickImageState>(
                listener: (context, state) {
                  if (state is PickImageSuccess) {
                    print(state.path);
                    print('Profile image changed');
                    showSnackBar(context,
                        message: 'Profile image changed', color: Colors.green);
                  }
                  if (state is PickImageFailure) {
                    print('Error: ${state.message}');
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
                              // key: ValueKey(imagePath),
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
                  _nameController.text == null || _nameController.text!.isEmpty
                      ? 'User'
                      : '${_nameController.text![0].toUpperCase() + _nameController.text!.substring(1)}',
                  style:
                      Styles.textStyle18.copyWith(fontWeight: FontWeight.w900),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'name',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'email',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password (required to update email)',
                        hintStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                        border: InputBorder.none,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: state is ProfileLoading
                          ? null
                          : () async {
                              print('Email: ${_emailController.text}');
                              print('Password: ${_passwordController.text}');
                              await BlocProvider.of<ProfileCubit>(context)
                                  .updateEmail(
                                newName: _nameController.text,
                                newEmail: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            },
                      child: state is ProfileLoading
                          ? CircularProgressIndicator()
                          : Text('Update Email'),
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
                                initialSelection: indexTheme!,
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
                                initialSelection: indexFont!,
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
                height: 50,
              ),
              Spacer(),
              LogoutButton(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
