import 'dart:ui';

import 'package:dealer/constats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpBody extends StatefulWidget {
  final Map<String, String> element;
  const PopUpBody({Key key, this.element}) : super(key: key);
  @override
  _PopUpBodyState createState() => _PopUpBodyState();
}

class _PopUpBodyState extends State<PopUpBody> {
  //se supone que element tendra un id de envio aqui consultamos el id y recuperamos todos los datos.

  @override
  Widget build(BuildContext context) {
    Widget _popupBody = Container(
      color: Colors.white,
      child: ListView(
        children: [
          InteractiveViewer(child: Image.asset("assets/images/cliente.jpg",)),
          Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("DATOS DEL ENVÍO",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 15),
                Etiqueta(
                  texto: "Tienda: ",
                ),
                SizedBox(height: 5),
                Detalle(texto: "SODIMAC S.A."),
                SizedBox(height: 15),
                Etiqueta(texto: "Dirección de la Tienda: "),
                SizedBox(height: 5),
                Detalle(
                    texto:
                        "Jiron Cajamarquilla con, San Juan de Lurigancho 15427"),
                SizedBox(height: 15),
                Etiqueta(texto: "Cliente: "),
                SizedBox(height: 5),
                Detalle(texto: "Tito Jesús Yánac Saldaña"),
                SizedBox(height: 15),
                Etiqueta(texto: "Dirección del Cliente: "),
                SizedBox(height: 5),
                Detalle(texto: "av.malecón checa N°621"),
                SizedBox(height: 15),
                SizedBox(height: 15),
                Etiqueta(texto: "Items del Envio: "),
                SizedBox(height: 15),
                Detalle(texto: "Producto 1"),
                SizedBox(height: 25),
                Row(children: [
                  Text("Pago: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text("S/. 34.60", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24))
                ]),
                SizedBox(height: 15),
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
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: kSecondaryColor,
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(2, 1), // changes position of shadow
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
