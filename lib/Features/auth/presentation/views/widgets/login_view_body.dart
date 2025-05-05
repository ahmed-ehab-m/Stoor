import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/account_check_row.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/submit_button.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isVisible = true;
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  Widget buttonChild = const Text('Login');
  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenSizeHelper.authVerticalPadding,
            horizontal: screenSizeHelper.horizontalPadding),
        child: Form(
          key: formkey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                buttonChild = const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              if (state is LoginFailure) {
                buttonChild = const Text('login');

                showSnackBar(context,
                    message: state.message, color: Colors.red);
              }
              if (state is LoginSuccess) {
                GoRouter.of(context).push(AppRouter.KMainView);
              }
            },
            builder: (context, state) {
              return Column(
                spacing: screenSizeHelper.screenHeight * 0.03,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Welcome Back !', style: Styles.textStyle40),
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    hintText: 'Email',
                    validator: (value) {
                      return FormValidation.validateEmail(value!);
                    },
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      password = value!;
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
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SubmitButton(
                      onPressed: () {
                        formkey.currentState!.save();
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .logIn(email: email, password: password);
                        }
                      },
                      buttonChild: buttonChild),
                  AccountCheckRow(
                    type: 'Sign Up',
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
