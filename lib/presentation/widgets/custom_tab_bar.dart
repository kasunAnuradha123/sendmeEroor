import 'package:flutter/material.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key key, this.index}) : super(key: key);
final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            child: Icon(Icons.camera_alt,color: Colors.white,),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "CHAT",
              textColor: index==1?Colors.white:textIconColorGray,
              borderColor: index==1?textIconColorGray:Colors.transparent,
              borderWidth: 0.0,
            )
          ),
          Expanded(
              child: CustomTabBarButton(
                text: "STATUS",
                textColor: index==2?Colors.white:textIconColorGray,
                borderColor: index==2?textIconColorGray:Colors.transparent,
                borderWidth: 0.0,
              )
          ),
          Expanded(
              child: CustomTabBarButton(
                text: "CALLS",
                textColor: index==3?Colors.white:textIconColorGray,
                borderColor: index==3?textIconColorGray:Colors.transparent,
                borderWidth: 0.0,
              )
          )
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  const CustomTabBarButton({Key key,
     this.text,
     this.borderColor,
     this.textColor,
     this.borderWidth,
  }) : super(key: key);

  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor,width: borderWidth),
        )
      ),
      child: Text(text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor),
      ),
    );
  }
}

