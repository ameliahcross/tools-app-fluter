import 'package:flutter/material.dart';

class Acerca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de mí', style: TextStyle(
            fontSize: 24,
            color: Colors.white
        ),),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto de perfil
            SizedBox(height: 100),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/foto.png'),
            ),
            SizedBox(height: 20),
            // Nombre
            Text(
              'Amelia Henríquez',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Título o profesión
            Text(
              'Developer & UI/UX',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'Contacto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Text('amelia@yahoo.com'),
              ],
            ),
            SizedBox(height: 10),
            // LinkedIn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.web),
                SizedBox(width: 10),
                Text('linkedin.com/in/ameliahcross'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}