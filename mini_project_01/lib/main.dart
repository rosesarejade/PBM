import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 202, 0, 131))),
      home: MyHomePage(),
    );
  }
}

// ... home page

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Las Estrellas';
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(appTitle,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 73, 0, 50))),
          leading: Icon(Icons.menu),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                icon: Icon(Icons.home)),
            IconButton(
                icon: Icon(Icons.collections_bookmark),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryPage()),
                  );
                }),
            IconButton(
                icon: Icon(Icons.add_shopping_cart_sharp), onPressed: () {})
          ],
        ),
        // add widget
        body: SingleChildScrollView(
            child: Column(
          children: [
            Image.network(
                'https://miro.medium.com/v2/resize:fit:2000/format:webp/0*w1AVdL-5Yp2devrK'),
            TitleSection(
                name: "Oceans and Dreams", subtitle: "to Withold The Stars"),
            ButtonSection(),
            TextSection(
              description:
                  '... Dreams exist in the form of the most mundane things and are meant for more reasons than one. '
                  'Dreams are like shining stars in the endless sky and we’ll have to look up to know they’re there. '
                  'Dreams aren’t a tight rope, holding us down. '
                  'It’s to keep us afloat, breathing. ',
            ),
            ImageSection(image: 'images/wall.jpg')
          ],
        )));
  }
}

// ...

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.read_more,
            label: 'READ',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.bookmark,
            label: 'SAVE',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.subtitle,
  });

  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // Icon
          Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 255, 97, 194),
          ),
          const Text('13'),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    // #docregion Image-asset
    return Image.asset(
      image,
      width: 600,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final List<String> thumbList = [
    "images/wall.jpg",
    "images/wall.jpg",
    "images/wall.jpg",
    'images/flower.jpg',
    'images/flower.jpg',
    'images/flower.jpg',
    "images/wall.jpg",
    "images/wall.jpg",
    "images/wall.jpg",
    'images/flower.jpg',
    'images/flower.jpg',
    'images/flower.jpg',
    "images/wall.jpg",
    "images/wall.jpg",
    "images/wall.jpg",
    'images/flower.jpg',
    'images/flower.jpg',
    'images/flower.jpg',
    "images/wall.jpg",
    "images/wall.jpg",
    "images/wall.jpg",
    'images/flower.jpg',
    'images/flower.jpg',
    'images/flower.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gallery of Galaxies'),
        ),
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(thumbList.length, (index) {
            return Center(
              child: Image.asset(thumbList[index]),
            );
          }),
        ));
  }
}
