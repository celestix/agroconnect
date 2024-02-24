import 'package:FarmXpert/misc/theme.dart';
import 'package:FarmXpert/models/user_model.dart';
import 'package:flutter/material.dart';

class ConfigConstructor {
  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  late UserModel? user;

  ConfigConstructor({
    required this.navigatorKey,
    required this.scaffoldKey,
  });

  var chosenTheme = LightTheme();
}

late final ConfigConstructor config;
