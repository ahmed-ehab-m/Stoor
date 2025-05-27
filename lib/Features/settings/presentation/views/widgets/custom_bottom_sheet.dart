import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_image_choice.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void createCustomBotttomSheet(BuildContext context) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(''),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(HugeIcons.strokeRoundedCancel01),
                ),
                Expanded(
                  child: Text(
                    'Profile Photo',
                    style: Styles.textStyle24.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomImageChoice(
                  choiceName: 'Gallery',
                  iconData: HugeIcons.strokeRoundedImage01,
                  onTap: () async {
                    await BlocProvider.of<PickImageCubit>(context)
                        .pickProfileImage();
                    Navigator.pop(context);
                  },
                ),
                CustomImageChoice(
                  choiceName: 'Remove',
                  iconData: HugeIcons.strokeRoundedImageDelete01,
                  onTap: () async {
                    await BlocProvider.of<PickImageCubit>(context)
                        .removeProfileImage();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
