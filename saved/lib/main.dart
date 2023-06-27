import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String data = "No Data";
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Material App Bar'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences toSave =
                                await SharedPreferences.getInstance();
                            bool isSaved = await toSave.setString(
                                "first", _textEditingController.text);
                            if (isSaved) {
                              print("Saved");
                            } else {
                              print("Not Saved");
                            }
                          },
                          child: const Text("Save")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences toShow =
                                await SharedPreferences.getInstance();
                            String? printDate = toShow.getString("first");
                            setState(() {
                              data = printDate ?? "";
                            });
                          },
                          child: const Text("Show")),
                    )
                  ],
                ),
                Text(data)
              ],
            )));
  }
}
