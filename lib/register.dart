import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  Register({super.key});
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();

  TextEditingController remail = TextEditingController(text: '');
  TextEditingController rpassword = TextEditingController(text: '');
  TextEditingController rname = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    void showAlert() {
      QuickAlert.show(context: context, type: QuickAlertType.success);
    }

    return Form(
        key: _registerkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: rname,
              style: const TextStyle(color: Colors.white70),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white38),
                hintText: 'Enter your Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: remail,
              style: const TextStyle(color: Colors.white70),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white38),
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: rpassword,
              obscureText: true,
              style: const TextStyle(color: Colors.white70),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white38),
                hintText: 'Enter your Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xffe8e8e8))),
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_registerkey.currentState!.validate()) {
                    // print(remail.text + rpassword.text);

                    final response = await http.post(
                      Uri.parse('${dotenv.env['host']}/signup'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({
                        "email": remail.text,
                        "password": rpassword.text,
                        "username": rname.text
                        // Your request body here
                      }),
                    );

                    if (response.statusCode == 200) {
                      // print('Response: ${response.body}');
                      showAlert();
                    } else {
                      print(
                          'Request failed with status: ${response.statusCode}');
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
