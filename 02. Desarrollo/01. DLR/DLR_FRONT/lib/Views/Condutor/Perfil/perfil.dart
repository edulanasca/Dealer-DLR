import 'dart:async';

import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: '$index' == '0'
          ? "Datos Personales"
          : '$index' == '1'
              ? "Conductor"
              : "Vehiculo",
      expandedValue: '$index' == '0'
          ? "personal"
          : '$index' == '1'
              ? "conductor"
              : "vehiculo",
    );
  });
}

/// This is the stateful widget that the main application instantiates.
class Perfil extends StatefulWidget {
  const Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PerfilState extends State<Perfil> {
  final List<Item> _data = generateItems(3);
  final _key_ActualizarDatosPersonales = GlobalKey<FormState>();
  final _key_ActualizarDatosConductor = GlobalKey<FormState>();
  final _key_ActualizarDatosVehiculo = GlobalKey<FormState>();
  TextEditingController nombre_conductor;
  TextEditingController apellido_conductor;
  TextEditingController edad_conductor;
  TextEditingController dni_conductor;
  TextEditingController correo_conductor;
  TextEditingController pass1_conductor;
  TextEditingController pass2_conductor;


  @override
  void initState() {
    // TODO: implement initState
      nombre_conductor = new TextEditingController();
      apellido_conductor = new TextEditingController();
      edad_conductor = new TextEditingController();
      dni_conductor = new TextEditingController();
      correo_conductor = new TextEditingController();
      pass1_conductor = new TextEditingController();
      pass2_conductor = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        var panel_personal = ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Form(
            key: _key_ActualizarDatosPersonales,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: nombre_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "NOMBRE: Tito Jesús",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: apellido_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "APELLIDO: Yánac Saldaña",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: dni_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "DNI: 67448594",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: edad_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "EDAD: 27",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: correo_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "CORREO: titoyanac@gmail.com",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: pass1_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "CONTRASEÑA: *********",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Guardando datos personales.'),
                      ));
                    },
                    child: Text('GUARDAR DATOS PERSONALES'),
                  ),
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
        var panel_conductor = ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Form(
            key: _key_ActualizarDatosConductor,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: nombre_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Número de Licencia: 68SF67S89",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                      controller: apellido_conductor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Fecha expiración Licencia: 31/12/2021",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {}),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: dni_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Número de Póliza: 648ASW1A68W",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: edad_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Fecha Expiración SOAT: 31/12/2021",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: correo_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Código CITV: 0",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: kPrimaryColor))),
                  child: TextFormField(
                    controller: pass1_conductor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nivel: 2 A",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {},
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor),
                    ),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Guardando datos de conductor.'),
                      ));
                    },
                    child: Text('GUARDAR DATOS DE CONDUCTOR'),
                  ),
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
        var panel_vehiculo = ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Column(
            children: [
              itemForm(label: "TUC", value: "SGW968S", id: "125254"),
              itemForm(
                  label: "Número de Placa:", value: "6A8FSQ", id: "125254"),
              itemForm(
                  label: "Número de Serie:", value: "64564897", id: "125254"),
              itemForm(label: "Número de VIN:", value: "654DW65", id: "125254"),
              itemForm(
                  label: "Número de Motor:", value: "56CSDW", id: "125254"),
              itemForm(label: "Color:", value: "Gris", id: "125254"),
              itemForm(
                  label: "Placa Vigente ( SI | NO ):",
                  value: "SI",
                  id: "125254"),
              itemForm(label: "Placa Anterior:", value: "---", id: "125254"),
              itemForm(label: "Marca:", value: "VOLVO", id: "125254"),
              itemForm(
                  label: "Anotaciones:", value: "Auto nuevo", id: "125254"),
            ],
          ),
          isExpanded: item.isExpanded,
        );
        return item.expandedValue == 'personal'
            ? panel_personal
            : item.expandedValue == 'conductor'
                ? panel_conductor
                : panel_vehiculo;
      }).toList(),
    );
  }
}

class itemForm extends StatefulWidget {
  final String label;
  final String value;
  final String id;
  const itemForm({
    Key key,
    this.label,
    this.value,
    this.id,
  }) : super(key: key);
  @override
  _itemFormState createState() => _itemFormState();
}

class _itemFormState extends State<itemForm> {
  TextEditingController controlador = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.label),
        subtitle: TextField(
          controller: controlador,
          obscureText: true,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.value,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        trailing: Icon(Icons.save_sharp),
        onTap: () {
          setState(() {
            print(widget.id);
            //_data.removeWhere((Item currentItem) => item == currentItem);
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Se ha editado correctamente!')));
        });
  }
}
