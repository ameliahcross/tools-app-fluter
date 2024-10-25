import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Genders extends StatefulWidget {
  @override
  _GendersState createState() => _GendersState();
}

class _GendersState extends State<Genders> {
  String _name = '';
  String _gender = '';
  Color _backgroundColor = Colors.white;

  Future<void> predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        _backgroundColor = _gender == 'male' ? Colors.lightBlueAccent : Color(0xFFF48FB1);
      });
    } else {
      setState(() {
        _gender = 'Error fetching data';
        _backgroundColor = Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Prediction',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: _backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tu nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictGender(_name);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Predecir género',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _gender.isNotEmpty ? 'Gender: $_gender' : 'Ingrese un nombre a predecir',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
