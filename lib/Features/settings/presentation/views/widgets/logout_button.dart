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
          GoRouter.of(context).pushReplacement(AppRouter.KSignupView);
        }
      },
      builder: (context, state) {
        if (state is SignOutLoading) {
          buttonChild = const CircularProgressIndicator();
        }
        if (state is SignOutFailure) {
          buttonChild = const Text('Log out');
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
            // fetchBooks();
            // await fetchBooksWithDio();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
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

// Future<void> fetchBooksWithDio() async {
//   final dio = Dio();
//   final cookieJar = CookieJar();
//   dio.interceptors.add(CookieManager(cookieJar));

//   try {
//     // أول طلب عشان تجيب الكوكيز
//     await dio.get('https://hadeer.wuaze.com/api/v1/books/lowest-rated?i=1');

//     // تاني طلب هيكون معاه الكوكيز المطلوبة
//     final response =
//         await dio.get('https://hadeer.wuaze.com/api/v1/books/lowest-rated?i=1');
//     print('Response: ${response.data}');
//   } catch (e) {
//     print('Error: $e');
//   }
// }

// void fetchBooks() async {
//   try {
//     var response = await http.get(
//       Uri.parse('https://hadeer.wuaze.com/api/v1/books/lowest-rated?i=1'),
//       headers: {
//         'Accept': 'application/json',
//         'User-Agent':
//             'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
//         'Accept-Language': 'en-US,en;q=0.9',
//         'Cookie': '__test=530bd8f48f46286caefa530fefc50749',
//       },
//     );
//     print('Response: ${response.body}');
//   } catch (e) {
//     print('Error: $e');
//   }
// }
