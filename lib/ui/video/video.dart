import 'package:flutter/material.dart';
class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){
          return Text('fefefe', style: TextStyle(color: Colors.red, fontSize: 15),);
        });
  }
}
