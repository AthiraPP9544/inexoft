import 'package:app/screen/home.dart';
import 'package:flutter/material.dart';

final TextEditingController customerNameController = TextEditingController();
final TextEditingController customerAddressController = TextEditingController(); // Added for address
final TextEditingController customerPhoneController = TextEditingController();

void updateCustomerBottomSheet(BuildContext context, String name, String id, String address, String phone) { // Updated parameters
  customerNameController.text = name;
  customerAddressController.text = address; // Updated to address field
  customerPhoneController.text = phone;

  bool nameIsValid = true;
  bool addressIsValid = true; // Updated for address
  bool phoneIsValid = true;

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color.fromARGB(255, 208, 227, 243),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    "Update customer information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: customerNameController,
                  decoration: InputDecoration(
                    labelText: "Customer Name",
                    hintText: "eg. John Doe",
                    errorText: nameIsValid ? null : "Invalid Customer Name",
                  ),
                  onChanged: (value) {
                    setState(() {
                      nameIsValid = _validateCustomerName(value);
                    });
                  },
                ),
                TextField(
                  controller: customerAddressController, // Address field
                  decoration: InputDecoration(
                    labelText: "Address", // Label changed to Address
                    hintText: "Enter customer address", // Updated hint text
                    errorText: addressIsValid ? null : "Invalid Address", // Updated error text
                  ),
                  onChanged: (value) {
                    setState(() {
                      addressIsValid = _validateAddress(value); // Updated validation function
                    });
                  },
                ),
                TextField(
                  controller: customerPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    hintText: "eg. 123-456-7890",
                    errorText: phoneIsValid ? null : "Invalid Phone",
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneIsValid = _validatePhone(value);
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (nameIsValid && addressIsValid && phoneIsValid) {
                      customersReference.child(id).update({
                        "name": customerNameController.text.toString(),
                        "address": customerAddressController.text.toString(), // Updated field to address
                        "phone": customerPhoneController.text.toString(),
                      });

                      customerNameController.clear();
                      customerAddressController.clear(); // Cleared address field
                      customerPhoneController.clear();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter valid information'),
                        ),
                      );
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

bool _validateCustomerName(String name) {
  final RegExp regex = RegExp(r'^[a-zA-Z ]+$');
  return regex.hasMatch(name);

  
  return name.isNotEmpty;
}

bool _validateAddress(String address) {
  final RegExp regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(address);
  return address.isNotEmpty;}

bool _validatePhone(String phone) {
  
  final RegExp regex = RegExp(r'^\d{3}-\d{3}-\d{4}$');
  return regex.hasMatch(phone);
}

