import 'package:flutter_modular/flutter_modular.dart';

import 'pages/initial_page.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';

class AuthenticationModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const InitialPage(),
        ),
        ChildRoute(
          '/login',
          child: (context, args) => const LoginPage(),
        ),
        ChildRoute(
          '/registration',
          child: (context, args) => const RegistrationPage(),
        ),
      ];
}
