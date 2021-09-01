import 'package:dealer/Views/Empresa/Pendientes/Components/Pendientes/popup.dart';
import 'package:dealer/Views/Empresa/Pendientes/Components/Pendientes/popup_content.dart';
import 'package:dealer/Views/Empresa/Pendientes/Components/Pendientes/popup_body.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class DataTableRealizados extends StatefulWidget {
  final List<Map<String, String>> filas;
  const DataTableRealizados({Key key, this.filas}) : super(key: key);
  @override
  _DataTableRealizadosState createState() => _DataTableRealizadosState();
}

class _DataTableRealizadosState extends State<DataTableRealizados> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.filas
          .map(
            (item) => Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            leading: item['TIPO']=="EXPRESS"?Image.asset("assets/icons/icon_moto.png"):item['TIPO']=="SAME DAY"?Image.asset("assets/icons/icon_tipo2.png"):Image.asset("assets/icons/icon_tipo3.png"),
            title: Text("${item['CLIENTE_NOMBRE']} ${item['CLIENTE_APELLIDO']}"),
            subtitle: Text("${miDistrito[int.parse(item['ORIGEN_ID_DISTRITO'])]} → ${miDistrito[int.parse(item['DESTINO_ID_DISTRITO'])]}"),
            trailing: Text("1h 6m"),
            dense: true,
            onTap: (){
              showPopup(context, PopUpBody(element: item), item);
            },
          ),
        ),
      )
          .toList(),
    );

  }
  showPopup(BuildContext context, Widget widget, Map<String, String> fila,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Row(
                children: [
                  Text("${miDistrito[int.parse(fila['ORIGEN_ID_DISTRITO'])]}"),
                  Expanded(
                      child: Center(
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: Colors.white,
                          ))),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "${miDistrito[int.parse(fila['DESTINO_ID_DISTRITO'])]}",
                        textAlign: TextAlign.right,
                      )),
                ],
              ),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            // resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }
}
