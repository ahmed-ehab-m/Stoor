import 'dart:io';

import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    BlocProvider.of<PickImageCubit>(context).getProfileImagePath();
    BlocProvider.of<ProfileCubit>(context).loadProfile();

    super.initState();
  }

  List<BookModel> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String displayName = BlocProvider.of<ProfileCubit>(context).userName;
        print('user name in custom app bar  ${displayName}');
        if (state is ProfileLoaded) {
          print('ProfileLoadedddddddddddddddddddddddddd');
          print(state.user!.name);
          displayName = state.user!.name!;
        }
        return Row(
          children: [
            if (BlocProvider.of<PickImageCubit>(context).imagePath.isNotEmpty &&
                BlocProvider.of<PickImageCubit>(context).imagePath != null)
              BlocBuilder<PickImageCubit, PickImageState>(
                builder: (context, state) {
                  String imagePath =
                      BlocProvider.of<PickImageCubit>(context).imagePath;

                  return Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(imagePath)),
                        )),
                  );
                },
              ),
            SizedBox(
              width: 12,
            ),
            Text(
                'Hi,${displayName![0].toUpperCase() + displayName!.substring(1)}!',
                style:
                    Styles.textStyle18.copyWith(fontWeight: FontWeight.w900)),
            Spacer(),
            IconButton(
                onPressed: () {
                  searchResult = BlocProvider.of<FeaturedBooksCubit>(context)
                      .featuredBooks;
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
      },
    );
  }
}
