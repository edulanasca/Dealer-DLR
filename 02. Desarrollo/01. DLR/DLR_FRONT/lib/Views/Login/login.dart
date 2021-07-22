import 'dart:convert';

import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _keylogin = GlobalKey<FormState>();
  FocusNode inputCorreo = new FocusNode();
  FocusNode inputPass = new FocusNode();

  TextEditingController correo, pass;

  Color _colorLogin = kPrimaryColor;
  Color _colorRegistro = Colors.white;
  String tipo;
  List<String> miUsuario;
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    correo = new TextEditingController();
    pass = new TextEditingController();
    imprimirPreferencias();
  }

  void userSignIn() async {
    var url = Uri.parse('https://dealertesting.000webhostapp.com/login.php');
    var response =
        await http.post(url, body: {'correo': correo.text, 'pass': pass.text});
    redireccionar( response );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(img1, width: double.infinity),
            Positioned(
              bottom: 40.0,
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _keylogin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(img2,
                          height: 150.0, alignment: Alignment.center),
                      Container(
                        child: TextFormField(
                          controller: correo,
                          focusNode: inputCorreo,
                          decoration: InputDecoration(
                            labelText: 'CORREO',
                            labelStyle: TextStyle(
                                color: inputCorreo.hasFocus
                                    ? Colors.white
                                    : Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: -3,
                                blurRadius: 7,
                                offset: Offset(5, 5)),
                          ],
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: pass,
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                                color: inputCorreo.hasFocus
                                    ? Colors.white
                                    : Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: -3,
                              blurRadius: 7,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Builder(
                                  builder: (context) => ElevatedButton(
                                    onPressed: () {
                                      userSignIn();
                                      setState(() {
                                        _colorLogin = kPrimaryColor;
                                        _colorRegistro = Colors.white;
                                      });
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: _colorRegistro,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: _colorLogin,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(0.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(0.0),
                                  ),
                                  border: Border.all(
                                    width: 2.0,
                                    color: kPrimaryColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: FocusedMenuHolder(
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.50,
                                menuBoxDecoration:
                                    BoxDecoration(color: Colors.transparent),
                                blurSize: 5.0,
                                menuItemExtent: 80, //altura de cada item list
                                duration: Duration(milliseconds: 100),
                                animateMenuItems: true,
                                blurBackgroundColor:
                                    Colors.white, //default: Colors.black54
                                openWithTap: true,
                                menuOffset: 20,
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(
                                    backgroundColor: Colors.transparent,
                                    title: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.50 -
                                          30,
                                      child: Center(
                                        child: Text(
                                          "CONDUCTOR",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          topRight: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0),
                                        ),
                                        border: Border.all(
                                          width: 2.0,
                                          color: kPrimaryColor,
                                          style: BorderStyle.solid,
                                        ),
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      print("registro conductor");
                                      Navigator.of(context).pushNamed(
                                          '/registro_conductor',
                                          arguments: 'REGISTRO DE CONDUCTOR');
                                    },
                                  ),
                                  FocusedMenuItem(
                                    backgroundColor: Colors.transparent,
                                    title: Container(
                                      width: MediaQuery.of(context).size.width *
                                              0.50 -
                                          30,
                                      child: Center(
                                        child: Text(
                                          "EMPRESA",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          topRight: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0),
                                        ),
                                        border: Border.all(
                                          width: 2.0,
                                          color: kPrimaryColor,
                                          style: BorderStyle.solid,
                                        ),
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      print("registro empresa");
                                      Navigator.of(context).pushNamed(
                                          '/registro_empresa',
                                          arguments: 'REGISTRO DE EMPRESA');
                                    },
                                  ),
                                ],
                                onPressed: () {
                                  setState(() {
                                    _colorRegistro = kPrimaryColor;
                                    _colorLogin = Colors.white;
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _colorRegistro,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    border: Border.all(
                                      width: 2.0,
                                      color: kPrimaryColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Registro",
                                      style: TextStyle(
                                        color: _colorLogin,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: -3,
                              blurRadius: 7,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void redireccionar(response) {
    if(response.body=='false'){
      tipo = "-3";
    }else{
        var data = json.decode(response.body);
        if (data['FALSE'] != '0') {
          miUsuario = [];
          int size = data.length;
          for (int i = 0; i < size/2; i++) {
            miUsuario.add("${data['$i']}");
          }
          if(data['STATUS']=='1'){
            setState(() {
              tipo = data['TIPO'];
            });
            guardarPreferencias();
          }else{
            setState(() {
              tipo = "-2";
            });
          }
        } else {
          tipo = "-1";
        }
    }


    switch (tipo) {
      case '0':
        Navigator.of(context).pushNamed('/principal_conductor', arguments: '0');
        break;
      case '1':
        Navigator.of(context).pushNamed('/principal_empresa', arguments: '0');
        break;
      case '-2':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("La cuenta todavía no ha sido habilitada!"),
            duration: Duration(seconds: 10),
          ),
        );
        break;
      case '-3':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error en el servidor espere unos minutos!"),
            duration: Duration(seconds: 10),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario Incorrecto!"),
            duration: Duration(seconds: 10),
          ),
        );
        break;
    }





  }

  imprimirPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(
        "LOGIN shared preferences miUsuario : ${preferences.getStringList('miUsuario')}");
    print("LOGIN shared preferences tipo : ${preferences.getString('tipo')}");
  }

  guardarPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("miUsuario", miUsuario);
    preferences.setString("tipo", tipo);
    imprimirPreferencias();
  }
}
