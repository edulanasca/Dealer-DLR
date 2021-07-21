import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getPreferences().then((value){
      print (value);
        redireccionar(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 164, 36, 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Image.asset("assets/images/img2_loading.png"),
              bottom: -60,
              left: -60,
              height: MediaQuery.of(context).size.height * 0.55,
            ),
            Positioned(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset("assets/images/img3_loading.png"),
              bottom: 0,
              right: 0,
            ),
            Positioned(
              child: Image.asset("assets/images/logo_blanco.png"),
              width: MediaQuery.of(context).size.width * 0.8,
              top: 200,
            ),
          ],
        ),
      ),
    );
  }

  getPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('tipo');
  }
  redireccionar(String tipo) async{
    switch (tipo) {
      case '0':
        Navigator.of(context)
            .pushNamed('/principal_conductor', arguments: '0');
        break;
      case '1':
        Navigator.of(context).pushNamed('/principal_empresa', arguments: '0');
        break;
      default:
        Timer(Duration(seconds: 1),
                () => Navigator.of(context).pushReplacementNamed('/login'));
        break;
    }
  }
}
