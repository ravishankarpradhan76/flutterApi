import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Models/PostModel.dart';
import 'package:http/http.dart'as http;

class GetApiPractice extends StatefulWidget {
  const GetApiPractice({super.key});

  @override
  State<GetApiPractice> createState() => _GetApiPracticeState();
}

class _GetApiPracticeState extends State<GetApiPractice> {

  List<PostModel> postlist = [];

  Future<List<PostModel>> getUserApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postlist.clear();
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));
      }
      return postlist ;
    }else{
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot){
              if(!snapshot.hasData){
                return Text('loding');
              }else{
                return ListView.builder(
                  itemCount: postlist.length,
                    itemBuilder: (context , index){
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Title\n'+postlist[index].title.toString()),
                            SizedBox(height: 12,),
                            Text('Description\n'+postlist[index].body.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                });
            }},
          )
          )
        ],
      ),
    );
  }
}
