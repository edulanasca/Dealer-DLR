import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    Widget _popupBody = Container(
      color: Colors.white,
      child: ListView(
        children: [
          InteractiveViewer(child: Image.asset("assets/images/mapa_default.png",),),
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
                Detalle(texto: widget.element["empresa"]),
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
                Etiqueta(texto: "Telefono de contacto del cliente: "),
                SizedBox(height: 15),
                Detalle(texto: "970576076"),
                SizedBox(height: 15),
                Etiqueta(texto: "N° Boleta / Factura: "),
                SizedBox(height: 15),
                Detalle(texto: "0041604166-64"),
                SizedBox(height: 15),
                Etiqueta(texto: "Items del Envio: "),
                SizedBox(height: 15),
                Detalle(texto: "Producto 1"),
                SizedBox(height: 35),
                Container(
                    child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/principal_conductor', arguments: '1');
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/principal_conductor', arguments: '1');
                        },
                        child: Text(
                          "MARCAR COMO ENTREGADO",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
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
        child: Text("${widget.texto}"),
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
