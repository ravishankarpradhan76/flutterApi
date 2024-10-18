import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  Future<List<Photos>> getPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data as List).map((i) => Photos(
        title: i['title'],
        id: i['id'],
      )).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Learn API'),
      ),
      body: FutureBuilder<List<Photos>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUPzMi51UtloTlOO8ro3vKpZLnjspNBJtZ1w&s'), // Placeholder image
                ),
                subtitle: Text(snapshot.data![index].title),
                title: Text('Notes id: ${snapshot.data![index].id}'),
              );
            },
          );
        },
      ),
    );
  }
}

class Photos {
  String title;
  int id;

  Photos({required this.title, required this.id});
}
