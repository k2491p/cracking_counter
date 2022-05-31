import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/infrastructure/sqlite/db_helper.dart';
import 'package:cracking_counter/presentation/component/footer.dart';
import 'package:cracking_counter/presentation/page/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  initialize();
  runApp(const MyApp());
}

Future<void> initialize() async {
  const storage = FlutterSecureStorage();
  Shared.userId = await storage.read(key: 'userId');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Register(title: 'Flutter Demo Home Page'),
    );
  }
}
