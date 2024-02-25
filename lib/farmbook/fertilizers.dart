import 'package:AgroConnect/misc/config.dart';
import 'package:flutter/material.dart';

class FarmBookPage extends StatefulWidget {
  const FarmBookPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FarmBookPageState();
}

class _FarmBookPageState extends State<FarmBookPage> {
  String _searchQuery = '';

  final List<Section> allSections = [
    Section(
      title: 'General Information',
      imagePath: 'assets/images/farmbook/Fert1.jpg',
      description:
          'Purpose: Fertilizers provide essential nutrients such as nitrogen (N), phosphorus (P), and potassium (K), as well as secondary nutrients (calcium, magnesium, sulfur) and micronutrients (iron, manganese, zinc) required for plant growth.\nApplication: Fertilizers can be applied to soil before planting (pre-plant fertilization), incorporated into the soil during planting, or applied to the foliage (foliar feeding).\nFormulation: Fertilizers come in various formulations, including granular, liquid, and soluble powders.\nSynthetic vs. Organic: Fertilizers can be synthetic (manufactured chemically) or organic (derived from natural sources such as compost, manure, or plant residues).\nNPK Ratio: Fertilizers are often labeled with their NPK ratio, indicating the percentage of nitrogen, phosphorus, and potassium they contain.',
    ),
    Section(
      title: 'Nitrogen Fertilizers:',
      imagePath: 'assets/images/farmbook/nitro.jpeg',
      description:
          'Nitrogen fertilisers provide nitrogen, which is essential for vegetative growth, leaf development, and overall plant health.\nCommon nitrogen fertilisers include urea, ammonium nitrate, ammonium sulphate, and calcium nitrate.',
    ),
    Section(
      title: 'Phosphorus Fertilizers:',
      imagePath: 'assets/images/farmbook/phosphate.jpeg',
      description:
          'Phosphorus fertilisers provide phosphorus, which is essential for root development, flowering, and fruiting. Common phosphorus fertilisers include superphosphate, triple superphosphate, and diammonium phosphate.',
    ),
    Section(
      title: 'Potassium Fertilizers:',
      imagePath: 'assets/images/farmbook/potash.jpeg',
      description:
          'Potassium fertilisers provide potassium, which is essential for overall plant health, water regulation, and disease resistance.\nCommon potassium fertilisers include potassium chloride (muriate of potash), potassium sulphate, and potassium nitrate.',
    ),
    Section(
      title: 'Complete Fertilizers:',
      imagePath: 'assets/images/farmbook/complete.jpeg',
      description:
          'Complete fertilisers contain nitrogen, phosphorus, and potassium in varying proportions, providing a balanced nutrient supply for plants.\nExamples include 10-10-10, 20-20-20, and 5-10-5 formulations.',
    ),
    Section(
      title: 'Slow-Release Fertilizers:',
      imagePath: 'assets/images/farmbook/slow.jpg',
      description:
          'Slow-release fertilisers release nutrients gradually over time, providing a steady supply of nutrients to plants and reducing the risk of nutrient leaching.\nThey can be synthetic or organic and include formulations such as coated granules, polymer-coated fertilisers, and organic fertilisers like compost.',
    ),
    Section(
      title: 'Liquid Fertilizers:',
      imagePath: 'assets/images/farmbook/liquid.jpeg',
      description:
          'Liquid fertilisers are dissolved in water and applied to soil or foliage through irrigation systems or spraying equipment.\nThey provide a quick nutrient uptake by plants and are suitable for both soil and foliar applications.',
    ),
    Section(
      title: 'Organic Fertilizers:',
      imagePath: 'assets/images/farmbook/organic.jpeg',
      description:
          'Organic fertilisers are derived from natural sources and provide nutrients in a slow-release form, improving soil structure and fertility over time.\nExamples include compost, manure, bone meal, fish emulsion, and seaweed extract.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Section> displayedSections = _searchQuery.isEmpty
        ? allSections
        : allSections.where((section) {
            return section.title.toLowerCase().contains(_searchQuery);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Fertilizers",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/farmbook/fert.jpg',
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search Section',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: displayedSections
                  .map<Widget>((section) => _buildDropdownSection(
                        title: section.title,
                        imagePath: section.imagePath,
                        description: section.description,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required String imagePath,
    required String description,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Section {
  final String title;
  final String imagePath;
  final String description;

  Section({
    required this.title,
    required this.imagePath,
    required this.description,
  });
}
