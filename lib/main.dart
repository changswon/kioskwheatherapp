import './weather_screen.dart';
import './my_location.dart';
import 'package:flutter/material.dart';
import './network.dart';
import 'package:intl/date_symbol_data_local.dart';

const apikey = 'cd899380ae758ffe95104a6e816f2360'; //openweather api key
const apikey2 = 'jixEuptEnnkEQf4FBY0igRHkFKJBglfa';

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
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey',
      'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
      'https://api.windy.com/api/point-forecast/v2?lat=$latitude3&lon=$longitude3&model=gfs&parameters=temp,wind,precip&levels=surface&key=$apikey2',
    );

    try {
      var weatherData = await network.getJsonData();
      var airData = await network.getAirData();
      var weekData = await network.getWeekData();
      var windyData = await network.getwindyData();


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
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: isLoading ? null : () {},
          child: Text(isLoading ? 'Loading' : 'Start'),
        ),
      ),
    );
  }
}
