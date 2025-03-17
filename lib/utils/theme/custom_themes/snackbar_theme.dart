import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TSnackBarTheme {
  TSnackBarTheme._();

  static const lightAppBarTheme = SnackBarThemeData(
    elevation: 0,
    backgroundColor: TColors.primary,
    actionTextColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    contentTextStyle: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600),
  );
}