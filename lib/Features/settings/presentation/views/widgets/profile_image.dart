import 'dart:io';

import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/camera_icon.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_bottom_sheet.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickImageCubit, PickImageState>(
      listener: (context, state) {
        if (state is PickImageFailure) {
          showSnackBar(context,
              message: state.message, color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        String? imagePath = (state is PickImageSuccess) ? state.path : null;
        if (state is PickImageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: InkWell(
            onTap: () async {
              imagePath == null || imagePath.isEmpty
                  ? await BlocProvider.of<PickImageCubit>(context)
                      .pickProfileImage()
                  : createCustomBotttomSheet(context);
            },
            child: imagePath == null || imagePath.isEmpty
                ? Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        radius: 70,
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      CameraIcon(),
                    ],
                  )
                : Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: FileImage(File(imagePath), scale: 1.0),
                        radius: 70,
                        key:
                            ValueKey(imagePath), // Force rebuild with new image
                      ),
                      CameraIcon(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
