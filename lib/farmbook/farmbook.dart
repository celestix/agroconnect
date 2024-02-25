import 'dart:async';

import 'package:FarmXpert/farmbook/crops.dart';
import 'package:FarmXpert/farmbook/fertilizers.dart';
import 'package:FarmXpert/farmbook/pesticides.dart';
import 'package:FarmXpert/misc/config.dart';
import 'package:flutter/material.dart';

class FarmbookScreen extends StatefulWidget {
  const FarmbookScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FarmbookScreenState();
}

class _FarmbookScreenState extends State<FarmbookScreen> {
  List<String> imagePaths1 = [
    'assets/images/farmbook/farming.jpg',
    'assets/images/farmbook/fertilizer.jpg',
    'assets/images/farmbook/pesticide.jpeg',
    'assets/images/farmbook/crops.webp',
  ];

  List<String> imageTexts1 = [
    'Crops',
    'Fertilizers',
    'Pests and Diseases',
    'Organic Farming',
  ];

  List<String> newTexts = [
    'Agriculture is the Largest Employer in the World',
    'Nearly Everything We Eat and Wear is A Product of Agriculture',
    'Farmers Must Increase Their Food Production by 70% to Cater to the Growing Population by 2025',
    'One Acre of Farming Land is Equivalent to the Size of an American Football Field',
    '43% of the Global Agriculture Consists of Women',
    'Organic Farming Produces Ten Times the Profit of Conventional Farming',
    'The Majority of the Farms Worldwide are Family-Owned',
    'Pesticide Residues are Affecting Food Safety',
    'There is a Global Shortage of People Working in the Agriculture Sector',
    'Organic Food Production Does Not Involve the Use of Synthetic Fertilisers or Pesticides',
    'The Natural Pesticides Used in Organic Farming May Not Always Be The Best Thing for the Crops',
    'Industrial Farming Practices Carry the Risk of Spreading Viruses from Animals to Humans',
    'Around 9.2% of the Total Population of the World is Food Insecure'
  ];

  List<Widget> newpages = [
    const CropsPage(),
    const FarmBookPage(),
    const MarketplacePage(),
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late final Timer _timer;

  void _timerCallback(Timer timer) {
    _currentIndex = (_currentIndex + 1) % imageTexts1.length;
    _pageController.animateToPage(_currentIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), _timerCallback);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Farmbook",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: config.chosenTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.builder(
                itemCount: imagePaths1.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => newpages[index],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imagePaths1[index],
                              height: 100,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              imageTexts1[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 160,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.lightGreen[50],
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: newTexts.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          newTexts[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(_currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          });
        },
        items: imageTexts1.map((text) {
          return BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: text,
          );
        }).toList(),
      ),
    );
  }
}
