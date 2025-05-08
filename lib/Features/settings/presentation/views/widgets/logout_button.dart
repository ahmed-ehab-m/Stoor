import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
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
    Widget buttonChild = const Text(' Logout');
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          print('Sign Out Success');
          GoRouter.of(context).pushReplacement(AppRouter.KLoginView);
        }
      },
      builder: (context, state) {
        if (state is SignOutLoading) {
          print('sign out loading');
          buttonChild = const CircularProgressIndicator();
        }
        if (state is SignOutFailure) {
          print('sign out failure');
          buttonChild = Text('Logout');
          showSnackBar(context, message: state.message, color: Colors.red);
        }
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            textStyle: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            backgroundColor: Colors.grey.withOpacity(0.1),
            foregroundColor:
                BlocProvider.of<ChangeThemeCubit>(context).iconColor,
          ),
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).signOut();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(HugeIcons.strokeRoundedLogout02),
              buttonChild,
            ],
          ),
        );
      },
    );
  }
}
