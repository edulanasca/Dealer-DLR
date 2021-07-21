import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class Boleta extends StatefulWidget {
  final DateTime initialDate;

  const Boleta({Key key, this.initialDate}) : super(key: key);
  @override
  _BoletaState createState() => _BoletaState();
}

class _BoletaState extends State<Boleta> {
  DateTime selectedDate;

  final List<Map<String, String>> boletas = [
    {
      "id": "649638215",
      "month": "4",
      "year": "2021",
      "tipo": "BOLETA",
      "n_operacion": "07832",
      "importe": "1260.50",
      "km_recorridos": "149.3",
      "bonificacion": "120.00",
      "viajes_realizados": "42",
      "entregas_tardias": "2",
      "entregas_justificadas": "2",
      "descuento": "0.00"
    }
  ];

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 0.0, bottom: 20.0, right: 60.0),
      padding:
          EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0, right: 50.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2.0),
        color: Colors.green,
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child:
                Center(child: Text("FACTURA DEL MES DE - ${selectedDate?.month}")),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Numero de Operación:"), Text("0783")]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Importe a Pagar:"),
                  new Text("S./1,260.00")
                ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text("Kilómetros Recorridos"),
                  new Text("149.3 KM")
                ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new Text("Bonificación"), new Text("S/. 120.00")]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new Text("Viajes Realizados"), new Text("42")]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new Text("Entregas Tardías"), new Text("2")]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new Text("Entregas justificadas"), new Text("2")]),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new Text("Descuento"), new Text("S/. 0.00")]),
          ),
        ],
      ),
    );
  }
}
