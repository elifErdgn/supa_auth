
import 'package:flutter/cupertino.dart';

import 'cache_manager.dart';
import 'fake_model.dart';

class AuthenticationManager extends CacheManager {
  BuildContext context;

  AuthenticationManager({
    required this.context,
  });

  bool isLogin = false;
  UserModel? model;

  Future<void> fetchUserLogin() async {
    final token = await getToken();
    if (token != null) {
      isLogin = true;
    }
  }
}
