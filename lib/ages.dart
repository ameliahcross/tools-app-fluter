import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ages extends StatefulWidget {
  @override
  _AgesState createState() => _AgesState();
}

class _AgesState extends State<Ages> {
  final TextEditingController _nameController = TextEditingController();
  String _message = '';
  String _ageCategory = '';
  int? _age;
  String _imagePath = '';

  Future<void> _fetchAge(String name) async {
    final url = Uri.parse('https://api.agify.io/?name=$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final int age = data['age'];

      setState(() {
        _age = age;
        if (age < 18) {
          _ageCategory = 'Joven';
          _imagePath = 'assets/young.png';
        } else if (age < 60) {
          _ageCategory = 'Adulto';
          _imagePath = 'assets/adult.png';
        } else {
          _ageCategory = 'Anciano';
          _imagePath = 'assets/elderly.png';
        }
        _message = '$age años.\n $_ageCategory';

      });
    } else {
      setState(() {
        _message = 'Error al obtener la edad.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Prediction', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingresa un nombre para predecir la edad:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Ingresa el nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  _fetchAge(_nameController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Predecir',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_imagePath.isNotEmpty) Image.asset(_imagePath, height: 150),
          ],
        ),
      ),
    );
  }
}
