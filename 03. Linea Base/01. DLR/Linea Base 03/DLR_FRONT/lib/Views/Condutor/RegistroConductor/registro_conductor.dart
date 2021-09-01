import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dealer/constats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroConductor extends StatefulWidget {
  final String data;
  const RegistroConductor({Key key, this.data}) : super(key: key);
  @override
  _RegistroConductorState createState() => _RegistroConductorState();
}

class _RegistroConductorState extends State<RegistroConductor> {

  bool _passwordVisible ;
  bool _passwordVisible2;

  bool _checked;

  final _formRegistroConductor = GlobalKey<FormState>();
  TextEditingController nombre;
  TextEditingController apellido;
  TextEditingController correo;
  TextEditingController celular;
  TextEditingController pass1;
  TextEditingController pass2;
  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    _checked = false;
    nombre = new TextEditingController();
    apellido = new TextEditingController();
    correo = new TextEditingController();
    celular = new TextEditingController();
    pass1 = new TextEditingController();
    pass2 = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          widget.data,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/icons/icon_close.png",
              color: kPrimaryColor,
              height: 20,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Form(
            key: _formRegistroConductor,
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/icons/carr_flash.png",
                  width: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextFormField(
                          controller: nombre,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "NOMBRES",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            return value.isEmpty ? 'Campo Obligatorio' :RegExp(r'[!@.°{}©®™✓%•√π÷×¶∆£¢€¥$#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)? 'Nombre no válido':null;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: apellido,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "APELLIDOS",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            return value.isEmpty ? 'Campo Obligatorio' :RegExp(r'[!@.°{}©®™✓%•√π÷×¶∆£¢€¥#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)? 'Apellido no válido':null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextFormField(
                          controller: correo,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "CORREO",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            return value.isEmpty ? 'Campo Obligatorio' : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)?null:'Correo no válido';
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: celular,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            hintText: "CELULAR",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            return value.isEmpty ? 'Campo Obligatorio' : !RegExp(r"^([0-9])*$").hasMatch(value)?'Solo números': value.length!=9?'Son 9 Dígitos':null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: pass1,
                  obscureText:
                  !_passwordVisible, //This will obscure text dynamically
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                        color: kPrimaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kPrimaryColor,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: pass2,
                  obscureText:
                  !_passwordVisible2, //This will obscure text dynamically
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    labelStyle: TextStyle(
                        color: kPrimaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CheckboxListTile(
                    title: Text(
                      "Acepto los Términos y Condiciones de Delaer para el tratamiento de mis datos.",
                    ),
                    secondary: Icon(
                      Icons.beach_access,
                      color: _checked ? kPrimaryColor : Colors.grey,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checked,
                    onChanged: (bool value) {
                      setState(() {
                        _checked = value;
                      });
                    },
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    dense: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
                  ),
                  onPressed: () {
                    if (_formRegistroConductor.currentState.validate()) {
                      if (pass1.text != pass2.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Las contraseñas no coinciden.")));
                      } else if (_checked) {
                        registrarConductor();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Acepte nuestros términos y condiciones.")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                          Text("Complete todos lo Campos Obligatorios.")));
                    }
                  },
                  child: Text('REGISTRAR CONDUCTOR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future registrarConductor() async {
/*
    print(nombre.text);
    print(apellido.text);
    print(correo.text);
    print(celular.text);
    print(pass1.text);
    print(1);
    print(0);

*/
    var url = Uri.parse(
        'https://dealertesting.000webhostapp.com/App_modulos_conductor/App_registrar_conductor.php');
    var response = await http.post(url, body: {
      'nombre': nombre.text,
      'apellido': apellido.text,
      'correo': correo.text,
      'celular': celular.text,
      'passw': pass1.text,
      'tipo': '0',
      'status': '0'
    });


    var data = response.body==""?{'0':'-1'}:json.decode(response.body);
    print(data);
    print("${data['0']}");

    switch("${data['0']}"){
      case "0":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No se pudo registrar \nMotivo: El correo ya ha sido registrado"),
          ),
        );
        break;
      case "1":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registro exitoso!.\nSe enviará un correo en los próximos minutos."),
          ),
        );
        Timer(Duration(seconds: 1),
                () => Navigator.of(context).pushReplacementNamed('/login'));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 10),
            content: Text("Ocurrió algo inesperado\n Motivo: Error del Servidor"),
          ),
        );
        break;
    }


    

  }
}
