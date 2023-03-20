import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supa_auth/appProviders.dart';
import 'package:supa_auth/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  runApp(MultiProvider(providers: AppProviders.providers, child: MyApp()));

  WidgetsFlutterBinding.ensureInitialized();

  /// supabase ile bağlantı kurduğumuz kısım
  await Supabase.initialize(
    url: 'own-url',
    anonKey:
        'own-anonKey',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      /// ilk projenin kodlaması
      /// eğer login yapıldıysa ana sayfaya yapılmadıysa giriş yapma sayfasına yönlendirilecek
      home: SplasScreen(),
    );
  }
}
