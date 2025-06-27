import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailsAppBar extends StatefulWidget {
  const BookDetailsAppBar({super.key, required this.bookId});
  final String bookId;

  @override
  State<BookDetailsAppBar> createState() => _BookDetailsAppBarState();
}

class _BookDetailsAppBarState extends State<BookDetailsAppBar> {
  @override
  void initState() {
    super.initState();
    // جلب القائمة عند بدء الـ Widget
    BlocProvider.of<BookMarksCubit>(context).fetchBookMark();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: CircleAvatar(
              backgroundColor: kSecondaryColor.withOpacity(0.8),
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios_new,
                // size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
