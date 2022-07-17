import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModels/AddressData/AddressData.dart';
import '../../ViewModels/constants.dart';

class UserFullInfo extends StatefulWidget {
  const UserFullInfo({Key? key}) : super(key: key);

  @override
  State<UserFullInfo> createState() => _UserFullInfoState();
}

class _UserFullInfoState extends State<UserFullInfo> {
  String? state;
  String? city;

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
                  backgroundColor: defaultColor,
                  title: const Text("User Information"),
                ),
          body: Column(
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
