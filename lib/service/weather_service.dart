import '../models/weather_model.dart';
imoport 'package:http/http.dart' as http;

class WeatherService {
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String _apiKey;

    WeatherService(this._apiKey);

    Future<Weather> getWeather(String cityName) async {
        final response = await http.get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'));

        if (response.statusCode == 200) {
            return Weather.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to load weather data');
        }   
    }

    Future<String> getCurrentCity() async {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        List<Placemark> placemarks = await Geolocator.placemarkFromCoordinates(
            position.latitude, position.longitude);

        String? city = placemarks[0].locality;

        return city ?? "Unknown";
    }
}