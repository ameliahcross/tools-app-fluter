import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String apiKey = '8b3075a93faec55e1d46ab6730523129';
  String city = 'Santo Domingo, RD';
  String country = 'DO';
  var temperature;
  var description;
  var humidity;
  var windSpeed;

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city,$country&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temperature = data['main']['temp'];
          description = data['weather'][0]['description'];
          humidity = data['main']['humidity'];
          windSpeed = data['wind']['speed'];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener los datos: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather',  style: TextStyle(
            fontSize: 22,
            color: Colors.white
        ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: temperature == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 34, color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/weather.png',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            Text(
              '$temperature°C',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$description',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Humedad: $humidity%',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Velocidad del viento: $windSpeed m/s',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
