import 'package:flutter/material.dart';

import '../Block/Cubit.dart';

class CategoriesList extends StatelessWidget {
  BuildContext context;
  CategoriesList(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(
                image: NetworkImage(ShopCubit.get(context).cats[index]
                    .image),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120,
                color: Colors.black.withOpacity(.8),
                child: Text(
                  ShopCubit.get(context).cats[index].name,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          itemCount: ShopCubit.get(context).cats.length),
    );
  }
}
