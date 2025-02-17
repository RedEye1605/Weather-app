import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage{{super.key}};

  @override
  State<WeatherPage> createState() => _WeatherPageState('1e06cc03851a1a1758d851f5462d9902');
}

class _WeatherPageState extends State<WeatherPage> {
    
    final _weatherservie = WeatherService(apiKey);
    Weather? _weather;

    _fetchWeather() async {
        String currentCity = await _weatherservie.getCurrentCity();

        try {
            final weather = await _weatherservie.getWeather(currentCity);
            setState(() {
                _weather = weather;
            });
        } catch (e) {
            print(e);
        }
    }

    String getWeatherIcon(String? mainCondition) {
        if (mainCondition == null) {
            return 'assets/Sunny.json';
        
        switch (mainCondition) {
            case 'clouds':
            case 'mist':
            case 'smoke':
            case 'haze':
            case 'dust':
            case 'fog':
                return 'assets/Cloudy.json';
            case 'shower rain':
                return 'assets/Rain.json';
            case 'thunderstorm':
                return 'assets/Thunder.json';
            case 'clear':
                return 'assets/Sunny.json';
            default:
                return 'assets/Sunny.json';
        }
    }

    @override
    void initState() {
        super.initState();
        _fetchWeather();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(_weather?.cityName ?? "Loading city..."),

                Lottie.asset(
                    getWeatherIcon(_weather?.mainCondition),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                ),

                Text(_weather?.temperature.round() + '°C' ?? "Loading temperature..."),
                
                Text(_weather?.mainCondition ?? "Loading condition..."),
                ],
            ),
        ),
    );
  }
}