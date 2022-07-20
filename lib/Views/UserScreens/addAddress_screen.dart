import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Views/UserScreens/profile_screen.dart';
import '../../ViewModels/AddressData/AddressData.dart';
import '../../ViewModels/constants.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
    String? primaryState;
  String? secondaryState;
  String? primaryCity;
  String? secondaryCity;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var primaryaddressDetailsController = TextEditingController();
  var secondaryaddressDetailsController = TextEditingController();

  bool secondaryAddressExisted = false;
  @override
  Widget build(BuildContext context) {

        return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text("Add Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Primary Address: ",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add),
                                color: defaultColor,
                                onPressed: () {
                                  setState(() {
                                    print("Add Secondary");
                                    secondaryAddressExisted = true;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Address details is Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: defaultColor, width: 2),
                                  ),
                                  focusColor: defaultColor,
                                  hintText: "Address Description"),
                              cursorColor: defaultColor,
                              controller: primaryaddressDetailsController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //       focusedBorder: UnderlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: defaultColor, width: 2),
                            //       ),
                            //       focusColor: defaultColor,
                            //       hintText: "Building Name/No"),
                            //   cursorColor: defaultColor,
                            // ),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            DropdownButton<String>(
                              value: primaryState,
                              hint: const Text("Select state"),
                              elevation: 16,
                              style: TextStyle(color: defaultColor),
                              underline: Container(
                                height: 2,
                                color: defaultColor,
                              ),
                              onChanged: (String? newValue) {
                                if (primaryCity != null) primaryCity = null;
                                setState(() {
                                  primaryState = newValue!;
                                });
                              },
                              items: AddressData.states
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            
                            const SizedBox(
                              height: 8,
                            ),
                            DropdownButton<String>(
                              value: primaryCity,
                              hint: const Text("Select city"),
                              elevation: 16,
                              style: TextStyle(color: defaultColor),
                              underline: Container(
                                height: 2,
                                color: defaultColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  primaryCity = newValue!;
                                });
                              },
                              items: AddressData.city(primaryState)
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    secondaryAddressExisted
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                color: defaultColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Secondary Address: ",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
              
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Address details is Required";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: defaultColor, width: 2),
                                        ),
                                        focusColor: defaultColor,
                                        hintText: "Address Description"),
                                    cursorColor: defaultColor,
                                    controller: secondaryaddressDetailsController,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),

                                  DropdownButton<String>(
                                    value: secondaryState,
                                    hint: const Text("Select state"),
                                    elevation: 16,
                                    style: TextStyle(color: defaultColor),
                                    underline: Container(
                                      height: 2,
                                      color: defaultColor,
                                    ),
                                    onChanged: (String? newValue) {
                                      if (secondaryCity != null) {
                                        secondaryCity = null;
                                      }
                                      setState(() {
                                        secondaryState = newValue!;
                                      });
                                    },
                                    items: AddressData.states
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DropdownButton<String>(
                                    value: secondaryCity,
                                    hint: const Text("Select city"),
                                    elevation: 16,
                                    style: TextStyle(color: defaultColor),
                                    underline: Container(
                                      height: 2,
                                      color: defaultColor,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        secondaryCity = newValue!;
                                      });
                                    },
                                    items: AddressData.city(secondaryState)
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 5,
                          ),
                  ],
                ),
              ),
            
      ),
    floatingActionButton: FloatingActionButton.extended(onPressed: (){
     Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ProfileScreen(),
        ),
        (route) => false,//if you want to disable back feature set to false
);
    }, label: const Text("Save"),
    icon: Icon(Icons.save),backgroundColor: defaultColor,),
    );
  


  }
}
