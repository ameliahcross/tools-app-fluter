import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Wordpress extends StatefulWidget {
  @override
  _WordpressState createState() => _WordpressState();
}

class _WordpressState extends State<Wordpress> {
  // Nueva API de ejemplo de Kinsta
  final String apiUrl = 'https://kinsta.com/wp-json/wp/v2/posts';
  List posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Función para obtener las noticias del API
  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          posts = jsonDecode(response.body);
        });
      } else {
        throw Exception('Error al obtener las noticias');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Función para abrir el enlace en el navegador
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de Kinsta',  style: TextStyle(
            fontSize: 24,
            color: Colors.white
        ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmPeWMzoYMP9bHoeQpl1ZcKaBU8sC92WnGVw&s', // Logo de Kinsta
              height: 100,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Mostramos las últimas 3 noticias
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(
                    post['title']['rendered'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    post['excerpt']['rendered'].replaceAll(RegExp(r'<[^>]*>'), ''), // Quitamos etiquetas HTML
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () {
                      _launchURL(post['link']); // Abre la noticia en el navegador
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}