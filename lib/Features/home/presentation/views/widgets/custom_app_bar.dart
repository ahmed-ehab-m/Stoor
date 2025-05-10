import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    getUserName();
    super.initState();
  }

  List<BookModel> searchResult = [];
  String? userName = 'gg';
  void getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(kUserName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Hi,${userName![0].toUpperCase() + userName!.substring(1)}!',
            style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w900)),
        Spacer(),
        IconButton(
            onPressed: () {
              searchResult =
                  BlocProvider.of<FeaturedBooksCubit>(context).featuredBooks;
              print(searchResult.length);
              GoRouter.of(context)
                  .push(AppRouter.KSearchView, extra: searchResult);
            },
            icon: Icon(
              HugeIcons.strokeRoundedSearch01,
              size: 20,
            ))
      ],
    );
  }
}
