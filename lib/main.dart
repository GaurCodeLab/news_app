import 'package:flutter/material.dart';


import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:news_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'news app',
      initialRoute: '/',
      getPages: AppRoutes.routes,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
