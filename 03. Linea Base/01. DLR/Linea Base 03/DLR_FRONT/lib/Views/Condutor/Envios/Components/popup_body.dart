import 'dart:ui';


import 'package:dealer/Bean/Bean_envios.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpBody extends StatefulWidget {
  final Map<String, dynamic> element;
  const PopUpBody({Key key, this.element}) : super(key: key);
  @override
  _PopUpBodyState createState() => _PopUpBodyState();
}

class _PopUpBodyState extends State<PopUpBody> {
  @override
  Widget build(BuildContext context) {
    print(widget.element);

    Widget _popupBody = Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Etiqueta(
                  texto: "EMPRESA: ",
                ),
                SizedBox(height: 5),
                Detalle(texto: widget.element['EMPRESA']),
                SizedBox(height: 15),
                Etiqueta(texto: "Dirección para RECOGER el envío: "),
                SizedBox(height: 5),
                Detalle(
                    texto:
                    widget.element['DIR_ORIGEN']),

                SizedBox(height: 15),
                Etiqueta(texto: "Dirección para ENTREGAR el envío: "),
                SizedBox(height: 5),
                Detalle(texto: widget.element['DIR_DESTINO']),
                SizedBox(height: 15),
                Etiqueta(texto: "Cliente: "),
                SizedBox(height: 5),
                Detalle(texto: "${widget.element['CLIENTE_NOMBRE']} ${widget.element['CLIENTE_APELLIDO']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Producto que se envía: "),
                SizedBox(height: 15),
                Detalle(texto: widget.element['PRODUCTO']),
                SizedBox(height: 25),
                Row(children: [
                  Text("Pago: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text("S/. ${widget.element['MONTO']}", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24))
                ]),
                SizedBox(height: 15),
                Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor, // background
                        onPrimary: Colors.white, // foreground
                      ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/principal_conductor', arguments: '1');
                  },
                  child: Text("ACEPTAR ENVÍO",style: TextStyle(color: Colors.white),),
                )),
              ],
            ),
          ),
        ],
      ),
    );

    return _popupBody;



  }
}

class Detalle extends StatefulWidget {
  final String texto;
  const Detalle({Key key, this.texto}) : super(key: key);
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        child: Text(widget.texto),
        padding: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2.0, color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: kSecondaryColor,
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
        ),
      )
    ]);
  }
}

class Etiqueta extends StatefulWidget {
  final String texto;
  const Etiqueta({Key key, this.texto}) : super(key: key);
  @override
  _EtiquetaState createState() => _EtiquetaState();
}

class _EtiquetaState extends State<Etiqueta> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child:
            Text(widget.texto, style: TextStyle(fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
