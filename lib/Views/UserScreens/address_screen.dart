import 'package:flutter/material.dart';
import '../../ViewModels/AddressData/AddressData.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);
  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String? state;
  String? city;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: state,
            hint: const Text("Select state"),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              if (city != null) city = null;
              setState(() {
                state = newValue!;
              });
            },
            items:
                AddressData.states.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: city,
            hint: const Text("Select city"),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                city = newValue!;
              });
            },
            items: AddressData.city(state)
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
