import 'package:AgroConnect/misc/config.dart';
import 'package:flutter/material.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Crops",
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
              'assets/images/farmbook/crops.webp',
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
              children: _buildFilteredSections(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilteredSections() {
    List<Widget> sections = [];

    _addSection(
      sections,
      title: 'Wheat',
      imagePath: 'assets/images/farmbook/Wheat.jpg',
      description:
          'Wheat is one of the most widely consumed grains globally and a staple food for a significant portion of the worlds population. It belongs to the Triticum genus and is cultivated in various regions worldwide. Here is some information about wheat and its different types:\nGeneral Information about Wheat:\n1.Botanical Classification: Wheat belongs to the family Poaceae (grasses) and the genus Triticum.\n2.Origin: Wheat cultivation dates back thousands of years, with evidence suggesting its domestication in the Fertile Crescent of the Middle East.\n3.Nutritional Profile: Wheat is a good source of carbohydrates, proteins, dietary fiber, vitamins (such as B vitamins), and minerals (like iron and magnesium).\nTypes of Wheat:\n1.Common Wheat (Triticum aestivum):\nAlso known as bread wheat, it is the most widely cultivated species of wheat globally. Common wheat is further classified into hard wheat (durum wheat) and soft wheat, depending on the hardness of its kernels.Hard wheat is used for making bread and pasta due to its high gluten content, while soft wheat is used for pastries and cakes.\n2.Durum Wheat (Triticum durum):\nDurum wheat has a high protein content and a hard texture, which makes it suitable for pasta production.\n3.Emmer Wheat (Triticum dicoccum):\nAlso known as farro, emmer wheat is an ancient grain with a nutty flavor.It has a high protein and fiber content and is often used in salads, soups, and stews.',
    );
    _addSection(
      sections,
      title: 'Corn',
      imagePath: 'assets/images/farmbook/Corn.webp',
      description:
          'Corn, also known as maize, is a cereal grain that originated in southern Mexico thousands of years ago and has since become one of the worlds most important crops. Here is some information about corn and its different types:\nGeneral Information about Corn:\n1.Botanical Classification: Corn belongs to the grass family Poaceae and the species Zea mays.\n2.Origin: Domesticated from a wild grass called teosinte, corn has been cultivated by indigenous peoples in the Americas for millennia.\n3.Nutritional Profile: Corn is rich in carbohydrates, dietary fiber, vitamins (such as vitamin C, thiamine, and folate), and minerals (like potassium and magnesium).\n4.Uses: Corn is used for various purposes, including human consumption (as a vegetable, grain, or processed into products like cornmeal and corn syrup), animal feed, industrial products (such as ethanol and bioplastics), and as a decorative plant.\nTypes of Corn:\n1.Field Corn (Zea mays indentata):\nAlso known as dent corn or feed corn, it is the most widely grown type of corn in the United States. Field corn is primarily used as livestock feed and in the production of corn-based products such as cornmeal, corn oil, and corn syrup. Its kernels have a dent or dimple at the top, which gives it the name "dent corn."\n2.Sweet Corn (Zea mays saccharata/rugosa):\nSweet corn is harvested when the kernels are immature, tender, and sweet. It is commonly consumed as a vegetable and is a popular ingredient in salads, stir-fries, and side dishes. Unlike field corn, sweet corn has a higher sugar content due to a gene mutation that prevents the conversion of sugar to starch.\n3.Flint Corn (Zea mays indurata):\nAlso known as Indian corn or calico corn, flint corn has hard, glossy kernels with a range of colours, including red, yellow, blue, and white. Flint corn is primarily used for ornamental purposes, such as decoration during the fall season, but it can also be ground into flour or used for livestock feed.\n4.Popcorn (Zea mays everta):\nPopcorn is a type of corn with a hard, moisture-sealed hull that contains a dense starchy interior. When heated, the moisture inside the kernel turns into steam, causing the kernel to explode and puff up. Popcorn is a popular snack food and is often seasoned with salt, butter, or other flavourings.\n5.Pod Corn:\nPod corn is a type of corn with irregularly shaped kernels that are enclosed in leaf-like structures, resembling pods. It is primarily used for ornamental purposes and is not commonly cultivated for human or animal consumption.',
    );
    _addSection(
      sections,
      title: 'Rice',
      imagePath: 'assets/images/farmbook/Rice.webp',
      description:
          'Information on rice:\n1.Botanical Classification: Rice is the seed of the grass species Oryza sativa (Asian rice) or Oryza glaberrima (African rice).\n2.Origin: Rice cultivation has been traced back thousands of years, with evidence of its domestication in Asia, particularly in regions such as China and India.\n3.Nutritional Profile: Rice is a staple food for a large portion of the world\'s population and is a good source of carbohydrates. Depending on the variety, it can also provide essential nutrients like vitamins and minerals.\n4.Cultural Significance: Rice plays a significant role in various cultures and cuisines worldwide, serving as a primary ingredient in a wide range of dishes, from savory to sweet.\nTypes of Rice:\n1.Basmati Rice:\nBasmati rice is a long-grain rice known for its distinct aroma and flavor. It is commonly grown in the Indian subcontinent and some other regions. Basmati rice grains elongate when cooked and have a fluffy texture, making them ideal for dishes like biryani and pilaf.\n2.Jasmine Rice:\nJasmine rice is a fragrant long-grain rice primarily grown in Thailand and other Southeast Asian countries. It has a subtle floral aroma and a slightly sticky texture when cooked. Jasmine rice is often served alongside Thai curries and other Asian dishes.\n3.Arborio Rice:\nArborio rice is a short-grain rice with a high starch content, commonly cultivated in Italy. It is best known for its use in risotto. Arborio rice absorbs liquid well while retaining a firm texture.\n4.Brown Rice:\nBrown rice is a whole grain rice with only the outer hull removed, leaving the bran and germ intact. It is higher in fiber, vitamins, and minerals compared to white rice. Brown rice has a nuttier flavor and chewier texture than white rice and is considered a healthier option.',
    );
    _addSection(
      sections,
      title: 'Barley',
      imagePath: 'assets/images/farmbook/Barley.webp',
      description:
          'Information about Barley:\n1.Botanical Classification: Barley belongs to the grass family Poaceae and the genus Hordeum.\n2.Origin: Barley is one of the oldest cultivated grains, with evidence of its domestication dating back to ancient times in the Fertile Crescent region of the Middle East.\n3.Cultivation: Barley is grown in various regions worldwide, including Europe, North America, Asia, and Australia. It is adaptable to a range of climates and soil conditions.\n4.Nutritional Profile: Barley is a nutritious grain rich in carbohydrates, dietary fiber, and protein. It also contains vitamins (such as B vitamins) and minerals (like manganese, selenium, and phosphorus).\n5.Uses: Barley has diverse uses, including human consumption, animal feed, brewing (for beer and whisky production), and as a cover crop or forage crop.\nTypes of Barley:\n1.Two-Row Barley (Hordeum distichon):\nTwo-row barley is a type of barley with two rows of seeds on its seed head (spike). It is commonly used in brewing beer due to its lower protein content and higher enzyme levels, which contribute to better malt extract yields.\n2.Six-Row Barley (Hordeum vulgare):\nSix-row barley has six rows of seeds on its seed head, arranged in three spikes per node. This type of barley tends to have higher protein content and is often used in animal feed and forage production.\n3.Hulled Barley (Hordeum vulgare var. hexastichon):\nHulled barley, also known as covered barley, retains its outer hull, which must be removed before consumption. It has a chewy texture and nutty flavour and is commonly used in soups, stews, salads, and pilafs.\n4.Barley Flour:\nBarley flour is ground from barley grains and is used as an alternative to wheat flour in baking. It has a slightly sweet and nutty flavor and can be used to make bread, pancakes, muffins, and other baked goods.',
    );
    _addSection(
      sections,
      title: 'Soybean',
      imagePath: 'assets/images/farmbook/Soybean.webp',
      description:
          'Infromation on Soybean:\n1.Botanical Classification: Soybeans belong to the legume family Fabaceae and the genus Glycine, with the scientific name Glycine max.\n2.Origin: Soybeans are native to East Asia and have been cultivated for thousands of years, primarily in China. They were introduced to other parts of the world, including North and South America, during the 18th and 19th centuries.\n3.Cultivation:Cultivation: Soybeans are grown in many countries worldwide, with the largest producers including the United States, Brazil, Argentina, and China. They are adaptable to various climates and soil types.\n4.Nutritional Profile: Soybeans are a rich source of protein, containing all essential amino acids, as well as dietary fiber, vitamins (such as B vitamins), minerals (like iron, calcium, and magnesium), and healthy fats.\n5.Uses: Soybeans have diverse uses, including human consumption (as whole beans, tofu, tempeh, soy milk, and soy sauce), animal feed, industrial applications (such as soybean oil for cooking and biodiesel production), and as a component in various processed foods.\nTypes of Soybean:\n1.Edamame:\nEdamame are young, green soybeans harvested at an early stage of development, typically before they fully mature. They are commonly boiled or steamed and served as a snack or appetizer, often seasoned with salt or other flavourings.\n2.Yellow Soybeans:\nYellow soybeans are the most common type of soybeans grown worldwide. They have a yellow or beige colour and are used for a variety of purposes, including tofu production, soy milk, soy sauce, and as a source of oil.\n3.Black Soybeans:\nBlack soybeans have a darker colour compared to yellow soybeans, with a black or dark brown outer skin. They are often used in East Asian cuisine and are known for their slightly sweeter flavor compared to other soybean varieties.',
    );
    _addSection(
      sections,
      title: 'Cotton',
      imagePath: 'assets/images/farmbook/Cotton.jpeg',
      description:
          'General Information about Cotton:\n1.Botanical Classification: Cotton belongs to the family Malvaceae and the genus Gossypium.\n2.Origin: Cotton is believed to have been domesticated around 6000 BC in the Indian subcontinent and later spread to other regions.\n3.Cultivation: Cotton is grown in warm climates around the world and requires adequate sunlight, water, and well-drained soil.\n4.Fiber: Cotton is valued for its soft, fluffy fiber, known as lint, which grows in protective capsules called bolls on the cotton plant.\n5.Uses: Cotton fiber is used to make a variety of textile products, including clothing, bed linens, towels, and industrial textiles. Additionally, cottonseed is used to produce oil for cooking and animal feed.\nTypes of Cotton:\n1.Upland Cotton (Gossypium hirsutum):\nUpland cotton is the most widely cultivated species of cotton globally, accounting for the majority of cotton production.It has relatively short fibres compared to other types of cotton, but it is known for its versatility and durability.\n2.Pima Cotton (Gossypium barbadense):\nPima cotton, also known as extra-long staple (ELS) cotton, is prized for its exceptionally long and strong fibres.It is grown primarily in the southwestern United States, Peru, and Australia. Pima cotton produces high-quality, luxurious textiles with a silky feel and excellent drape.\n3.Sea Island Cotton (Gossypium barbadense):\nSea Island cotton is another type of extra-long staple cotton, similar to Pima cotton. It is cultivated in the Caribbean, particularly on the Sea Islands of South Carolina, as well as in some other tropical regions. Sea Island cotton is renowned for its exceptionally long, silky fibres and is used to produce luxury fabrics.\n4.Egyptian Cotton (Gossypium barbadense):\nEgyptian cotton refers to cotton produced in Egypt, primarily from the Gossypium barbadense species. It is known for its long staple length and high-quality fibres, which are favoured for their softness and strength. Egyptian cotton is used in premium textile products such as high-end bedding and clothing.\n5.Acala Cotton:\nAcala cotton is a type of upland cotton primarily grown in the southwestern United States, particularly in California.It is valued for its strong, durable fibres and is commonly used in denim production.\n6.Giza Cotton:\nGiza cotton is grown in Egypt\'s Nile River Valley and is renowned for its long staple length and fine, smooth fibres. It is considered one of the highest-quality cotton varieties globally and is used in luxury textiles.',
    );
    _addSection(
      sections,
      title: 'Sugarcane',
      imagePath: 'assets/images/farmbook/Sugarcane.webp',
      description:
          'Sugarcane is a tall perennial grass belonging to the genus Saccharum, primarily cultivated for its sweet sap or juice, which is used for making sugar and other related products.\nInformation on Sugarcane:\n1.Botanical Name: Saccharum officinarum\n2.Origin: Sugarcane is believed to have originated in New Guinea and was later spread to other tropical and subtropical regions worldwide.\n3.Cultivation: It is grown in tropical and subtropical climates due to its sensitivity to frost.\n4.Life Cycle: Sugarcane is a perennial grass that grows in multiple seasons. It is harvested several times before replanting becomes necessary.\n5.Uses: The primary use of sugarcane is for sugar production. It is also used in the production of molasses, rum, ethanol, and biofuels. Additionally, sugarcane bagasse (the fibrous residue after juice extraction) is used as a biofuel and in the production of paper and board.\nTypes of Sugarcane:\n1.Commercial Sugarcane: This type of sugarcane is cultivated on a large scale for commercial purposes. It is selected based on its sugar content, disease resistance, and adaptability to local conditions.\n2.Wild Sugarcane: Found in its native habitats, wild sugarcane varieties are typically less productive than commercial varieties but may possess unique genetic traits that can be useful in breeding programs.\n3.Hybrid Sugarcane: Hybrid varieties are developed through controlled cross-breeding of different sugarcane strains to produce offspring with desirable traits such as higher sugar content, disease resistance, and better yields.\n4.Biofuel Sugarcane: Some sugarcane varieties are specifically bred for their suitability in biofuel production. These varieties often have higher cellulose content in their biomass, making them ideal for ethanol production.\n5.Organic Sugarcane: Organic sugarcane is grown without the use of synthetic fertilisers, pesticides, or genetically modified organisms (GMOs). It is cultivated using natural and sustainable farming practices.',
    );
    _addSection(
      sections,
      title: 'Potato',
      imagePath: 'assets/images/farmbook/Potato.jpg',
      description:
          'Information on Potatoes:\n1.Scientific Name: Solanum tuberosum\n2.Origin: Potatoes are native to the Andes region of South America, where they have been cultivated for thousands of years.\n3.Cultivation: Potatoes are now grown worldwide in various climates, from temperate to subtropical regions. They thrive in well-drained, loose soil with adequate moisture.\n4.Growth Habit: Potatoes are herbaceous perennial plants that are grown as annuals. They produce underground tubers that are harvested for consumption.\n5.Uses: Potatoes are one of the most widely consumed staple foods globally. They can be boiled, baked, fried, mashed, or roasted and are used in a wide range of dishes, including soups, stews, salads, and snacks.\n',
    );
    // _addSection(
    //   sections,
    //   title: 'Tomato',
    //   imagePath: 'assets/tomato_image.jpg',
    //   description: 'Description for Tomato',
    // );
    return sections;
  }

  void _addSection(
    List<Widget> sections, {
    required String title,
    required String imagePath,
    required String description,
  }) {
    if (_searchQuery.isEmpty || title.toLowerCase().contains(_searchQuery)) {
      sections.add(_buildDropdownSection(
        title: title,
        imagePath: imagePath,
        description: description,
      ));
    }
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
