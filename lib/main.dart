import 'package:hdims/buymedicine.dart';
import 'package:hdims/consultdoctors.dart';
import 'package:hdims/govpolicy.dart';
import 'package:hdims/medicalrecords.dart';
import 'package:hdims/yourpres.dart';
import 'package:hdims/yourdevices.dart';
import 'package:hdims/yourprofile.dart';
import 'addaddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

dynamic shadeBG = const Color.fromARGB(255, 0, 132, 255);
dynamic shadeFG = const Color.fromARGB(255, 173, 216, 255);
dynamic shadeWhite = const Color.fromARGB(255, 254, 253, 242);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Homescreen(),
        '/addaddress': (context) => const AddAddress(),
        '/medicalrecords': (context) => const medicalRecords(),
        '/buymedicine': (context) => const buyMedicine(),
        '/govpolicy': (context) => govPolicy(),
        '/consultdoctors': (context) => const consultDoctors(),
        '/yourdevices': (context) => const yourDevices(),
        '/yourpres': (context) => const yourPres(),
        '/yourprofile': (context) => const yourProfile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String mainAddress = 'Set your Address';
  List<String> randomMotivation = [
    "Regular check-ups are essential for maintaining your overall health!",
    "A balanced diet can significantly improve your energy levels and immune system!",
    "Staying hydrated is key to supporting your body's vital functions!",
    "Walking for just 30 minutes a day can reduce your risk of heart disease!",
    "Adequate sleep is crucial for both mental and physical well-being!",
    "Managing stress effectively can improve both your physical and mental health!",
    "A healthy lifestyle includes balanced nutrition, regular exercise, and mental wellness!",
    "Your health is your greatest wealth—take care of it every day!",
    "Your body is capable of amazing things—nourish it with care and love!",
    "Your health journey is unique—stay committed to what's best for you!",
    "Progress, not perfection—your well-being is a continuous journey!",
    "Believe in the power of prevention—stay ahead by making smart health choices!",
    "Take charge of your health today—every positive choice counts!",
    "Your body is your home—treat it with respect and care!",
    "Don't wait for tomorrow—your health deserves attention today!",
    "The healthier you are, the more you can give to those around you!"
  ];
  late String selectedMotivation;
  int _selectedIndex = 0;

  void getRandomItem() {
    final random = Random();
    int randomIndex = random.nextInt(randomMotivation.length);
    selectedMotivation = randomMotivation[randomIndex];
  }

  @override
  void initState() {
    super.initState();
    getRandomItem();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/yourprofile');
    } else if (index == 2) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        backgroundColor: shadeBG,
        leading: IconButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/addaddress');
            if (result != null) {
              setState(() {
                mainAddress = result as String;
              });
            }
          },
          icon: const Icon(
            CupertinoIcons.location,
            color: Color.fromARGB(255, 0, 0, 0),
            size: 25,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                mainAddress,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 22,color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.line_horizontal_3,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Ensure scrollability
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    fillColor: shadeFG,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 35,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your Dashboard:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  double iconSize = constraints.maxWidth * 0.45;
                  double spacing = constraints.maxWidth * 0.0002;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: iconSize,
                            width: iconSize,
                            child: IconButton(
                              onPressed: () async {
                                Navigator.pushNamed(context, '/medicalrecords');
                              },
                              icon: Image.asset('assets/medicalHistory.png'),
                            ),
                          ),
                          SizedBox(
                            height: iconSize,
                            width: iconSize,
                            child: IconButton(
                              onPressed: () async {
                                Navigator.pushNamed(context, '/yourpres');
                              },
                              icon: Image.asset('assets/yourPres.png'),
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        offset: const Offset(0, -55),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pushNamed(context, '/buymedicine');
                                },
                                icon: Image.asset('assets/buyMedicine.png'),
                              ),
                            ),
                            SizedBox(width: spacing),
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pushNamed(
                                      context, '/consultdoctors');
                                },
                                icon: Image.asset('assets/consultDoc.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -105),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pushNamed(context, '/yourdevices');
                                },
                                icon: Image.asset('assets/yourDevices.png'),
                              ),
                            ),
                            SizedBox(width: spacing),
                            SizedBox(
                              height: iconSize,
                              width: iconSize,
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.pushNamed(context, '/govpolicy');
                                },
                                icon: Image.asset('assets/govPolicies.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Transform.translate(
                        offset: const Offset(0, -120),
                        child: Center(
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(56, 211, 207, 207)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  selectedMotivation,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 19,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // // ),
                      // Transform.translate(
                      //   offset: const Offset(-100, -120),
                      //   child: const Text(
                      //     "Your Overview:",
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w900,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      //  ),
                      // Transform.translate(
                      //   offset: const Offset(0, -120),
                      //   child: Center(
                      //     child: Container(
                      //       height: 180,
                      //       width: MediaQuery.of(context).size.width * 0.85,
                      //       decoration: const BoxDecoration(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(20)),
                      //         color: Color.fromARGB(56, 147, 144, 144),
                      //       ),
                      //       child: LayoutBuilder(
                      //         builder: (context, constraints) {
                      //           double iconSize = constraints.maxWidth * 0.25;
                      //           return Center(
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceEvenly,
                      //               children: [
                      //                 SizedBox(
                      //                   height: iconSize,
                      //                   width: iconSize,
                      //                   child: IconButton(
                      //                     onPressed: () {},
                      //                     icon: Image.asset(
                      //                         'assets/yourts.png'),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: iconSize,
                      //                   width: iconSize,
                      //                   child: IconButton(
                      //                     onPressed: () {},
                      //                     icon: Image.asset(
                      //                         'assets/nearbyhosps.png'),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: iconSize,
                      //                   width: iconSize,
                      //                   child: IconButton(
                      //                     onPressed: () {},
                      //                     icon: Image.asset(
                      //                         'assets/orderstats.png'),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: iconSize,
                      //                   width: iconSize,
                      //                   child: IconButton(
                      //                     onPressed: () {},
                      //                     icon: Icon(CupertinoIcons.arrow_up_right_square_fill),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            iconSize: 35,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_crop_circle),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.dot_square),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assistant_outlined),
                label: "Need Help?",
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: shadeFG,
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                heroTag: 'homeButton',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: shadeBG,
                onPressed: () {},
                child: const Icon(CupertinoIcons.home, size: 30),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          heroTag: 'sosButton',
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 252, 17, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.sos,
            size: 40,
          ),
        ),
      ),
    );
  }
}
