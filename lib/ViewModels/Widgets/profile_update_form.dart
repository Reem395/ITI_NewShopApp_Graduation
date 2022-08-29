import 'package:flutter/material.dart';
import '../Components.dart';

class UpdateForm extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController password;
  const UpdateForm(this.name, this.phone, this.password, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: profileTextFormField(
                label: 'Name',
                controller: name,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "Name is Required";
                  }
                  return null;
                },
                prefix: Icons.person)),
        const SizedBox(
          height: 20,
        ),
        // Container(
        //     height: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(3),
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 1,
        //           blurRadius: 7,
        //           offset: Offset(0, 3), // changes position of shadow
        //         ),
        //       ],
        //     ),
        //     child: profileTextFormField(
        //         label: 'Password',
        //         controller: password,
        //         validate: (String? value) {
        //           if (value!.isEmpty) {
        //             return "Password is Required";
        //           }
        //           return null;
        //         },
        //         prefix: Icons.email)),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: profileTextFormField(
                label: 'Phone',
                controller: phone,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "Phone is Required";
                  }
                  return null;
                },
                prefix: Icons.phone)),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
