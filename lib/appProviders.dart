import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'authManager.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    Provider<AuthenticationManager>(
      create: (context) => AuthenticationManager(context: context),
    ),
  ];
}
