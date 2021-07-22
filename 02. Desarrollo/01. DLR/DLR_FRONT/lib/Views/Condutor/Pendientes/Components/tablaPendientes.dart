import 'package:dealer/Views/Condutor/Pendientes/Components/Pendientes/popup.dart';
import 'package:dealer/Views/Condutor/Pendientes/Components/Pendientes/popup_body.dart';
import 'package:dealer/Views/Condutor/Pendientes/Components/Pendientes/popup_content.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class DataTablePendientes extends StatefulWidget {
  final List<Map<String, String>> filas;
  const DataTablePendientes({Key key, this.filas}) : super(key: key);
  @override
  _DataTablePendientesState createState() => _DataTablePendientesState();
}

class _DataTablePendientesState extends State<DataTablePendientes> {
  Widget renderPendientes() {
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
                leading: Image.asset(
                  item["tipo"] == "EXPRESS"
                      ? "assets/icons/icon_moto.png"
                      : item["tipo"] == "FLEXIBLE"
                          ? "assets/icons/icon_tipo2.png"
                          : "assets/icons/icon_tipo3.png",
                  width: 60.0,
                ),
                title: Text(
                  item["empresa"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item["origen"]),
                      Icon(Icons.arrow_forward_sharp, size: 15),
                      Text(item["destino"]),
                    ],
                  ),
                ),
                trailing: Text("1h 6m"),
                dense: true,
                onTap: () {
                  showPopup(context, PopUpBody(element: item), item);
                },
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderPendientes();
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
                  Text(fila["origen"]),
                  Expanded(
                      child: Center(
                          child: Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white,
                  ))),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        fila["destino"],
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
