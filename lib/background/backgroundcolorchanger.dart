import 'package:flutter/material.dart';

class BackgroundColorChanger extends StatefulWidget {
  @override
  _BackgroundColorChangerState createState() => _BackgroundColorChangerState();
}

class _BackgroundColorChangerState extends State<BackgroundColorChanger> {
  Color backgroundColor = Colors.blueAccent;

  @override
  void initState() {
    super.initState();
    updateBackgroundColor(); // 초기 배경색 설정
  }

  void updateBackgroundColor() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 6 && hour < 9)  {
      // 오전 6시~9시
      setState(() {
        backgroundColor = Colors.deepOrangeAccent; // 원하는 색상으로 변경
      });
    } else if (hour >= 10 && hour < 17) {
      // 저녁 18시~20시
      setState(() {
        backgroundColor = Colors.blueAccent; // 원하는 색상으로 변경
      });
    } else if (hour >= 18 && hour < 23) {
      // 밤 21시~23시
      setState(() {
        backgroundColor = Color.fromRGBO(18, 4, 54, 0.8); // 원하는 색상으로 변경
      });
    } else {
      // 나머지 시간대
      setState(() {
        backgroundColor = Colors.deepPurple; // 원하는 색상으로 변경
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // 현재 배경색 설정
    );
  }
}
