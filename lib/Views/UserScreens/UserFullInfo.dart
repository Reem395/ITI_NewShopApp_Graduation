import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModels/AddressData/AddressData.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

class UserFullInfo extends StatefulWidget {
  const UserFullInfo({Key? key}) : super(key: key);

  @override
  State<UserFullInfo> createState() => _UserFullInfoState();
}

class _UserFullInfoState extends State<UserFullInfo> {
  String? primaryState;
  String? secondaryState;
  String? primaryCity;
  String? secondaryCity;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var primaryaddressDetailsController = TextEditingController();
  var secondaryaddressDetailsController = TextEditingController();
  // var primaryBuildingController = TextEditingController();

  bool secondaryAddressExisted = false;
  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text("User Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                const SizedBox(
                height: 25,
              ),
              defaultTextFormField(
                  label: 'Name',
                  controller: nameController,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Name is Required";
                    }
                    return null;
                  },
                  prefix: Icons.person,
                  borderRaduis: 9,
                  myFocusNode: _nameFocusNode,
                  onTap: _requestFocus),

              const SizedBox(
                height: 25,
              ),

              defaultTextFormField(
                  label: 'Email',
                  controller: emailController,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Email is Required";
                    }
                    return null;
                  },
                  prefix: Icons.email,
                  borderRaduis: 9,
                  myFocusNode: _emailFocusNode,
                  onTap: _emailrequestFocus),

              const SizedBox(
                height: 25,
              ),

              defaultTextFormField(
                  label: 'Phone',
                  controller: phoneController,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Phone is Required";
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  borderRaduis: 9,
                  myFocusNode: _phoneFocusNode,
                  onTap: _phonerequestFocus),

              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.shopping_bag,
                      color: defaultColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: defaultColor, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      borderSide: BorderSide(
                        color: defaultColor,
                      ),
                    ),
                    focusColor: defaultColor,
                    hintText: "Last Name"),
                cursorColor: defaultColor,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     labelText: 'phone',
              //     labelStyle: TextStyle(
              //       color: defaultColor, //<-- SEE HERE
              //     ),),),
              const SizedBox(
                height: 45,
              ),
              Column(
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
                            SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Address: ",
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
                    // width: double.infinity,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.rectangle,
                    //   borderRadius: BorderRadius.circular(8),
                    //   border: Border.all(color: Colors.black38),
                    //   //  color: Colors.white,
                    // ),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Save"),
        icon: Icon(Icons.save),
        backgroundColor: defaultColor,
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_nameFocusNode);
    });
  }

  void _emailrequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  void _phonerequestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_phoneFocusNode);
    });
  }
}
