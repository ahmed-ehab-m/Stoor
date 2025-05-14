import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.firstOption,
    required this.secondOption,
    this.thridption,
    this.fourthOption,
    required this.initialSelection,
    this.onSelected,
  });
  final String firstOption;
  final String secondOption;
  final String? thridption;
  final String? fourthOption;
  final int initialSelection;
  final void Function(dynamic)? onSelected;
  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// Builds a custom dropdown menu with the given options.
  ///
  /// The [firstOption] and [secondOption] are always displayed,
  /// and [thridption] and [fourthOption] are displayed if they are not null.
  ///
  /// The [initialSelection] is the initial selected value.
  ///
  /// The [onSelected] is the callback function that will be called when an item is selected.
  ///
  /// The color of the icon is determined by the state of the [ChangeSettingsCubit].
  /// If the state is [ChangeSettingsStateThemeLight], the color is white,
  /// otherwise it is black.
  ///
  /// *****  bba8c0f3-1ddc-4f89-8c96-18d0c6fda857  ******
  Widget build(BuildContext context) {
    Color? color = BlocProvider.of<ChangeSettingsCubit>(context).iconColor;
    return DropdownMenu(
      onSelected: onSelected,
      textAlign: TextAlign.end,
      inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
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
        if (thridption != null)
          DropdownMenuEntry(
              value: 3, label: thridption!, style: buttonStyle(3, color)),
        if (fourthOption != null)
          DropdownMenuEntry(
              value: 4, label: fourthOption!, style: buttonStyle(4, color)),
      ],
    );
  }

  ButtonStyle buttonStyle(int value, Color? color) {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      backgroundColor: WidgetStateProperty.all(
        value == initialSelection ? Colors.indigo.withOpacity(0.2) : null,
      ),
      foregroundColor: WidgetStateProperty.all(
        value == initialSelection ? Colors.indigo : color,
      ),
    );
  }
}
