import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'location.dart';

const apiKey = '303d24269d8f61270035c3f83ef60b6c';
const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class NetworkHelper {
  Location location;

  NetworkHelper();

  Future<Location> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    location =
        Location(latitude: position.latitude, longitude: position.longitude);
    return location;
  }

  Future getWeatherData() async {
    http.Response response = await http.get(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Problem with api calling: ${response.statusCode}');
    }
  }

  Future getCityWeatherData(String city) async {
    http.Response response =
        await http.get('$openWeatherURL?q=$city&appid=$apiKey&units=metric');
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Problem with api calling: ${response.statusCode}');
    }
  }
}
