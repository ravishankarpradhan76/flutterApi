import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List posts = [];
  List filteredPosts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.org/posts/id'));

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
        filteredPosts = posts; // Initialize filteredPosts
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  void filterPosts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPosts = posts; // Reset to all posts
      });
    } else {
      setState(() {
        filteredPosts = posts.where((post) => post['title'].toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: filterPosts, // Filter posts on text change
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPosts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredPosts[index]['title']),
                    subtitle: Text(filteredPosts[index]['body']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
