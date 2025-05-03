import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CusomBookDetailsAppBar extends StatefulWidget {
  const CusomBookDetailsAppBar({super.key});

  @override
  State<CusomBookDetailsAppBar> createState() => _CusomBookDetailsAppBarState();
}

class _CusomBookDetailsAppBarState extends State<CusomBookDetailsAppBar> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        IconButton(
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
            icon: Icon(
              isBookmarked
                  ? FontAwesomeIcons.solidBookmark
                  : FontAwesomeIcons.bookmark,
              color: isBookmarked
                  ? Colors.amber
                  : BlocProvider.of<ChangeThemeCubit>(context).iconColor,
            )),
      ],
    );
  }
}
