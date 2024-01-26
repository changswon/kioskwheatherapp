import 'package:flutter/material.dart';

class BackgroundImageChanger extends StatefulWidget {
  @override
  _BackgroundImageChangerState createState() => _BackgroundImageChangerState();
}

class _BackgroundImageChangerState extends State<BackgroundImageChanger> {
  String backgroundImageAsset = 'image/아침.png'; // 아침 시간대 이미지로 초기화

  @override
  void initState() {
    super.initState();
    updateBackgroundImage(); // 초기 이미지 설정
  }

  void updateBackgroundImage() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 6 && hour < 10) {
      // 오전 6시~9시
      setState(() {
        backgroundImageAsset = 'image/아침.png'; // 아침 시간대 이미지로 변경
      });
    } else if (hour >= 10 && hour < 16) {
      // 저녁 18시~20시
      setState(() {
        backgroundImageAsset = 'image/구름.png'; // 저녁 시간대 이미지로 변경
      });
    } else if (hour >= 16 && hour < 19) {
      // 밤 21시~23시
      setState(() {
        backgroundImageAsset = 'image/석양.png'; // 밤 시간대 이미지로 변경
      });
    } else if (hour >= 19 && hour < 23) {
      setState(() {
      backgroundImageAsset = 'image/밤.png'; // 밤 시간대 이미지로 변경
     });
    } else {
      // 나머지 시간대
      setState(() {
        backgroundImageAsset = 'image/밤.png'; // 기본 이미지로 변경
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImageAsset, // 배경 이미지 파일 경로
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover, // 이미지를 부모 크기에 맞게 확대 또는 축소
        ),
        // 다른 위젯들을 추가하거나 오버레이할 내용을 넣을 수 있습니다.
      ],
    );
  }
}
