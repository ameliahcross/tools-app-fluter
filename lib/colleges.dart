import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Colleges extends StatefulWidget {
  @override
  _CollegesState createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {
  final TextEditingController _controller = TextEditingController();
  List _universities = [];
  bool _hasSearched = false;

  Future<void> _fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
        _hasSearched = true;
      });
    } else {
      setState(() {
        _universities = [];
        _hasSearched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colleges',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 100),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese un país',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _fetchUniversities(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Buscar',
                style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _hasSearched
                  ? _universities.isEmpty
                  ? const Center(child: Text('No data found'))
                  : ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final university = _universities[index];
                  return ListTile(
                    title: Text(university['name']),
                    subtitle: Text(university['domains'].join(', ')),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_browser),
                      onPressed: () {
                        final url = university['web_pages'][0];
                      },
                    ),
                  );
                },
              )
                  : const Center(child: Text('Veamos qué universidades se listan por país...')),
            ),
          ],
        ),
      ),
    );
  }
}