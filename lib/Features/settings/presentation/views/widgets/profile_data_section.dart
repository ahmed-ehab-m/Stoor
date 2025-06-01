import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_alert_dialog.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/custom_section_title.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_image.dart';
import 'package:bookly_app/Features/settings/presentation/views/widgets/profile_text_field.dart';
import 'package:bookly_app/core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileDataSection extends StatefulWidget {
  const ProfileDataSection({super.key});

  @override
  State<ProfileDataSection> createState() => _ProfileDataSectionState();
}

class _ProfileDataSectionState extends State<ProfileDataSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          _emailController.text = state.user?.email ?? '';
          _nameController.text = state.user?.name ?? 'User';
        }
        if (state is ProfileFailure) {
          showSnackBar(context, message: state.message, color: Colors.red);
        }
      },
      child: Column(
        children: [
          ProfileImage(),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              _nameController.text.isEmpty
                  ? 'User'
                  : _nameController.text[0].toUpperCase() +
                      _nameController.text.substring(1),
              style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          CustomSectionTitle(title: 'Profile'),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                ProfileTextField(
                  iconData: HugeIcons.strokeRoundedUser,
                  validator: (value) {
                    return FormValidation.validateName(value!);
                  },
                  fieldController: _nameController,
                  onPressed: () async {
                    await BlocProvider.of<ProfileCubit>(context)
                        .updateName(newName: _nameController.text);
                  },
                ),
                Divider(),
                ProfileTextField(
                  iconData: HugeIcons.strokeRoundedMail01,
                  validator: (value) {
                    return FormValidation.validateEmail(value!);
                  },
                  fieldController: _emailController,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomAlertDialog(emailController: _emailController),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
