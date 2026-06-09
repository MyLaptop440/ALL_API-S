import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateApiScreen extends StatefulWidget {
  const UpdateApiScreen({super.key});

  @override
  State<UpdateApiScreen> createState() => _UpdateApiScreenState();
}

class _UpdateApiScreenState extends State<UpdateApiScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController idController = TextEditingController();

  String result = "";
  bool loading = false;
  Future<void> updateData() async {
    var response = await http.post(
      Uri.parse("http://localhost/php/rest_api/apis/update.php"),
      body: {
        "id": idController.text,
        "title": titleController.text,
        "body": bodyController.text,
        "userId": userIdController.text,
      },
    );

    if (response.statusCode == 200) {
      print("Updated Successfully");
    } else {
      print("Update Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update API"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: "ID",
                border: OutlineInputBorder(),
                hintText: "Which ID to update?",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(
                labelText: "User ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateData,
              child: const Text("Update Data"),
            ),

            if (loading) CircularProgressIndicator(),
            const SizedBox(height: 20),

            if (!loading && result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: result.contains("✅")
                      ? Colors.green[100]
                      : Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(result),
              ),
          ],
        ),
      ),
    );
  }
}
