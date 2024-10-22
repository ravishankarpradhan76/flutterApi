import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

class PostApiRevision extends StatefulWidget {
  const PostApiRevision({super.key});

  @override
  State<PostApiRevision> createState() => _PostApiRevisionState();
}

class _PostApiRevisionState extends State<PostApiRevision> {
///formkey
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Api
  String? responseMessage;
  bool? isLoading;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(ApiUrls.loginUrl);

    Map<String, String> requestBody = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      print(url);
      print(requestBody.toString());
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      print(response.body.toString());
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          responseMessage = "Login Successful. Token: ${data['token']}";
        });
        showToast(context, responseMessage, Colors.green);
      } else {
        var errorResponse = jsonDecode(response.body);
        setState(() {
          responseMessage = errorResponse['error']; // Display error message
        });
        showToast(context, responseMessage, Colors.red);
      }
    } catch (e, _) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        responseMessage = "Error: $e $_";
      });
      showToast(context, responseMessage, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(12), // Add border radius here
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      labelText: "Enter Email-ID",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(12), // Add border radius here
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      labelText: "Enter Password",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  isLoading == true
                      ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                      : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          print("You tapped on login button");
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: const Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showToast(
      BuildContext context, String? responseMessage, MaterialColor green) {}
}

class ApiUrls {
  static String baseUrl = "https://dummyjson.com";
  static String productUrl = "/products";
  static String getPosts = "/posts";
  static const loginUrl = "https://reqres.in/api/login";
}
