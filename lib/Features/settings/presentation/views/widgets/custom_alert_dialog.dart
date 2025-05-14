import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          emailController.text = state.user?.email ?? '';
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        String errorMessage = '';
        Widget buttonWidget = Row(
          spacing: 5,
          children: [
            Icon(
              HugeIcons.strokeRoundedPencilEdit01,
            ),
            Text('Update',
                style: Styles.textStyle18.copyWith(
                  color: kPrimaryColor,
                )),
          ],
        );
        if (state is ProfileLoading) {
          buttonWidget = Row(
            spacing: 5,
            children: [
              Icon(
                HugeIcons.strokeRoundedPencilEdit01,
              ),
              Text('Updating...',
                  style: Styles.textStyle18.copyWith(
                    color: kPrimaryColor,
                  )),
            ],
          );
        }

        if (state is ProfileFailure) {
          errorMessage = state.message;
          buttonWidget = Row(
            spacing: 5,
            children: [
              Icon(
                HugeIcons.strokeRoundedPencilEdit01,
                // color: kPrimaryColor,
              ),
              Text('Update',
                  style: Styles.textStyle18.copyWith(
                      // color: Colors.red,
                      )),
            ],
          );
        }
        return AlertDialog(
          title: Text(
            'Update Email',
            style: Styles.textStyle24
                .copyWith(fontWeight: FontWeight.w900, color: kPrimaryColor),
          ),
          content: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: passwordController,
                    onSaved: (value) {
                      // password = value!;
                    },
                    validator: (value) {
                      return FormValidation.validatePassword(value!);
                    },
                    hintText: 'Password',
                    obscureText: BlocProvider.of<AuthCubit>(context).isVisible,
                    suffixIcon: IconButton(
                      onPressed:
                          BlocProvider.of<AuthCubit>(context).togglePassword,
                      icon: Icon(
                        BlocProvider.of<AuthCubit>(context).suffixIcon,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    errorMessage,
                    style: Styles.textStyle14.copyWith(color: Colors.red),
                  ),
                ],
              );
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Styles.textStyle18.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Styles.textStyle30
                        .copyWith(fontWeight: FontWeight.bold),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    await BlocProvider.of<ProfileCubit>(context).updateEmail(
                      newEmail: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                  child: buttonWidget,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
