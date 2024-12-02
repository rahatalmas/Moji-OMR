import 'package:quizapp/handler/models/login.dart';

/// Abstract class for authentication.
abstract class BaseAuthHandler {

  // function to return login information.
  Future<Login?> login(String user, String password);

  bool isLoggedIn();

  Future<void> refreshUserToken();

  Future<void> setAccessToken();

  Future<void> getAccessToken();
}
