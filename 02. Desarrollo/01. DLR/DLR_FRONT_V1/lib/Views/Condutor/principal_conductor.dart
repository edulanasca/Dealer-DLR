import 'package:dealer/Views/Condutor/Envios/envios_disponibles.dart';
import 'package:dealer/Views/Condutor/Pagos/pagos.dart';
import 'package:dealer/Views/Condutor/Pendientes/pendientes.dart';
import 'package:dealer/Views/Condutor/Perfil/perfil.dart';
import 'package:flutter/material.dart';
import 'package:dealer/constats.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalConductor extends StatefulWidget {
  final String data;
  const PrincipalConductor({Key key, this.data}) : super(key: key);
  @override
  _PrincipalConductorState createState() => _PrincipalConductorState();
}

class _PrincipalConductorState extends State<PrincipalConductor> {
  int _currentindex;
  @override
  void initState() {
    _currentindex = widget.data == '0'
        ? 0
        : widget.data == '1'
            ? 1
            : widget.data == '2'
                ? 2
                : 3;
    super.initState();
  }

  final views = [
    EnviosDisponibles(),
    Pendientes(),
    Pagos(initialDate: DateTime.now()),
    Perfil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        leading: Builder(
          builder: (context) => IconButton(
            padding: EdgeInsets.only(left: 10, top: 10),
            icon: Image.asset(
              "assets/icons/icon_menu.png",
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Image.asset(
            "assets/images/logo_blanco.png",
            height: 120,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10, top: 10),
            icon: Image.asset(
              "assets/icons/icon_close.png",
            ),
            onPressed: () {
              clearPreferences();
              Navigator.of(context).pushNamed('/login');
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
              Container(
                height: 300,
                margin: EdgeInsets.only(top: 50,bottom: 50,left: 30,right: 30),
                child: Center(
                  child: Icon(Icons.person,color: kPrimaryColor,size: 100,),
                ),
                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor,width: 2.0)
                ),
              ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text("Preguntas Frecuentes"),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text("Contáctanos"),
              ),
              onTap: () {
                Navigator.pop(context);
              },

            ),
            Spacer(),
            Container(
              child: Center(
                child: Text("Redes Sociales",style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(FontAwesomeIcons.whatsapp),
                  FaIcon(FontAwesomeIcons.facebook),
                  FaIcon(FontAwesomeIcons.instagram),
                ],
              ),
            )
          ],
        ),
      ),
      body: views[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/icon_menu1.png",
              height: _currentindex == 0 ? 60.0 : 40.0,
            ),
            label: "Envios",
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/icon_menu2.png",
              height: _currentindex == 1 ? 60.0 : 40.0,
            ),
            label: "Pendientes",
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/icon_menu3.png",
              height: _currentindex == 2 ? 60.0 : 40.0,
            ),
            label: "Pagos",
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/icon_menu4.png",
              height: _currentindex == 3 ? 60.0 : 40.0,
            ),
            label: "Perfil",
            backgroundColor: kPrimaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }

  Future<void> clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
