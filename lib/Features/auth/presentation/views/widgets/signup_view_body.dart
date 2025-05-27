import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/account_check_row.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/google_button.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/submit_button.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:bookly_app/core/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final formkey = GlobalKey<FormState>();
  Widget buttonChild = const Text('Sign Up');
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              // vertical: screenSizeHelper.authVerticalPadding,
              horizontal: screenSizeHelper.horizontalPadding),
          child: Form(
            key: formkey,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignUpLoading) {
                  buttonChild = const CircularProgressIndicator(
                    color: Colors.white,
                  );
                }
                if (state is SignUpFailure) {
                  buttonChild = const Text('Sign Up');
                  showSnackBar(context,
                      message: state.message, color: Colors.red);
                }
                if (state is SignUpSuccess) {
                  GoRouter.of(context).pushReplacement(AppRouter.KLoginView);
                }
              },
              builder: (context, state) {
                return Column(
                  spacing: screenSizeHelper.screenHeight * 0.02,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLogo(),
                    Center(
                      child: Column(
                        children: [
                          Text('Create an Account', style: Styles.textStyle40),
                          Text('Start Your Reading Journey',
                              style: Styles.textStyle24.copyWith(
                                fontFamily: 'DancingScript-VariableFont_wght',
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSizeHelper.screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            onSaved: (value) {
                              firstName = value!;
                            },
                            hintText: 'First Name',
                            validator: (value) {
                              return FormValidation.validateName(value!);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            onSaved: (value) {
                              lastName = value!;
                            },
                            hintText: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        email = value!;
                      },
                      hintText: 'Enter Your Email',
                      validator: (value) {
                        return FormValidation.validateEmail(value!);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        return FormValidation.validatePassword(value!);
                      },
                      hintText: 'Enter Your Password',
                      obscureText:
                          BlocProvider.of<AuthCubit>(context).isVisible,
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
                      height: screenSizeHelper.screenHeight * 0.01,
                    ),
                    SubmitButton(
                        onPressed: () async {
                          formkey.currentState!.save();
                          if (formkey.currentState!.validate()) {
                            await BlocProvider.of<AuthCubit>(context).signUp(
                                email: email,
                                password: password,
                                name: '$firstName $lastName');
                          }
                        },
                        buttonChild: buttonChild),
                    Text('Or', style: Styles.textStyle20),
                    GoogleButton(),
                    AccountCheckRow(
                      type: 'Login',
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.KLoginView);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
