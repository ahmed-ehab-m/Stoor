import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/assetsData.dart';
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
        if (state is LoginWithGoogleLoading) {
          print('loading');
        }
        if (state is LoginWithGoogleSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.KMainView);
        }
        if (state is LoginWithGoogleFailure) {
          showSnackBar(context, message: state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            // elevation: 5,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            side: BorderSide(color: Colors.black),
            minimumSize: const Size(double.infinity, 50),
            textStyle: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).loginWithGoogle();
          },
          // child: Text(buttonChild, style: AppStyles.textStyle22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/google.png'),
              Text('Sign in with Google',
                  style:
                      Styles.textStyle20.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Image.asset(
                AssetsData.googleIcon,
                scale: 3,
              ),
              // Icon(
              //   HugeIcons.strokeRoundedGoogle,
              //   size: 30,
              //   color: Colors.blue,
              // ),
            ],
          ),
        );
      },
    );
  }
}
