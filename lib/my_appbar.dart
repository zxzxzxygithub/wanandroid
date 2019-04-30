import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      color: Colors.yellow,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 46,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 44,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                child: Image.asset(
                  "images/icon_back.png",
                  width: 44,
                  height: 44,
                ),
              ),
            ),
            GestureDetector(
                child: Container(
                  alignment: Alignment.centerRight,
                  height: 44,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  child: Image.asset(
                    "images/icon_share.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
    var container2 = Container(
      child: Stack(
        children: <Widget>[
          Positioned(child: container),
        ],
      ),
    );
    return Scaffold(
        body: Stack(children: <Widget>[
          Positioned(child: container, top: 23,),
        ],),
    );
  }
}
