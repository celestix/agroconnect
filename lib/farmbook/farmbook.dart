import 'dart:async';

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
    'New Text 1',
    'New Text 2',
    'New Text 3',
    'New Text 4',
  ];

  List<Widget> newpages = [
    // const CropsPage(),
    // const FarmBookPage(),
    // const MarketplacePage(),
    // const CommunityPage(),
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
        title: const Text(
          'Farmbook',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
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
                    elevation: 10,
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
                      child: Text(
                        newTexts[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
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
