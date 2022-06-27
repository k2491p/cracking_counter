import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/infrastructure/sqlite/db_helper.dart';
import 'package:cracking_counter/presentation/component/footer.dart';
import 'package:cracking_counter/presentation/page/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  await initialize();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.open();
  const storage = FlutterSecureStorage();
  Shared.userId = (await storage.read(key: 'userId'))!;
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 730),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child) =>
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Register(title: 'Flutter Demo Home Page'),
        ),
    );
  }
}
