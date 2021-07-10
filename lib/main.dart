// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blayer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Director'),
        centerTitle: true,
      ),


      body: Center(
        child: GestureDetector(
        onTap: (){
          setState(() {
            color = Colors.green;
          });
        },
        onDoubleTap: (){
          setState(() {
            color = Colors.red;
          });
        },
        onLongPress: (){
          setState(() {
            color = Colors.black;
          });
        },
          child: Container(
        color: color,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }
}
