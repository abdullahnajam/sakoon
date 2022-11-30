import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../data/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: InkWell(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(30)
          ),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
      )
    );
  }
}
