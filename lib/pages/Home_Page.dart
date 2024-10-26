import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Details_Page.dart'; // Ensure you import your DetailsPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<dynamic>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.org/posts'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data; // Return the raw data
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: '  Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Show loading indicator
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  data: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(23.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                    .data![index]['image'] ??
                                                ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'ID: ${snapshot.data![index]['id']}'),
                                                SizedBox(height: 10),
                                                Text(
                                                    'Slug: ${snapshot.data![index]['slug']}'),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Title: ${snapshot.data![index]['title']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Content: ${snapshot.data![index]['content']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Category: ${snapshot.data![index]['category']}',
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              right: 1,
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                child: Center(
                                                    child: Text('Status',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 26,
                                right: 30,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  child: Center(
                                      child: Text('Published',
                                          style:
                                              TextStyle(color: Colors.white))),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
