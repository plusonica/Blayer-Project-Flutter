import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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

  AudioPlayer player = AudioPlayer();
  AudioCache cache = AudioCache();
  Color color = Colors.white;
  String audioPath = "sample.mp3";
  bool isPlaying = false;
  bool isPlayedOnce = false;

  void _playFile() async{
    if (!isPlayedOnce) {
      player = await cache.play(audioPath);
      isPlayedOnce = true;
      isPlaying = true;
    }
    else {
      player.resume();
      isPlaying = true;
    }
  }

  void _stopFile() {
    player.stop(); // stop the file like this
    isPlaying = false;
  }

  void _pauseFile() {
    player.pause(); // stop the file like this
    isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              color = Colors.redAccent;
              _playFile(); //assets/sample.mp3 재생
            });
          },
          onDoubleTap: (){
            setState(() {
              color = Colors.orangeAccent;
              _pauseFile(); //일시정지
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
              _stopFile(); //중지(오디오 처음으로)
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
