import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool _passwordVisible;
  bool _passwordVisible2;
  List<String> _distritos = [
    'Ancón',
    'Ate Vitarte',
    'Barranco',
    'Breña',
    'Carabayllo',
    'Chaclacayo',
    'Chorrillos',
    'Cieneguilla',
    'Comas',
    'El Agustino',
    'Independencia',
    'Jesús María',
    'La Molina',
    'La Victoria',
    'Cercado de Lima',
    'Lince',
    'Los Olivos',
    'Lurigancho',
    'Lurín',
    'Magdalena del Mar',
    'Miraflores',
    'Pachacamac',
    'Pucusana',
    'Pueblo Libre',
    'Puente Piedra',
    'Punta Hermosa',
    'Punta Negra',
    'Rímac',
    'San Bartolo',
    'San Borja',
    'San Isidro',
    'San Juan de Lurigancho',
    'San Juan de Miraflores',
    'San Luis',
    'San Martín de Porres',
    'San Miguel',
    'Santa Anita',
    'Santa María del Mar',
    'Santa Rosa',
    'Santiago de Surco',
    'Surquillo',
    'Villa El Salvador',
    'Villa María del Triunfo'
  ];
  String _distrito = "";

  bool _checked;

  final _formRegistroEmpresa = GlobalKey<FormState>();
  TextEditingController nombre;
  TextEditingController razon;
  TextEditingController correo;
  TextEditingController ruc;
  TextEditingController direccion;
  TextEditingController interior;
  TextEditingController celular;
  TextEditingController pass1;
  TextEditingController pass2;
  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
    _checked = false;
    nombre = new TextEditingController();
    razon = new TextEditingController();
    correo = new TextEditingController();
    ruc = new TextEditingController();
    direccion = new TextEditingController();
    interior = new TextEditingController();
    celular = new TextEditingController();
    pass1 = new TextEditingController();
    pass2 = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Form(
          key: _formRegistroEmpresa,
          child: Column(
            children: <Widget>[
              Text("CUENTA EMPRESARIAL", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: kPrimaryColor),),
              SizedBox(height: 15,),
              Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: nombre,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "NOMBRE COMERCIAL",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          return value.isEmpty ? null :RegExp(r'[!@.°{}©®™✓%•√π÷×¶∆£¢€¥$#<>?":_`~;[\]\\|=+)(*&^%0-9]').hasMatch(value)? 'Nombre no válido':null;
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
                        controller: ruc,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "RUC",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          return value.isEmpty ? null : !RegExp(r"^([0-9])*$").hasMatch(value)?'Solo números': value.length!=11?'Son 11 Dígitos':null;
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
                controller: razon,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  hintText: "RAZÓN SOCIAL",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  return value.isEmpty ?  null :RegExp(r'[!@°{}©®™✓%•√π÷×¶∆£¢€¥$#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)? 'Nombre no válido':null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: direccion,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "DIRECCIÓN",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          return value.isEmpty ? null : null;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: interior,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "Int.(opcional)",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  iconSize: 40,
                  iconEnabledColor: kPrimaryColor,
                  value: _distrito == "" ? null : _distrito,
                  items: _distritos.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _distrito = newValue;
                    });
                  },
                  hint: Center(
                    child: Text(
                      "-- Cambiar Distrito --",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ),
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
                          return value.isEmpty ? null : null;
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
                          return value.isEmpty ? null : !RegExp(r"^([0-9])*$").hasMatch(value)?'Solo números': value.length!=9?'Son 9 Dígitos':null;
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
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: kPrimaryColor),
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
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
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
                obscureText: !_passwordVisible2,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  labelStyle: TextStyle(color: kPrimaryColor),
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
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                onPressed: () {
                  if (_formRegistroEmpresa.currentState.validate()) {
                    if (pass1.text != pass2.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Las contraseñas no coinciden.")));
                    } else if (_checked) {
                      modificarEmpresa();
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
                child: Text('ACTUALIZAR DATOS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future modificarEmpresa() async {
    var url = Uri.parse(
        'https://dealertesting.000webhostapp.com/App_modulos_empresa/App_registrar_empresa.php');
    var response = await http.post(url, body: {
      'comercial': nombre.text,
      'ruc': ruc.text,
      'razon': razon.text,
      'direccion': direccion.text,
      'interior': interior.text==""?"0":interior.text,
      'distrito': "${_distritos.indexOf(_distrito) + 1}",
      'correo': correo.text,
      'celular': celular.text,
      'passw': pass1.text,
      'tipo': '1',
      'status': '0'
    });

    print(response.body=='false'?'null':'tiene contenido');
    print(response.body);

    var data = response.body!='false'?json.decode(response.body):{'0' : "-1"};
    switch ("${data['0']}") {
      case "0":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "No se pudo registrar \nMotivo: El correo ya ha sido registrado"),
          ),
        );
        break;
      case "1":
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Registro exitoso!.\nSe enviará un correo en los próximos minutos."),
          ),
        );
        Timer(Duration(seconds: 1),
                () => Navigator.of(context).pushReplacementNamed('/login'));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 10),
            content:
            Text("Ocurrió algo inesperado\n Motivo: Error del Servidor"),
          ),
        );
        break;
    }


  }
}
