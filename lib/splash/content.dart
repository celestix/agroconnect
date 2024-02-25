import 'package:AgroConnect/misc/config.dart';
import 'package:flutter/material.dart';

class SplashScreenContent {
  late String heading1;
  late Color heading1Color;
  late String heading2;
  late Color heading2Color;
  late String description;
}

// TODO: Make it use RichTexField
List<SplashScreenContent> content = [
  SplashScreenContent()
    ..heading1 = "Empowering Farmers,"
    ..heading1Color = config.chosenTheme.primaryTextColor
    ..heading2 = "Enriching Harvests"
    ..heading2Color = config.chosenTheme.primaryColor
    ..description =
        "Your One-Stop Solution for Crop Sales, Seed Purchases, and Farming Wisdom.",
  SplashScreenContent()
    ..heading1 = "FarmBook: Your Digital"
    ..heading1Color = config.chosenTheme.primaryTextColor
    ..heading2 = "Farming Companion"
    ..heading2Color = config.chosenTheme.primaryColor
    ..description =
        "Unlock the Secrets of Successful Farming, Right at Your Fingertips",
  SplashScreenContent()
    ..heading1 = "Bridging Farmers"
    ..heading1Color = config.chosenTheme.primaryColor
    ..heading2 = "and Markets"
    ..heading2Color = config.chosenTheme.primaryTextColor
    ..description =
        "Seamless Crop Sales, Reliable Seed Purchases, and a Community of Agri-Enthusiasts"
];
