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
      /// A list of routes for the application.
      /// 
      /// This is used to define the navigation paths and their corresponding screens
      /// within the app. The `AppRoutes.routes` should be a list of `GetPage` objects
      /// that specify the route name and the widget to be displayed for that route.
      getPages: AppRoutes.routes,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
