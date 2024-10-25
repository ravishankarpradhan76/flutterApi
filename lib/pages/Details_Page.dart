import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic data; // Accept data dynamically

  DetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children:[ Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                Container(
                  height: 300,
                  width: double.infinity, // Use double.infinity for responsiveness
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(data['image']), // Correctly reference data
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Add some spacing
                Text('ID: ${data['id']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 5),
                Text('Slug: ${data['slug']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 5),
                Text('Title: ${data['title']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Content: ${data['content']}', style: TextStyle(fontSize: 16)),
              ],
            ),
              Positioned(
              top: 15,
                right: 15,
                child: Container(
                  height: 40,
                  width: 80,
                  child: Center(
                      child: Text('Status',
                          style:
                          TextStyle(color: Colors.white))),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
          ]
          ),
        ),
      ),
    );
  }
}
