import 'package:flutter/material.dart';
import 'main.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  // Controllers to handle the input text
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _addressController.dispose();
    _pincodeController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void saveAddress() {
    String mainAddress = _addressController.text;
    Navigator.pop(context, mainAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: shadeWhite,
      appBar: AppBar(

            toolbarHeight: 100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            backgroundColor: shadeBG,
            leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text("Enter Your Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Main Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pincodeController,
              decoration: const InputDecoration(
                labelText: 'Pincode',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _landmarkController,
              decoration: const InputDecoration(
                labelText: 'Landmark',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(shadeFG),
                  iconColor: WidgetStatePropertyAll(shadeFG)
                ),
              onPressed: saveAddress,
              child: const Text('Save Address',style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
