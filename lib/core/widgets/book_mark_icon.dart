import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarkIcon extends StatefulWidget {
  const BookMarkIcon(
      {super.key, required this.isBookmarked, required this.bookId});
  final bool isBookmarked;
  final String bookId;

  @override
  State<BookMarkIcon> createState() => _BookMarkIconState();
}

class _BookMarkIconState extends State<BookMarkIcon> {
  @override
  Widget build(BuildContext context) {
    String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';
    bool isBookmarked = widget.isBookmarked;
    return BlocConsumer<BookMarksBooksCubit, BookMarksState>(
      listener: (context, state) {},
      builder: (context, state) {
        print('first isBookmarked: $isBookmarked');
        // تحقق من القائمة المفضلة
        // تحويل id لـ String

        if (state is AddBookMarksLoading) {
          isBookmarked = state.bookId == widget.bookId;
          print('isBookmarked IN Loading: $isBookmarked');
        }
        if (state is AddBookMarksSuccess) {
          isBookmarked = true;
          print('isBookmarked IN Success: $isBookmarked');
        }
        if (state is DeleteBookMarksSuccess) {
          isBookmarked = false;
          print('isBookmarked IN Delete Success: $isBookmarked');
        }
        return CircleAvatar(
          backgroundColor: kPrimaryColor,
          child: IconButton(
            onPressed: () async {
              if (widget.isBookmarked) {
                // إذا موجود، احذفه
                await BlocProvider.of<BookMarksBooksCubit>(context)
                    .deleteBookMark(uid: uid, bookId: widget.bookId);
              } else {
                // إذا مش موجود، أضفه
                await BlocProvider.of<BookMarksBooksCubit>(context)
                    .addtoBookMarks(
                  uid: uid,
                  bookId: widget.bookId,
                );
              }
              // تحديث القائمة بعد العملية
              await BlocProvider.of<BookMarksBooksCubit>(context)
                  .fetchBookMark();
            },
            icon: Icon(
              size: 25,
              isBookmarked
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
              color: isBookmarked
                  ? Colors.amber
                  : BlocProvider.of<ChangeSettingsCubit>(context).iconColor,
            ),
          ),
        );
      },
    );
  }
}
