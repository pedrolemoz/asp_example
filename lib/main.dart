import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/root_module.dart';
import 'app/root_widget.dart';

void main() => runApp(
      RxRoot(
        child: ModularApp(
          module: RootModule(),
          child: const RootWidget(),
        ),
      ),
    );
