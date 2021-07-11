import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);

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
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              color = Colors.redAccent;
            });
          },
          onDoubleTap: (){
            setState(() {
              color = Colors.orangeAccent;
            });
          },
          onHorizontalDragStart: (DragStartDetails details){
            setState(() {
              color = Colors.yellowAccent;
            });
          },
          onHorizontalDragEnd: (DragEndDetails details){
            setState(() {
              color = Colors.greenAccent;
            });
          },
          onVerticalDragStart: (DragStartDetails details){
            setState(() {
              color = Colors.blueAccent;
            });
          },
          onVerticalDragEnd: (DragEndDetails details){
            print(details.primaryVelocity);
            setState(() {
              color = Colors.black;
            });
          },
          onLongPress: (){
            setState(() {
              color = Colors.black12;
            });
          },
          child: Container(
            color: color,
            height: 1920,
            width: 1080,
          ),
        ),
      ),
    );
  }
}
