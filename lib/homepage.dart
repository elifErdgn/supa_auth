import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supa_auth/cache_manager.dart';
import 'package:supa_auth/fake_model.dart';
import 'package:supa_auth/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'authManager.dart';

final supabase = Supabase.instance.client;

class SplasScreen extends StatefulWidget {
  const SplasScreen({Key? key}) : super(key: key);

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  Future<void> controlToApp() async {
    await readAuthManager.fetchUserLogin();

    if (readAuthManager.isLogin) {
      await Future.delayed(Duration(seconds: 1));
      readAuthManager.model = UserModel.fake();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SimpleAppPage()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginEkrani()));
    }
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controlToApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CacheManager {
  String token = "";

  Future<void> getTokenCache() async {
    token = await getToken() ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KayitEkrani()));
            },
            child: Container(
              height: 50,
              width: 250,
              color: Colors.deepPurple.shade200,
              child: Center(child: Text("Kayıt Ol")),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginEkrani()));
            },
            child: Container(
              height: 50,
              width: 250,
              color: Colors.green.shade200,
              child: Center(child: Text("Giriş Yap")),
            ),
          ),
        ],
      ),
    );
  }
}

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  /// yeni kullanıcı oluşturma metodu
  /// çalışmak için iki adet parametre istiyor
  Future<dynamic> kayit() async {
    print("butona tıklandı");
    final userValue = await AuthServices().createUser(
      email: _email.text,
      password: _password.text,
    );
    if (userValue == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginEkrani(),
          ));
      print("kayıt başarılı");
    } else {
      print("kayıt başarısız");
    }
    print("metot sonu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Mailinizi giriniz"),
            SizedBox(height: 20),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text("Şifrenizi giriniz"),
            SizedBox(height: 20),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            /// kayıt olma butonu
            InkWell(
              onTap: kayit,
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.red,
                child: Center(
                  child: Text("Kayıt Ol"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  const LoginEkrani({Key? key}) : super(key: key);

  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
  TextEditingController _emailcont = TextEditingController();
  TextEditingController _passwordcont = TextEditingController();

//  bool _isLoading = false;

  @override
  void initState() {
    _emailcont = TextEditingController();
    _passwordcont = TextEditingController();
    super.initState();
  }

  Future<dynamic> giris() async {
    // setState(() {
    //   _isLoading = true;
    // });
    dynamic loginValue = await AuthServices().userLogin(
      email: _emailcont.text,
      password: _passwordcont.text,
    );
    // setState(() {
    //   _isLoading = false;
    // });
    if (loginValue != null) {
      print("giriş başarılı");
      print(loginValue);
      // Navigator.pushReplacementNamed(
      //   context,
      //   '/simpleapp',
      // );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SimpleAppPage()));
    } else {
      print("giriş başarısız");
      //  context.showErrorMessage('Invalid email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Mailinizi giriniz"),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailcont,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text("Şifrenizi giriniz"),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordcont,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            /*
           *  _isLoading
                ? Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                :
           * */
            InkWell(
              onTap: giris,
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.red,
                child: Center(
                  child: Text("Giris Yap"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleAppPage extends StatefulWidget {
  const SimpleAppPage({Key? key}) : super(key: key);

  @override
  State<SimpleAppPage> createState() => _SimpleAppPageState();
}

class _SimpleAppPageState extends State<SimpleAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                supabase.auth.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));

                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/', (route) => false);
              },
              icon: Icon(Icons.logout),
            );
          },
        ),
      ),
      body: Center(
        child: Column(),
      ),
    );
  }
}
