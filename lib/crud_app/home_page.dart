import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  //FETCH ("API")DATA FROM DATABASE MY SQL-------------------------
  String url = 'http://localhost/php/rest_api/apis/get.php';
  bool loading = false;

  Future<List> getpostAPi() async {
    setState(() {
      loading = true;
    });

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  //DELETE ("API") DATA FROM DATABASE MY SQL-------------------------
  String message = '';
  Future<void> deleteData(int id) async {
    var url = Uri.parse('http://localhost/php/rest_api/apis/delete.php?id=$id');

    var response = await http.delete(url);

    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        message = "Successfully Deleted";
      });
    } else {
      setState(() {
        message = "Failed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => add_api()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: FutureBuilder<List>(
        future: getpostAPi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var post = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(post['title'].toString()),
                      subtitle: Text(post['body'].toString()),
                      leading: CircleAvatar(child: Text(post['id'].toString())),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(
                          post['userId'].toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => update_api(
                                  id: post['id'],
                                  userId: post['userId'],
                                  title: post['title'],
                                  body: post['body'],
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.edit, color: Colors.blueGrey),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            deleteData(int.parse(post['id'].toString()));
                          },
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// UPDATE DATA PAGE
class update_api extends StatefulWidget {
  final dynamic id;
  final dynamic userId;
  final String title;
  final String body;

  const update_api({
    super.key,
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  State<update_api> createState() => _update_apiState();
}

class _update_apiState extends State<update_api> {
  //UPDATE ("API") DATA FROM DATABASE MY SQL-------------------------
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  //NEW ADDED 1.
  @override
  void initState() {
    super.initState();

    idController.text = widget.id.toString();
    titleController.text = widget.title;
    bodycontroller.text = widget.body;
    userIdController.text = widget.userId.toString();
  }

  String result = '';
  bool loading = false;
  String Link = 'http://localhost/php/rest_api/apis/update.php';

  Future<void> updateData() async {
    var response = await http.post(
      Uri.parse(Link),
      body: {
        "id": idController.text,
        "title": titleController.text,
        "body": bodycontroller.text,
        "userId": userIdController.text,
      },
    );

    if (response.statusCode == 200) {
      print("Successfully Updated");
      Navigator.pop(context);
    } else {
      print("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Page"),
        backgroundColor: const Color.fromARGB(255, 168, 222, 196),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: 'Enter id for delete?',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bodycontroller,
              decoration: InputDecoration(
                hintText: 'Body',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                hintText: 'User ID',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: updateData, child: Text("Update Data")),
          ],
        ),
      ),
    );
  }
}

//ADDING DATA PAGE
class add_api extends StatefulWidget {
  const add_api({super.key});

  @override
  State<add_api> createState() => _add_apiState();
}

class _add_apiState extends State<add_api> {
  //INSERT OR ADDING  ("API") DATA FROM DATABASE MY SQL-------------------------

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  String result = '';
  String Link = 'http://localhost/php/rest_api/apis/insert.php';
  bool loading = false;
  Future<void> insertData() async {
    setState(() {
      loading = true;
    });
    var url = Uri.parse(Link);
    var response = await http.post(
      url,
      body: {
        "title": titleController.text,
        "body": bodyController.text,
        "userId": userIdController.text,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        result =
            "Title:- ${data['title']}"
            "Body:- ${data['body']}"
            "User ID:-${data['userId']}";
      });
      Navigator.pop(context);
    } else {
      setState(() {
        result = 'failed';
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        centerTitle: true,
        title: Text("Insert Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(height: 30),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                hintText: 'Enter Body',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                hintText: 'Enter User-ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: insertData, child: Text('ADD')),
          ],
        ),
      ),
    );
  }
}
