import 'package:flutter/material.dart';

import '../constants.dart';

class ShowProfileData extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController password;
  const ShowProfileData(this.name, this.phone, this.email, this.password, {Key? key}) : super(key: key);
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
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 12,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] ,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Text("Name: ",style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: defaultColor),),
              const SizedBox(width:10),
              Text(name.text,style: TextStyle(fontSize: 18,)),
            ],),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white,
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] ,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Text("Email: ",style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: defaultColor),),
              const SizedBox(width:10),
              Text(email.text,style: TextStyle(fontSize: 18,)),
            ],),
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white,
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] ,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Text("Phone: ",style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: defaultColor),),
              const SizedBox(width:10),
              Text(phone.text,style: TextStyle(fontSize: 18,)),
            ],),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white,
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] ,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Text("Password: ",style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: defaultColor),),
              const SizedBox(width:10),
              Text(password.text,style: TextStyle(fontSize: 18,)),
            ],),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
