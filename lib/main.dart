import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easytodo/constants/config.dart';
import 'package:easytodo/providers/todos_provider.dart';
import 'package:easytodo/screens/home_screen.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodosProvider(),
        ),
      ],
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        fontFamily: "Rokh",
      ),
      locale: Locale("fa"),
      home: HomeScreen(),
    );
  }
}
