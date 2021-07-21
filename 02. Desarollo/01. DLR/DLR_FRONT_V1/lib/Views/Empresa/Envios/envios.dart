import 'package:dealer/Views/Empresa/Envios/Components/popup.dart';
import 'package:dealer/Views/Empresa/Envios/Components/popup_body.dart';
import 'package:dealer/Views/Empresa/Envios/Components/popup_content.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';

class Envios extends StatefulWidget {
  @override
  _EnviosState createState() => _EnviosState();
}

class _EnviosState extends State<Envios> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Text("Seleccionar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              Text("Tipo de Servicio",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1.0,color: kSecondaryColor,),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            leading: Image.asset("assets/icons/icon_moto.png", width: 60.0,),
            title: Text("Express",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Column(
              children: [
                Text("Recogemos tus paquetes y los enviamos a todo Lima y Callao el mismo día."),
                Text("Tiempo de Servicio: 3 horas",)
              ],
            ),
            dense: true,
            onTap: (){
              showPopup(context, PopUpBody(tipo:"Express"),"CREA UN ENVIO EXPRESS");
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1.0,color: kSecondaryColor,),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            leading: Image.asset("assets/icons/icon_tipo2.png", width: 60.0,),
            title: Text("SAME DAY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Column(
              children: [
                Text("Recogemos tus paquetes y los enviamos a todo Lima y Provincias."),
                Text("Tiempo de Servicio: 42 horas",)
              ],
            ),
            dense: true,
            onTap: (){
              showPopup(context, PopUpBody(tipo:"SAME DAY"),"CREA UN ENVIO SAME DAY");
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1.0,color: kSecondaryColor,),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            leading: Image.asset("assets/icons/icon_tipo3.png", width: 60.0,),
            title: Text("Next Day",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Column(
              children: [
                Text("Recogemos tus paquetes en la puerta de tu casa y los entregamos en un punto."),
                Text("Tiempo de Servicio: 24 horas",)
              ],
            ),
            dense: true,
            onTap: (){
              showPopup(context, PopUpBody(tipo:"Next Day"),"CREA UN ENVIO NEXT DAY");

            },
          ),
        ),
      ],
    );
  }


showPopup(BuildContext context, Widget widget, String tipo,
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
            title: Text(tipo,textAlign: TextAlign.end,style: TextStyle(color: Colors.white),),
            leading: new Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.close,color: Colors.white,),
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
