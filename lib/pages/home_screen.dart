import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/PostModels.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModels> postList = [];

  Future<List<PostModels>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModels.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loding');
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('ID',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                        SizedBox(width: 8,),
                                        Text(postList[index].id.toString()),
                                      ],
                                    ),
                                    Text('Title',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    Text(postList[index].title.toString()),
                                    Text('Description',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    Text(postList[index].body.toString()),

                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
