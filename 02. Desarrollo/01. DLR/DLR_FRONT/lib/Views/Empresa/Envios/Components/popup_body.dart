import 'dart:async';
import 'dart:ui';
import 'package:dealer/Bean/Bean_ficha.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopUpBody extends StatefulWidget {
  final String tipo;

  const PopUpBody({Key key, this.tipo}) : super(key: key);
  @override
  _PopUpBodyState createState() => _PopUpBodyState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class _PopUpBodyState extends State<PopUpBody> {

  List<String> miUsuario;
  String tipoenvio = "";
  String idempresa = "";
  String estadoFicha = "ASIGNADO";
  String coordOrigen = "";
  String coordDestino = "";

  bool checkSize0 = false;
  bool checkSize1 = false;
  bool checkSize2 = false;
  bool checkSize4 = false;
  bool checkSize5 = false;

  String sizeProduct = "";
  String delicado = "";
  final _keyCrearEnvio = GlobalKey<FormState>();

  final TextEditingController nombre = new TextEditingController();
  final TextEditingController apellido = new TextEditingController();
  final TextEditingController dni = new TextEditingController();
  final TextEditingController celular = new TextEditingController();
  final TextEditingController direccion = new TextEditingController();
  final TextEditingController dist = new TextEditingController();
  String miActualDistrito;
  final TextEditingController producto = new TextEditingController();
  final TextEditingController size = new TextEditingController();
  final TextEditingController estado = new TextEditingController();
  final TextEditingController descripcion = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyCrearEnvio,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20, bottom: 0),
            child: Text(
              "Datos del Cliente:",
              style: TextStyle(
                fontSize: 24,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    controller: nombre,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Nombres",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
                  ),
                  margin: EdgeInsets.all(20),
                ),
              ),
              Expanded(
                child: Container(
                  child: TextFormField(
                    controller: apellido,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Apellidos",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: dni,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "DNI",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: celular,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 9,
                    decoration: InputDecoration(
                      hintText: "Celular",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: TextFormField(
              controller: direccion,
              decoration: InputDecoration(
                hintText: "Direccion",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
            ),
            margin:
                EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20),
          ),
          Container(
            margin:
                EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton(

              hint: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "-- Seleccionar Distrito --",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
              dropdownColor: Colors.white,
              icon: Icon(
                Icons.arrow_drop_down,
                color: kPrimaryColor,
              ),
              iconSize: 36,
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              value: miActualDistrito,
              onChanged: (newValue) {
                setState(() {
                  miActualDistrito = newValue;
                });
              },
              items: [
                for (int i = 0; i < miDistrito.length; i++)
                  DropdownMenuItem(
                    value: "$i",
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "${miDistrito[i]}",
                        textAlign: TextAlign.center,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20, bottom: 0),
            child: Text(
              "Datos del Producto:",
              style: TextStyle(
                fontSize: 24,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: TextFormField(
              controller: producto,
              decoration: InputDecoration(
                hintText: "Producto que se envia",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
            ),
            margin: EdgeInsets.all(20.0),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: descripcion,
              decoration: InputDecoration(
                hintText: "Descripcion del producto",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) { return value.isEmpty?'Campo obligatorio':null; },
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Tamaño:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      CheckboxListTile(
                          value: checkSize0,
                          checkColor: Colors.white,
                          activeColor: kPrimaryColor,
                          title: Text(
                            "Grande",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (bool value) {
                            setState(() {
                              checkSize0 = true;
                              checkSize1 = false;
                              checkSize2 = false;
                              sizeProduct = "grande";
                            });
                          }),
                      CheckboxListTile(
                          value: checkSize1,
                          checkColor: Colors.white,
                          activeColor: kPrimaryColor,
                          title: Text(
                            "Mediano",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (bool value) {
                            setState(() {
                              checkSize0 = false;
                              checkSize1 = true;
                              checkSize2 = false;
                              sizeProduct = "mediano";
                            });
                          }),
                      CheckboxListTile(
                          value: checkSize2,
                          checkColor: Colors.white,
                          activeColor: kPrimaryColor,
                          title: Text(
                            "Pequeño",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (bool value) {
                            setState(() {
                              checkSize0 = false;
                              checkSize1 = false;
                              checkSize2 = true;
                              sizeProduct = "pequeño";
                            });
                          }),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      "Delicado:",
                      style: TextStyle(color: Colors.grey),
                    ),
                    CheckboxListTile(
                        value: checkSize4,
                        checkColor: Colors.white,
                        activeColor: kPrimaryColor,
                        title: Text(
                          "SI",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            checkSize4 = true;
                            checkSize5 = false;
                            delicado = "si";
                          });
                        }),
                    CheckboxListTile(
                        value: checkSize5,
                        checkColor: Colors.white,
                        activeColor: kPrimaryColor,
                        title: Text(
                          "NO",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            checkSize4 = false;
                            checkSize5 = true;
                            delicado = "no";
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
              ),
              onPressed: () {
                if (_keyCrearEnvio.currentState.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Creando Envío!")));

                  crearFicha();
                }
              },
              child: Text('INGRESAR ORIGEN Y DESTINO'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> buildFutures() async {
    return true;
  }

  crearFicha() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    miUsuario = preferences.getStringList('miUsuario');
    idempresa = miUsuario[0];

    tipoenvio = widget.tipo == "EXPRESS"
        ? "1"
        : widget.tipo == "SAME DAY"
            ? "2"
            : "3";

    ficha objeto = new ficha(
      nombre.text,
      apellido.text,
      dni.text,
      celular.text,
      direccion.text,
      miActualDistrito,
      producto.text,
      descripcion.text,
      sizeProduct,
      delicado,
      tipoenvio,
      idempresa,
      estadoFicha,
      coordOrigen,
      coordDestino,
      '',
      '',
    );

    Timer(
        Duration(seconds: 1),
            () => Navigator.of(context)
            .pushReplacementNamed('/mapa', arguments: objeto));

  }
}
