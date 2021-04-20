import 'package:flutter/material.dart';

import '../data/size_config.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(50),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: Image.asset(icon,width: 30,height: 30, fit: BoxFit.cover,),
      ),
    );
  }
}
