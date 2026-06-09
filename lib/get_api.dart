import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get_api extends StatefulWidget {
  const Get_api({super.key});

  @override
  State<Get_api> createState() => _Get_apiState();
}

class _Get_apiState extends State<Get_api> {
  bool loading = false;
  String Link = 'http://localhost/php/rest_api/apis/get.php';
  Future<List> getpostAPi() async {
    var response = await http.get(Uri.parse(Link));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getpostAPi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final PostList = snapshot.data!;

          return ListView.builder(
            itemCount: PostList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      PostList[index]['id'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(PostList[index]['title']),
                  subtitle: Column(
                    children: [
                      Text("User Id : ${PostList[index]['userId']}"),
                      SizedBox(height: 15),
                      Text(PostList[index]['body']),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
