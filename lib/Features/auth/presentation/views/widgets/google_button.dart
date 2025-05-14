import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/auth/presentation/views/widgets/button_child_intial.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginWithGoogleLoading) {}
        if (state is LoginWithGoogleSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.KMainView);
        }
        if (state is LoginWithGoogleFailure) {
          showSnackBar(context, message: state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        Widget buttonChild = ButtonChildIntial();
        if (state is LoginWithGoogleLoading) {
          buttonChild = CircularProgressIndicator();
        }
        if (state is LoginWithGoogleSuccess) {
          buttonChild = ButtonChildIntial();
        }
        if (state is LoginWithGoogleFailure) {
          buttonChild = ButtonChildIntial();
        }

        var elevatedButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: Colors.black),
            minimumSize: const Size(double.infinity, 50),
            textStyle: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).loginWithGoogle();
          },
          child: buttonChild,
        );
        return elevatedButton;
      },
    );
  }
}
