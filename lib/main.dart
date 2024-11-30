import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.flutter_native_example/date');

  Future<String> getCurrentDate() async {
    try {
      final String currentDate = await platform.invokeMethod('getCurrentDate');
      return currentDate;
    } on PlatformException catch (e) {
      return "Failed to get date: '${e.message}'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Native Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<String>(
                future: getCurrentDate(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('Current date: ${snapshot.data}');
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Image.file(File(photo.path)),
                        );
                      },
                    );
                  }
                },
                child: Text('Take Photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
