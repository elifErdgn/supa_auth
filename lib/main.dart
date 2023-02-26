import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supa_auth/appProviders.dart';
import 'package:supa_auth/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  runApp(MultiProvider(providers: AppProviders.providers, child: MyApp()));

  WidgetsFlutterBinding.ensureInitialized();

  /// supabase ile bağlantı kurduğumuz kısım
  await Supabase.initialize(
    url: 'https://kygiuxpglxzfdaejyfio.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5Z2l1eHBnbHh6ZmRhZWp5ZmlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU3OTg0NjIsImV4cCI6MTk5MTM3NDQ2Mn0.x4s4CxTpLq60tqohV_lVlAihKAkI2EaVoxCPJpkapGE',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,

      /// ilk projenin kodlaması
      /// eğer login yapıldıysa ana sayfaya yapılmadıysa giriş yapma sayfasına yönlendirilecek
      home: SplasScreen(),
      //   initialRoute: supabase.auth.currentSession != null ? '/simpleapp' : '/',
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/signIn': (context) => const LoginEkrani(),
      //   '/signup': (context) => const KayitEkrani(),
      //   '/simpleapp': (context) => const SimpleAppPage(),
      // },
    );
  }
}
