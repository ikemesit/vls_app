import 'package:flutter/material.dart';
import 'package:vls_app/utils/constants/colors.dart';

class TFilledButtonTheme {
  TFilledButtonTheme._();

  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.white,
      backgroundColor: TColors.primary,
      disabledForegroundColor: TColors.grey,
      disabledBackgroundColor: TColors.grey,
      side: const BorderSide(color: TColors.primary),
      // padding: const EdgeInsets.symmetric(vertical: 18),
      // textStyle: const TextStyle(
      //   fontSize: 16.0,
      //   color: TColors.white,
      //   fontWeight: FontWeight.w600,
      // ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
    ),
  );

  static final darkFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      // padding: const EdgeInsets.symmetric(vertical: 18),
      // textStyle: const TextStyle(
      //   fontSize: 16.0,
      //   color: Colors.white,
      //   fontWeight: FontWeight.w600,
      // ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
    ),
  );
}
