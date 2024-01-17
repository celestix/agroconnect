import 'package:FarmXpert/misc/theme.dart';
import 'package:flutter/material.dart';

class ConfigConstructor {
  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  ConfigConstructor({
    required this.navigatorKey,
    required this.scaffoldKey,
  });

  var chosenTheme = LightTheme();
}

late final ConfigConstructor config;
