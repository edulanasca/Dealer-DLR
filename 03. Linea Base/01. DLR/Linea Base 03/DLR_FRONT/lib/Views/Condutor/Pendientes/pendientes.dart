import 'package:dealer/Views/Condutor/Pendientes/Components/tablaPendientes.dart';
import 'package:dealer/Views/Condutor/Pendientes/Components/tablaRealizados.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Pendientes extends StatefulWidget {
  @override
  _PendientesState createState() => _PendientesState();
}

class _PendientesState extends State<Pendientes> {

  List<Map<String, String>> pendientes = [
    {
      "origen": "LA MOLINA",
      "destino": "S.J.L.",
      "tipo": "EXPRESS",
      "empresa": "SODIMAC",
      "t_restamte": "01:41",
    },
  ];
  List<Map<String, String>> realizados = [
    {
      "origen": "C. DE LIMA",
      "f_entrega": "21/03/2021 18:42",
      "destino": "S.J.L.",
      "tipo": "NEXT DAY",
      "empresa": "SODIMAC S.A."
    },
    {
      "origen": "C. DE LIMA",
      "f_entrega": "21/03/2021 18:42",
      "destino": "S.J.L.",
      "tipo": "EXPRESS",
      "empresa": "SODIMAC S.A."
    },
    {
      "origen": "C. DE LIMA",
      "f_entrega": "21/03/2021 18:42",
      "destino": "S.J.L.",
      "tipo": "FLEXIBLE",
      "empresa": "SODIMAC S.A."
    },
    {
      "origen": "C. DE LIMA",
      "f_entrega": "21/03/2021 18:42",
      "destino": "S.J.L.",
      "tipo": "EXPRESS",
      "empresa": "SODIMAC S.A."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ConseguirDatos(),
        builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        return Text("${snapshot.data}");
      }else{
        return CircularProgressIndicator();
      }
    });
  }

  ConseguirDatos() async {
    var url = Uri.parse('https://dealertesting.000webhostapp.com/conductor/Mostrar_EnviosPendientes.php');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = http.post(url, body: { 'idConductor': preferences.getStringList('miUsuario') });
    print(response);
    return response;
  }
}
/*
*
* ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 25,
            left: 15.0,
            right: 15.0,
            bottom: 0.0,
          ),
          child: Text(
            "ENVÍOS PENDIENTES",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          child: DataTablePendientes(filas: pendientes),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 25,
            left: 15.0,
            right: 15.0,
            bottom: 0.0,
          ),
          child: Text(
            "ENVÍOS REALIZADOS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15.0),
          child: DataTableRealizados(filas: realizados),
        ),
      ],
    )
* */

