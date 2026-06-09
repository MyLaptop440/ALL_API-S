import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteApiScreen extends StatefulWidget {
  const DeleteApiScreen({super.key});

  @override
  State<DeleteApiScreen> createState() => _DeleteApiScreenState();
}

class _DeleteApiScreenState extends State<DeleteApiScreen> {
  String message = '';

  Future<void> deleteData() async {
    var url = Uri.parse('http://localhost/php/rest_api/apis/delete.php');

    var response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        message = "Data Deleted Successfully";
      });
    } else {
      setState(() {
        message = "Delete Failed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DELETE API"),
        backgroundColor: Colors.red,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),

                onPressed: deleteData,
                child: const Text(
                  "Delete Data",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              Text(message, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
