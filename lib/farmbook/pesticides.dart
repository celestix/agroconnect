import 'package:FarmXpert/misc/config.dart';
import 'package:flutter/material.dart';

class PesticideScreen extends StatefulWidget {
  const PesticideScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<PesticideScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pests and Diseases",
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
              'images/Pest.jpeg',
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
              children: [
                _buildDropdownSection(
                  title: 'Aphids (Pest):',
                  imagePath: 'images/Aphids.jpeg',
                  description:
                      'Aphids are small, soft-bodied insects that feed on plant sap by piercing the plant\'s tissues with their mouth. They can cause yellowing, curling, and distortion of leaves, as well as stunting of plant growth.',
                ),
                _buildDropdownSection(
                  title: 'Whiteflies (Pest):',
                  imagePath: 'images/Whitefly.jpeg',
                  description:
                      'Whiteflies are tiny, winged insects that feed on plant sap by sucking juices from leaves.Heavy infestations can lead to yellowing, wilting, and premature leaf drop, as well as the transmission of plant viruses.',
                ),
                _buildDropdownSection(
                  title: 'Thrips (Pest):',
                  imagePath: 'images/Thrips.jpeg',
                  description:
                      'Thrips are slender, winged insects that feed on plant tissues by rasping the surface and sucking up the released fluids.They cause stippling, silvering, and distortion of leaves, as well as damage to flowers and fruits.',
                ),
                _buildDropdownSection(
                  title: 'Spider Mites (Pest):',
                  imagePath: 'images/Spidermite.jpeg',
                  description:
                      'Spider mites are tiny arachnids that feed on plant sap by piercing the plant\'s cells with their mouth. They cause stippling, yellowing, and bronzing of leaves, as well as webbing on the plant surface.',
                ),
                _buildDropdownSection(
                  title: 'Caterpillars (Pest):',
                  imagePath: 'images/Caterpillars.jpeg',
                  description:
                      'Caterpillars are the larval stage of moths and butterflies and can feed on plant leaves, stems, and fruits. They cause holes and defoliation of leaves, as well as damage to fruits and flowers.',
                ),
                _buildDropdownSection(
                  title: 'Beetles (Pest):',
                  imagePath: 'images/Beetles.jpeg',
                  description:
                      'Various species of beetles, such as flea beetles, cucumber beetles, and Colorado potato beetles, can feed on plant foliage, roots, and fruits.They cause damage through chewing, skeletonization, and defoliation.',
                ),
                _buildDropdownSection(
                  title: 'Nematodes (Pest):',
                  imagePath: 'images/Nematodes.webp',
                  description:
                      'Plant-parasitic nematodes are microscopic roundworms that feed on plant roots, causing damage to the root system. They can result in stunted growth, wilting, yellowing, and reduced nutrient uptake in affected plants.',
                ),
                _buildDropdownSection(
                  title: 'Fungal Diseases (Disease):',
                  imagePath: 'images/Fungus.jpeg',
                  description:
                      'Fungal diseases, such as powdery mildew, downy mildew, and fungal leaf spots, are caused by various fungal pathogens. They can result in leaf discoloration, spots, wilting, mold growth, and tissue necrosis.',
                ),
                _buildDropdownSection(
                  title: 'Bacterial Diseases (Disease):',
                  imagePath: 'images/Bacteria.webp',
                  description:
                      'Bacterial diseases, such as bacterial blight, bacterial spot, and bacterial wilt, are caused by pathogenic bacteria. They can cause leaf spots, wilting, leaf drop, cankers, and systemic infection in plants.',
                ),
                _buildDropdownSection(
                  title: 'Viral Diseases (Disease):',
                  imagePath: 'images/Virus.webp',
                  description:
                      'Viral diseases, such as mosaic viruses, leaf curl viruses, and ringspot viruses, are caused by plant viruses transmitted by vectors such as insects, nematodes, and mites. They can cause leaf mottling, yellowing, stunting, deformity, and reduced yield in infected plants.',
                ),
                _buildDropdownSection(
                  title: 'Oomycete (Disease):',
                  imagePath: 'images/Oom.jpg',
                  description:
                      'Oomycete diseases, such as late blight and damping-off, are caused by organisms similar to fungi but belonging to a different taxonomic group. They can cause wilting, damping-off of seedlings, root rot, and foliar lesions in plants.',
                ),
              ],
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
    if (_searchQuery.isNotEmpty &&
        !title.toLowerCase().startsWith(_searchQuery)) {
      return const SizedBox();
    }

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
