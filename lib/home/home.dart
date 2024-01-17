import 'package:FarmXpert/misc/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageTexts = [
    'ChatBot',
    'FarmBook',
    'Community',
    'Marketplace',
    'Weather',
    'Govt. Policies',
  ];

  // List<Widget> pages = [
  // const ChatbotPage(),
  // const FarmBookPage(),
  // const CommunityPage(),
  // const MarketplacePage(),
  // const WeatherPage(),
  // const DocumentsPage(),
  // Add other page instances for each image
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FarmXpert",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 10,
        backgroundColor: config.chosenTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.transparent,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: config.chosenTheme.primaryColorLight,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/farmer.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.phoneNumber!,
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      config.scaffoldKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text("Logged out successfully"),
                        ),
                      );
                      await config.navigatorKey.currentState!
                          .pushNamedAndRemoveUntil(
                        "/splash",
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: config.chosenTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w600,
                        height: -0.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Divider(
                  height: MediaQuery.of(context).size.height / 100,
                  thickness: 0.25,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: const Icon(
                        Icons.agriculture,
                        size: 50,
                      ),
                      applicationName: "FarmXpert",
                      applicationVersion: "1.0.0",
                      children: [
                        const Text(
                          "FarmXpert is a mobile application made for the farmers. It is a one stop solution for all the problems faced by the farmers. It is made with the aim to help the farmers in every possible way.",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    );
                  },
                  child: const Text(
                    "About",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        child: GridView.builder(
          itemCount: 6,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  // // Navigate to the corresponding page when an image is tapped
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => pages[index],
                  //   ),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/home/${imageTexts[index]}.png",
                      height: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      imageTexts[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SF Pro Display",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
