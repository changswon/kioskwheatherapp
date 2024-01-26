import './weather_screen.dart';
import './my_location.dart';
import 'package:flutter/material.dart';
import './network.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'model/model.dart';

const apikey = 'cd899380ae758ffe95104a6e816f2360'; //openweather api key


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Loading(),
    );
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double latitude3;
  late double longitude3;
  late String administrativeArea;
  late String subLocality;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    administrativeArea = myLocation.administrativeArea;
    subLocality = myLocation.subLocality;


    Network network = Network(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&lang=kr&appid=$apikey&units=metric',
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey',
      'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
    );
    try {
      var weatherData = await network.getJsonData();
      var airData = await network.getAirData();
      var weekData = await network.getWeekData();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WeatherScreen(
          parseWeatherData: weatherData,
          parseAirPollution: airData,
          parseWeekData: weekData,
          administrativeArea: administrativeArea,
          subLocality: subLocality,
        );
      }));
    } catch (e) {
      // Error handling
      print('Error: $e');
      // TODO: Show error message to the user or implement retry logic
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(

      child: Image.asset(
      'assets/무지개.gif', // GIF 파일의 경로 지정
      width: 200.0,           // 로딩 인디게이터의 가로 크기
      height: 200.0,

    ),
      ),
    );
  }
}
