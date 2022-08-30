import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/database/local_storage.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/pages/home_page.dart';
final locator = GetIt.instance;
void setup(){
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> setupHive() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var taskBox = await Hive.openBox<Task>('tasks');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await setupHive();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
        elevation: 0,
      backgroundColor: Colors.blueGrey,
          iconTheme: IconThemeData(color: Colors.black),
      ),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
