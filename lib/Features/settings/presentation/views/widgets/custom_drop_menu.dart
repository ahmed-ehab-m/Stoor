import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.thridption,
    required this.initialSelection,
    this.onSelected,
  });
  final String firstOption;
  final String secondOption;
  final String thridption;
  final int initialSelection;
  final void Function(dynamic)? onSelected;
  @override
  Widget build(BuildContext context) {
    Color? color = BlocProvider.of<ChangeSettingsCubit>(context).iconColor;
    return DropdownMenu(
      onSelected: onSelected,
      textAlign: TextAlign.end,
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      menuStyle: MenuStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      width: 200,
      initialSelection: initialSelection,
      dropdownMenuEntries: [
        DropdownMenuEntry(
            value: 1, label: firstOption, style: buttonStyle(1, color)),
        DropdownMenuEntry(
            value: 2, label: secondOption, style: buttonStyle(2, color)),
        DropdownMenuEntry(
            value: 3, label: thridption, style: buttonStyle(3, color)),
      ],
    );
  }

  ButtonStyle buttonStyle(int value, Color? color) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      backgroundColor: WidgetStateProperty.all(
        value == initialSelection
            ? const Color(0xFF9C27B0).withOpacity(0.3)
            : null,
      ),
    );
  }
}
