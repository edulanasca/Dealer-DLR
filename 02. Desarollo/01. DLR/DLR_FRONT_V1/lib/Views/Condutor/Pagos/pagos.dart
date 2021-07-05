import 'package:dealer/Views/Condutor/Pagos/Components/boleta.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Pagos extends StatefulWidget {
  final DateTime initialDate;

  const Pagos({Key key, this.initialDate}) : super(key: key);
  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  DateTime selectedDate;
  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget btnFecha= Container(
      margin: EdgeInsets.only(top: 20, left: 50, right: 50),
      // ignore: deprecated_member_use
      child: GestureDetector(
        child: Container(
          padding:
          EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
                size: 24.0,
              ),
              Expanded(
                child: Text(
                  'AÑO: ${selectedDate?.year}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'MES: ${selectedDate?.month}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
                size: 24.0,
              ),
            ],
          ),
        ),
        onTap: () {
          showMonthPicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 1, 5),
            lastDate: DateTime(DateTime.now().year + 1, 9),
            initialDate: selectedDate ?? widget.initialDate,
            locale: Locale("es"),
          ).then((date) {
            if (date != null) {
              setState(() {
                selectedDate = date;
              });
            }
          });
        },
      ),
    );
    Widget boleta = Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0),
      padding:
      EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0, right: 50.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2.0),
        color: Colors.white,
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
            Center(child: Text("BOLETA DE PAGOS - ${selectedDate?.month==1?'ENERO':selectedDate?.month==2?'FEBRERO':selectedDate?.month==3?'MARZO':selectedDate?.month==4?'ABRIL':selectedDate?.month==5?'MAYO':selectedDate?.month==6?'JUNIO':selectedDate?.month==7?'JULIO':selectedDate?.month==8?'AGOSTO':selectedDate?.month==9?'SETIEMBRE':selectedDate?.month==10?'OCTUBRE':selectedDate?.month==11?'NOVIEMBRE':"DICIEMBRE"}")),
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
    return ListView(
      children: [
        btnFecha,
        boleta
      ],
    );
  }
}
