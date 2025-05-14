import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = const Text(' Log out');
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.KLoginView);
        }
      },
      builder: (context, state) {
        if (state is SignOutLoading) {
          buttonChild = const CircularProgressIndicator();
        }
        if (state is SignOutFailure) {
          buttonChild = Text('Log out');
          showSnackBar(context, message: state.message, color: Colors.red);
        }
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white),
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).signOut();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                HugeIcons.strokeRoundedLogout02,
                size: 25,
              ),
              buttonChild,
            ],
          ),
        );
      },
    );
  }
}
