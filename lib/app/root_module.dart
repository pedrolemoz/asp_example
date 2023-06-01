import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'authentication/authentication_module.dart';
import 'authentication/reactivity/login/login_reducer.dart';
import 'authentication/services/authentication_service.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AuthenticationService()),
        Bind.singleton<Reducer>(
          (i) => LoginReducer(i()),
          onDispose: (reducer) => reducer.dispose(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: AuthenticationModule(),
        ),
      ];
}
