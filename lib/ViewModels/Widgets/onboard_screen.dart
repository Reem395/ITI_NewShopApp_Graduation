import 'package:flutter/material.dart';

class BoardScreenPages extends StatelessWidget {
  final String image;
  final String text;
  final BuildContext context;
  const BoardScreenPages(this.image, this.text,  this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10),
          child: Image.asset(image, height: 350),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
