import 'package:supa_auth/cache_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthServices {
  /// yeni kullanıcı oluşturma metodu
  /// çalışmak için iki adet parametre istiyor
  Future<bool> createUser({
    required final String email,
    required final String password,
  }) async {
    final AuthResponse response = await supabase.auth.signUp(
      password: password.trim(),
      email: email.trim(),

      ///trim giriş yapılırken bırakılan boşukları ortadan kaldırmak için kullanılıyor.
    );
    final session = response.session;
    if (session == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> userLogin({
    required final String email,
    required final String password,
  }) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
    final Session? session = response.session;
    if (session != null) {
      CacheManager().saveToken(session.accessToken);
      print("token" + session.accessToken );

    }
    print("service sonu");
    final user = response.user;
    return user?.id;
  }
}
