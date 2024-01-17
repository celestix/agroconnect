import 'package:flutter/material.dart';

class Theme {
  late final Color primaryColor;
  late final Color primaryColorLight;
  late final Color secondaryColor;
  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color titleTextColor;
}

class LightTheme implements Theme {
  static const _pCR = 5;
  static const _pCG = 177;
  static const _pCB = 12;

  @override
  Color primaryColor = const Color.fromRGBO(_pCR, _pCG, _pCB, 1);

  @override
  Color primaryColorLight = const Color.fromRGBO(33, 189, 39, 1);

  @override
  Color primaryTextColor = Colors.black;

  @override
  Color secondaryColor = const Color.fromRGBO(_pCR, _pCG, _pCB, 0.2);

  @override
  Color secondaryTextColor = const Color.fromRGBO(141, 141, 142, 1);

  @override
  Color titleTextColor = const Color.fromRGBO(59, 77, 85, 1);
}
