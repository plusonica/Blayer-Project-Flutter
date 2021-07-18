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

  AudioPlayer player = AudioPlayer(); // 오디오 조정에 사용하는 클래스
  AudioCache cache = AudioCache(); // 오디오 로컬 재생(휴대폰)에 사용하는 클래스
  Color color = Colors.white;
  String audioPath = "sample.mp3"; // assets 폴더의 sample.mp3 확인
  bool isPlaying = false;
  bool isPlayedOnce = false;
  double volume = 1; // 기본 볼륨 설정(0부터 1 사이 값만 유효)
  double volume_interval = 0.2; // 한번 조정할 때마다 0.2씩 볼륨이 바뀜(조정 가능)

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

  void _stopFile() { // 오디오 멈추는 명령어
    player.stop();
    isPlaying = false;
  }

  void _pauseFile() { // 오디오 일시정지 명령어
    player.pause();
    isPlaying = false;
  }

  void _changeVolume(double volume) {
    player.setVolume(volume);
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
              volume < 1 ? volume += volume_interval : volume = 1;
              _changeVolume(volume);
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
              volume > 0 ? volume -= volume_interval : volume = 0;
              _changeVolume(volume);
            });
          },
          onLongPress: (){
            setState(() {
              color = Colors.black12;
              _stopFile(); //중지(오디오 처음으로)
            });
          },

          child: Container(
            color: color,
            height: 1920,
            width: 1080,
            child: Text("volume = " + volume.toString()),
          ),
          ),
      ),
    );
  }
}
