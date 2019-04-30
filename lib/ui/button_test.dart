import 'package:flutter/material.dart';
import 'package:wanandroid_ngu/i_set_name.dart';

class ButtonWidget extends StatefulWidget {
  final name;

  ButtonWidget({Key key, this.name}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> implements ISetName {
  var name = '李健';

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didUpdateWidget(ButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    var raisedButton = RaisedButton(
              child: Text(
                name,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              onPressed: () {
                print('1111111111111');

                setName();
              });
    return Scaffold(
      body: Container(
        height: 208,
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index){
              return raisedButton;
            },
          ),
        ),
      ),
    );
  }

  @override
  void setName() {
    setState(() {
      var x = 123;
      print("$x" + "aaa");
    });
  }
}
