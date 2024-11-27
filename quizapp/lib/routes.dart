import 'package:flutter/material.dart';
import 'package:quizapp/handler/apis/login.dart';
import 'package:quizapp/screens/auth/login_screen.dart';

import 'main.dart';

class RouteNames {
  static const String landing = "/";
  static const String login = "/login";
}

Route? routes(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.landing:
      return MaterialPageRoute(builder: (context) {
        return FutureBuilder<void>(
            future: Auth().getAccessToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Error fetching token');
              }
              var hasAccessToken = Auth().hasAccessToken;
              print(hasAccessToken);
              if (hasAccessToken != null) {
                return const Root(title: 'Root');
              }
              return const LoginScreen();
            });
      });
    default:
      return null;
  }
}
