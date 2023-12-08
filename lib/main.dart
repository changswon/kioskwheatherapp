
import './my_location.dart';
import 'package:flutter/material.dart';
import './network.dart';



const apikey = 'cd899380ae758ffe95104a6e816f2360';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  late double latitude3;
  late double longitude3;

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

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey');

    var weatherData = await network.getJsonData();
    print(weatherData);
  }

  // void fetchData() async {
  //
  //
  //     var myjson = parsingData(jsonData)['weather'][0]['description'];
  //     var wind = parsingData(jsonData)['wind']['seed'];
  //     print(wind);
  //     var id = parsingData(jsonData)['id'];
  //     print(id);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
