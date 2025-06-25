import 'dart:io';

import 'package:bookly_app/Features/home/presentation/manager/all_books_cubit/all_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  List<BookModel> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String displayName = BlocProvider.of<ProfileCubit>(context).userName;
        if (state is ProfileLoaded) {
          displayName = state.user?.name ?? 'User';
        }
        return BlocBuilder<PickImageCubit, PickImageState>(
          builder: (context, state) {
            String imagePath =
                BlocProvider.of<PickImageCubit>(context).imagePath;
            if (state is PickImageSuccess) {
              imagePath = state.path;
            }
            return Column(
              children: [
                Row(
                  spacing: 8,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (BlocProvider.of<PickImageCubit>(context)
                        .imagePath
                        .isNotEmpty)
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(imagePath)),
                            )),
                      ),
                    Text(
                      'Hi,${displayName[0].toUpperCase() + displayName.substring(1)}',
                      style: Styles.textStyle18
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          searchResult =
                              BlocProvider.of<AllBooksCubit>(context).allBooks;
                          GoRouter.of(context)
                              .push(AppRouter.KSearchView, extra: searchResult);
                        },
                        icon: const Icon(
                          HugeIcons.strokeRoundedSearch01,
                          size: 20,
                          // color: kPrimaryColor,
                        ))
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
