import 'package:dealer/Views/Condutor/RegistroConductor/registro_conductor.dart';
import 'package:dealer/Views/Condutor/principal_conductor.dart';
import 'package:dealer/Views/Empresa/RegistroEmpresa/registro_empresa.dart';
import 'package:dealer/Views/Empresa/principal_empresa.dart';
import 'package:dealer/Views/LoadingScreen/Screen.dart';
import 'package:dealer/Views/Login/login.dart';
import 'package:flutter/material.dart';

import 'Bean/Bean_ficha.dart';
import 'Views/Empresa/Envios/Components/Mapa/mapa.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/registro_conductor':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RegistroConductor(
              data: args,
            ),
          );
        }
        return _errorRoute();

      case '/registro_empresa':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RegistroEmpresa(
              data: args,
            ),
          );
        }
        return _errorRoute();

      case '/principal_conductor':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => PrincipalConductor(
              data: args,
            ),
          );
        }
        return _errorRoute();

      case '/principal_empresa':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => PrincipalEmpresa(
              data: args,
            ),
          );
        }
        return _errorRoute();
      case '/mapa':
        if (args is ficha) {
          return MaterialPageRoute(
            builder: (_) => MapScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
