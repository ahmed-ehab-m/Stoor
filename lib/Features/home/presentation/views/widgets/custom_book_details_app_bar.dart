import 'package:bookly_app/Features/home/presentation/manager/book_marks_books_cubit/book_marks_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CusomBookDetailsAppBar extends StatefulWidget {
  const CusomBookDetailsAppBar({super.key, required this.bookId});
  final String bookId;

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
            color: kSecondaryColor,
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            )),
        BlocConsumer<BookMarksBooksCubit, BookMarksBooksState>(
          listener: (context, state) {
            if (state is AddBookMarksBooksSuccess) {
              setState(() {
                isBookmarked = true;
              });
            }
            if (state is AddBookMarksBooksFailure) {
              print('add to book marks failure ${state.errMessage}');
            }
          },
          builder: (context, state) {
            String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';
            return IconButton(
                onPressed: () {
                  BlocProvider.of<BookMarksBooksCubit>(context)
                      .addtoBookMarks(uid: uid, bookId: widget.bookId);
                },
                icon: Icon(
                  size: 25,
                  isBookmarked
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  color: isBookmarked
                      ? Colors.amber
                      : BlocProvider.of<ChangeSettingsCubit>(context).iconColor,
                ));
          },
        ),
      ],
    );
  }
}
