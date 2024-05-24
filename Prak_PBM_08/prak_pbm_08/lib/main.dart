import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu.dart';
import 'items.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Flutter Pertemuan 08',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 245, 57, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Welcome to Flutter Lab Practices!"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuPage()));
              },
              child: const Text("Menu"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<CabinNumber> divineCabins = [
    CabinNumber(
        imageUrl:
            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7d10356a-e13a-404e-ba49-8eee38b3efa6/d5l2pvc-a6b8d65f-f339-4593-b03d-fbb9594f4600.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzdkMTAzNTZhLWUxM2EtNDA0ZS1iYTQ5LThlZWUzOGIzZWZhNlwvZDVsMnB2Yy1hNmI4ZDY1Zi1mMzM5LTQ1OTMtYjAzZC1mYmI5NTk0ZjQ2MDAuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.uY9LNKTJGktpEEHRYBsd5FDd-hfqYw1fC3ZSolzoVYg",
        name: "Zeus' Cabin",
        number: 1),
    CabinNumber(
        imageUrl:
            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7d10356a-e13a-404e-ba49-8eee38b3efa6/d5pfdvr-6ab99aff-070f-4c44-a4a2-04814d990594.jpg/v1/fit/w_540,h_1800,q_70,strp/chb_cabin_two___hera_by_whisperwings_d5pfdvr-375w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MzAwMCIsInBhdGgiOiJcL2ZcLzdkMTAzNTZhLWUxM2EtNDA0ZS1iYTQ5LThlZWUzOGIzZWZhNlwvZDVwZmR2ci02YWI5OWFmZi0wNzBmLTRjNDQtYTRhMi0wNDgxNGQ5OTA1OTQuanBnIiwid2lkdGgiOiI8PTkwMCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.cI9z8AQeCNpTvm7MUO36IXRLm1-CbqwN3qTrujpOQak",
        name: "Hera's Cabin",
        number: 2),
    CabinNumber(
        imageUrl:
            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7d10356a-e13a-404e-ba49-8eee38b3efa6/d5pg5wl-d5b1546a-627a-4a8d-8096-5cf85c5ca492.jpg/v1/fit/w_540,h_1800,q_70,strp/chb_cabin_three___poseidon_by_whisperwings_d5pg5wl-375w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MzAwMCIsInBhdGgiOiJcL2ZcLzdkMTAzNTZhLWUxM2EtNDA0ZS1iYTQ5LThlZWUzOGIzZWZhNlwvZDVwZzV3bC1kNWIxNTQ2YS02MjdhLTRhOGQtODA5Ni01Y2Y4NWM1Y2E0OTIuanBnIiwid2lkdGgiOiI8PTkwMCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.zAMG3bVNFlBywh-tEjd5U_pall4SsXQQORdTpoJVt8s",
        name: "Poseidon's Cabin",
        number: 3),
    CabinNumber(
        imageUrl:
            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7d10356a-e13a-404e-ba49-8eee38b3efa6/d5xbs1l-d9a7df6c-ccfa-4a5a-bfda-69b5b49ae647.jpg/v1/fit/w_540,h_1800,q_70,strp/chb_cabin_four___demeter_by_whisperwings_d5xbs1l-375w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MzAwMCIsInBhdGgiOiJcL2ZcLzdkMTAzNTZhLWUxM2EtNDA0ZS1iYTQ5LThlZWUzOGIzZWZhNlwvZDV4YnMxbC1kOWE3ZGY2Yy1jY2ZhLTRhNWEtYmZkYS02OWI1YjQ5YWU2NDcuanBnIiwid2lkdGgiOiI8PTkwMCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.lJ0l51Uz-oKtFutHt3v66h7isB0LAwkMFbshB8niw6I",
        name: "Demeter's Cabin",
        number: 4),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/ad/c6/9d/adc69dd22494f9cc2983a01c28c8118a.jpg",
        name: "Ares' Cabin",
        number: 5),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/5e/61/31/5e613109852cdc5a6e0c4693a52dd88c.jpg",
        name: "Athena's Cabin",
        number: 6),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/4a/25/28/4a25286d0000a6c61ddddd93bd9478ac.jpg",
        name: "Apollo's Cabin",
        number: 7),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/f3/7b/49/f37b4977763ff1a88246442f42021ef4.jpg",
        name: "Artemis' Cabin",
        number: 8),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/55/90/ca/5590ca17269bdf0243dbd87aeeb4c014.jpg",
        name: "Hephaestus' Cabin",
        number: 9),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/c9/72/21/c9722129824fd2287a3a0c7d23cf13e4.jpg",
        name: "Aphrodite's Cabin",
        number: 10),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/2d/83/18/2d8318c33ab7552d5e0958d658c4e97d.jpg",
        name: "Hermes' Cabin",
        number: 11),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/fd/d0/7d/fdd07d69c76e32ecc8e8c2dd9e2b77e9.jpg",
        name: "Dionysus' Cabin",
        number: 12),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/736x/8d/a8/00/8da800a9c50b6b41853c71fd54022f72.jpg",
        name: "Hades' Cabin",
        number: 13),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/91/c5/cf/91c5cff47a4feda03337fcb21f662d3d.jpg",
        name: "Iris' Cabin",
        number: 14),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/6f/b2/ba/6fb2ba621ff6b7730346869ef17a59f9.jpg",
        name: "Hypnos' Cabin",
        number: 15),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/3a/08/e9/3a08e9dbab1fa68a5584ceeb3b800d21.jpg",
        name: "Nemesis' Cabin",
        number: 16),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/71/89/80/718980a7002d2df2b17f4568578a5aa2.jpg",
        name: "Nike's Cabin",
        number: 17),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/70/2a/05/702a059daafbc2b02b18b3ba749499db.jpg",
        name: "Hebe's Cabin",
        number: 18),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/564x/75/31/b9/7531b936741e108890631dbcf75392ab.jpg",
        name: "Tyche's Cabin",
        number: 19),
    CabinNumber(
        imageUrl:
            "https://i.pinimg.com/736x/39/43/1d/39431d85327ffbe8d187c74e78c2a4c2.jpg",
        name: "Hecate's Cabin",
        number: 20),
  ];

  List<CartItem> cartItems = [];
  List<CartItem> _cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CartDialog(cartItems: _cartItems)));
              },
              icon: Icon(Icons.schedule))
        ],
      ),
      body: GridView.builder(
        itemCount: divineCabins.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    cabinNumber: divineCabins[index],
                    addToCart: _addToCart,
                    cartItems: _cartItems,
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      divineCabins[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      divineCabins[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                      "Join Cabin ${divineCabins[index].number.toStringAsFixed(0)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addToCart(CabinNumber cabinNumber) {
    setState(() {
      _cartItems.add(CartItem(cabinNumber: cabinNumber));
      print("_cartItems");
      _cartItems.forEach((element) {
        print(element.cabinNumber.name);
      });
    });
  }
}

class CartDialog extends StatelessWidget {
  final List<CartItem> cartItems;

  CartDialog({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    int itemCount = cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    double requestCode = cartItems.fold<double>(
        0, (sum, item) => sum + item.cabinNumber.number * item.quantity * 989);

    print("itemCount $itemCount");
    print("requestPendCode $requestCode");

    return Scaffold(
        appBar: AppBar(
          title: Text("Cart to Request"),
        ),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  print("a. $cartItems");
                  return ListTile(
                    leading: Image.network(
                      cartItems[index].cabinNumber.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cartItems[index].cabinNumber.name),
                    subtitle: Text('Requested'),
                    trailing: Text(
                        'Code ${(cartItems[index].cabinNumber.number * cartItems[index].quantity)}'),
                  );
                }),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Camp Training Number : $requestCode"),
              ),
            )
          ],
        ));
  }
}

