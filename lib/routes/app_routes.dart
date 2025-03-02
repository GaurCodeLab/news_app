import 'package:get/get.dart';

import 'package:news_app/views/main_view.dart';
import 'package:news_app/views/news_detail_view.dart';


/// This class contains static constants that represent the names of the 
/// different routes in the app. These routes are used for navigation 
/// throughout the application.
class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => MainView()),
    GetPage(name: '/details', page: () => NewsDetailView()),
  ];
}
