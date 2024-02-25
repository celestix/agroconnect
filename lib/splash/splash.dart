import 'package:AgroConnect/misc/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:AgroConnect/splash/content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int page = 0;

  InkWell getDot(int index) {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.only(left: 4.25, right: 4.25),
        child: Container(
          width: page == index ? 16 : 10,
          height: page == index ? 16 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: page == index
                ? config.chosenTheme.primaryColor
                : config.chosenTheme.secondaryColor,
          ),
        ),
      ),
    );
  }

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: deviceSize.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: deviceSize.width / 27,
                      color: config.chosenTheme.primaryColorLight,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, "/login"),
                ),
              ],
            ),
            SizedBox.square(
              dimension: deviceSize.height / 40,
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    page = index;
                  });
                },
                itemCount: content.length,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      // Bound the splash images in a sized box to prevent uneven scaling on page change
                      SizedBox(
                        height: deviceSize.height / 1.9,
                        width: deviceSize.width,
                        child: SvgPicture.asset(
                          "assets/images/splash/${i + 1}.svg",
                        ),
                      ),
                      SizedBox.square(
                        dimension: deviceSize.height / 30,
                      ),
                      Column(
                        children: [
                          Text(
                            content[i].heading1,
                            style: TextStyle(
                              height: 1.1,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w900,
                              fontSize: deviceSize.width / 13.2,
                              letterSpacing: 0.1,
                              color: content[i].heading1Color,
                            ),
                          ),
                          Text(
                            content[i].heading2,
                            style: TextStyle(
                              height: 1.5,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w900,
                              fontSize: deviceSize.width / 13.2,
                              letterSpacing: 0.1,
                              color: content[i].heading2Color,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: deviceSize.width / 20,
                          left: deviceSize.width / 15,
                          right: deviceSize.width / 15,
                          bottom: deviceSize.width / 36,
                        ),
                        child: Text(
                          content[i].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.1,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: deviceSize.width / 32,
                            letterSpacing: 0.01,
                            color: config.chosenTheme.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                controller: _controller,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                    const SizedBox(
                      width: 123,
                    )
                  ] +
                  List.generate(content.length, (index) => getDot(index)) +
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: InkWell(
                        onTap: () {
                          if (page == content.length - 1) {
                            Navigator.pushNamed(context, "/login");
                            return;
                          }
                          _controller.animateToPage(
                            page + 1,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          width: 53,
                          height: 53,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: config.chosenTheme.primaryColor,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
