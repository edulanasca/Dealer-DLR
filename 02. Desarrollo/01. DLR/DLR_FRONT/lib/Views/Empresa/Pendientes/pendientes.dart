import 'package:dealer/Views/Empresa/Pendientes/Components/tablaPendientes.dart';
import 'package:dealer/Views/Empresa/Pendientes/Components/tablaRealizados.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Pendientes extends StatefulWidget {
  @override
  _PendientesState createState() => _PendientesState();
}

class _PendientesState extends State<Pendientes> {
  List<Map<String, String>> pendientes = [];
  List<Map<String, String>> realizados = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
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
        FutureBuilder(
            future: conseguirDatosPendientes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  margin: EdgeInsets.all(15.0),
                  child: DataTablePendientes(filas: pendientes),
                );
              } else {
                return Center(child: Container(width:50,height: 50,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),)));
              }
            }),
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
        FutureBuilder(
            future: conseguirDatosRealizados(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  margin: EdgeInsets.all(15.0),
                  child: DataTableRealizados(filas: realizados),
                );
              } else {
                return Center(child: Container(width:50,height: 50,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),)));
              }
            }),
      ],
    );
  }

  Future conseguirDatosPendientes() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> empresa = preferences.getStringList('miUsuario');

    var url = Uri.parse(
        'https://dealertesting.000webhostapp.com/App_modulos_empresa/App_mostrar_envios_asignados.php');
    var response = await http.post(url, body: {'id_Empresa': empresa[0]});

    List<dynamic> milista = json.decode(response.body);

    pendientes = [];

    for (var item in milista) {
      Map<String, String> aux = new Map<String, String>();
      aux = {
        'ID_FICHA': "${item['ID_FICHA']}",
        'ID_EMPRESA': "${item['ID_EMPRESA']}",
        'FECHA_CREACION': "${item['FECHA_CREACION']}",
        'ESTADO': "${item['ESTADO']}",
        'MONTO': "${item['MONTO']}",
        'COORD_ORIGEN': "${item['COORD_ORIGEN']}",
        'COORD_DESTINO': "${item['COORD_DESTINO']}",
        'KM': "${item['KM']}",
        'EMPRESA': "${item['EMPRESA']}",
        'DIR_ORIGEN': "${item['DIR_ORIGEN']}",
        'ORIGEN_ID_DISTRITO': "${item['ORIGEN_ID_DISTRITO']}",
        'DIR_DESTINO': "${item['DIR_DESTINO']}",
        'DESTINO_ID_DISTRITO': "${item['DESTINO_ID_DISTRITO']}",
        'TIPO': "${item['TIPO']}",
        'PRODUCTO': "${item['PRODUCTO']}",
        'CLIENTE_NOMBRE': "${item['CLIENTE_NOMBRE']}",
        'CLIENTE_APELLIDO': "${item['CLIENTE_APELLIDO']}",
        'CLIENTE_CELULAR': "${item['CLIENTE_CELULAR']}"
      };
      pendientes.add(aux);
    }
    return pendientes;
  }
  Future conseguirDatosRealizados() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> empresa = preferences.getStringList('miUsuario');

    var url = Uri.parse(
        'https://dealertesting.000webhostapp.com/App_modulos_empresa/App_mostrar_envios_realizados.php');
    var response = await http.post(url, body: {'id_Empresa': empresa[0]});

    List<dynamic> milista = json.decode(response.body);

    realizados = [];

    for (var item in milista) {
      Map<String, String> aux = new Map<String, String>();
      aux = {
        'ID_FICHA': "${item['ID_FICHA']}",
        'ID_EMPRESA': "${item['ID_EMPRESA']}",
        'FECHA_CREACION': "${item['FECHA_CREACION']}",
        'ESTADO': "${item['ESTADO']}",
        'MONTO': "${item['MONTO']}",
        'COORD_ORIGEN': "${item['COORD_ORIGEN']}",
        'COORD_DESTINO': "${item['COORD_DESTINO']}",
        'KM': "${item['KM']}",
        'EMPRESA': "${item['EMPRESA']}",
        'DIR_ORIGEN': "${item['DIR_ORIGEN']}",
        'ORIGEN_ID_DISTRITO': "${item['ORIGEN_ID_DISTRITO']}",
        'DIR_DESTINO': "${item['DIR_DESTINO']}",
        'DESTINO_ID_DISTRITO': "${item['DESTINO_ID_DISTRITO']}",
        'TIPO': "${item['TIPO']}",
        'PRODUCTO': "${item['PRODUCTO']}",
        'CLIENTE_NOMBRE': "${item['CLIENTE_NOMBRE']}",
        'CLIENTE_APELLIDO': "${item['CLIENTE_APELLIDO']}",
        'CLIENTE_CELULAR': "${item['CLIENTE_CELULAR']}"
      };
      realizados.add(aux);
    }
    return realizados;

  }

}
