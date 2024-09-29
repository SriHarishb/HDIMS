// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdims/main.dart';


class buyMedicine extends StatelessWidget {
  const buyMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MedicineList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<dynamic> medicines = [];

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  Future<void> loadMedicines() async {
    final String response = await rootBundle.loadString('assets/Buy_medicine.json');
    final data = await json.decode(response);
    setState(() {
      medicines = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: shadeWhite,
      appBar: AppBar(
        title: const Text('Available Medicines'),
        
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 209, 255),
      ),
      body: medicines.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];
return SizedBox(

  child: Card(
    child: ListTile(
      title: Text(medicine['name'] + " (" + medicine['brand'] + ")"),
      subtitle: Text(medicine['description']),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('\$${medicine['price']}'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Buy'),
          ),
        ],
      ),
    ),
  ),
);
              },
            ),
    );
  }
}