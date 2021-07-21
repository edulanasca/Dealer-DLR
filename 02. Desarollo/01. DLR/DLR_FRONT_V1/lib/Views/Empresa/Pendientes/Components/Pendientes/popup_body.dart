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
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            width: double.infinity,
            height: 200.0,
            child: Center(
              child: widget.element['ESTADO']=="ASIGNADO"?Image.asset("assets/images/mapa_default.png"):Text("-- Aun no se ha tomado el envio --"),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
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
                Detalle(texto: "${widget.element['EMPRESA']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Dirección de la Tienda: "),
                SizedBox(height: 5),
                Detalle(
                    texto:
                    "${widget.element['DIR_ORIGEN']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Cliente: "),
                SizedBox(height: 5),
                Detalle(texto: "${widget.element['CLIENTE_NOMBRE']} ${widget.element['CLIENTE_APELLIDO']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Dirección del Cliente: "),
                SizedBox(height: 5),
                Detalle(texto: "${widget.element['DIR_DESTINO']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Telefono de contacto del cliente: "),
                SizedBox(height: 15),
                Detalle(texto: "${widget.element['CLIENTE_CELULAR']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Items del Envio: "),
                SizedBox(height: 15),
                Detalle(texto: "${widget.element['PRODUCTO']}"),
                SizedBox(height: 15),
                Etiqueta(texto: "Distancia del viaje: "),
                SizedBox(height: 15),
                Detalle(texto: "${widget.element['KM']} KM"),
                SizedBox(height: 15),
                Etiqueta(texto: "Costo del Envío: "),
                SizedBox(height: 15),
                Detalle(texto: "S/. ${widget.element['MONTO']}"),
                SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
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
