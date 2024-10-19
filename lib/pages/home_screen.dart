import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/UserModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<UserModel>> getUserApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<UserModel> userList = [];
      var data = jsonDecode(response.body);
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Learn Flutter'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: getUserApi(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'id',
                              value: snapshot.data![index].id.toString()),
                          ReusableRow(
                              title: 'name',
                              value: snapshot.data![index].name.toString()),
                          ReusableRow(
                              title: 'username',
                              value: snapshot.data![index].username.toString()),
                          ReusableRow(
                              title: 'email',
                              value: snapshot.data![index].email.toString()),
                          ReusableRow(
                              title: 'address',
                              value: snapshot.data![index].address.toString()),
                          ReusableRow(
                              title: 'city',
                              value: snapshot.data![index].address!.city.toString()),
                          ReusableRow(
                              title: 'zipcode',
                              value: snapshot.data![index].address!.zipcode.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
