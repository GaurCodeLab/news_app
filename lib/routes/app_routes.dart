import 'package:get/get.dart';

import 'package:news_app/views/main_view.dart';
import 'package:news_app/views/news_detail_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => MainView()),
    GetPage(name: '/details', page: () => NewsDetailView()),
  ];
}