class DetailPage extends StatefulWidget {
  final CabinNumber cabinNumber;
  final List<CartItem> cartItems;
  final void Function(CabinNumber) addToCart;

  const DetailPage({
    Key? key,
    required this.cabinNumber,
    required this.addToCart,
    required this.cartItems,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cabinNumber.name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CartDialog(cartItems: widget.cartItems)));
              },
              icon: Icon(Icons.schedule))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.cabinNumber.imageUrl),
              SizedBox(height: 16),
              Text(
                widget.cabinNumber.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("You are entering Cabin ${widget.cabinNumber.number}"),
              ElevatedButton(
                  onPressed: () {
                    widget.addToCart(widget.cabinNumber);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          '${widget.cabinNumber.name} activities added to training requests'),
                    ));
                  },
                  child: Text("Add to Request Activities"))
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String exteriorUrl =
      "https://cdn.pixabay.com/photo/2014/10/13/22/40/montauk-light-house-487640_1280.jpg";
  String interiorUrl =
      "https://i.pinimg.com/564x/c7/90/1b/c7901b47331f8b3b6ae23140d8497cf0.jpg";
  String name =
      "Camp Half-Blood: A secret training ground and sanctuary for demigods";
  String location =
      "Camp Half-Blood, Half-Blood Hill, Farm Road 3.141, Long Island, New York 11954";
  String mapsUrl = "https://maps.app.goo.gl/vMYz8spQ1wsPvUgUA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Outside Camp Behind The Mist:"),
                SizedBox(height: 8),
                Image.network(exteriorUrl),
                SizedBox(height: 16),
                Text(
                    "Confidential: Map of the Camp Only Reserved for Demigods"),
                SizedBox(height: 8),
                Image.network(interiorUrl),
                SizedBox(height: 16),
                Text(
                  "Find Location:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(location),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    await launch(mapsUrl);
                  },
                  icon: Icon(Icons.map),
                  label: Text("Earn Your Quest on Google Map"),
                ),
              ],
            ),
          ),
        ));
  }
}
