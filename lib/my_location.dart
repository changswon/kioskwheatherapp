import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MyLocation{
  late double latitude2;
  late double longitude2;
  late String administrativeArea;
  late String subLocality;

  MyLocation() {
    // 변수 초기화
    administrativeArea = "";
    subLocality = "";


  }

  Future<void> getMyCurrentLocation()async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      administrativeArea = "";
      subLocality = "";

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude2, longitude2);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        administrativeArea = placemark.administrativeArea ?? "";
        subLocality = placemark.subLocality ?? "";


        //print('City: $administrativeArea');
        //print('Sub Locality: $subLocality');
      } else {
        print("Placemarks를 찾을 수 없습니다");
      }

    } catch (e) {
      print('Error getting location: $e');
    }
  }
}