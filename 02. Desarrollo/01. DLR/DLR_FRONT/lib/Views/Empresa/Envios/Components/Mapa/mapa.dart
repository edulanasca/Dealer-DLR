import 'dart:convert';

import 'package:dealer/Bean/Bean_ficha.dart';
import 'package:dealer/constats.dart';
import 'package:flutter/material.dart';
import 'directions_model.dart';
import 'directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final ficha data;
  const MapScreen({Key key, this.data}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-12.027946124592871, -77.00272361466143),
    zoom: 16,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        title: const Text('Google Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
              child: Container(
                child: const Text(
                  'Origen',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.all(8),
              ),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
              child: Container(
                child: const Text(
                  'Destino',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.all(8),
              ),
            ),
          if (_origin != null && _destination != null)
            TextButton(
              onPressed: () => guardarFicha(),
              style: TextButton.styleFrom(
                primary: Colors.red,
                textStyle: const TextStyle(fontWeight: FontWeight.w800),
              ),
              child: Container(
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.all(8),
              ),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 10.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  guardarFicha() async{
      widget.data.coord_origen = "${_origin.position.latitude} , ${_origin.position.longitude}";
      widget.data.coord_destino= "${_destination.position.latitude} , ${_destination.position.longitude}";
      int costo = 15;

      var dist = _info.totalDistance.split(" ");

      var url =
      Uri.parse('https://dealertesting.000webhostapp.com/App_modulos_empresa/App_registrar_envio.php');
      var response =
      await http.post(url, body: {
        'nombre' : widget.data.nombre,
        'apellido' : widget.data.apellido,
        'documento' : widget.data.documento,
        'celular' : widget.data.celular,

        'direccion' : widget.data.direccion,
        'distrito' : widget.data.distrito,

        'producto' : widget.data.producto,
        'descripcion' : widget.data.descripcion,
        'SizeProduct' : widget.data.SizeProduct,
        'delicado' : widget.data.delicado,

        'tipoenvio' : widget.data.tipoenvio,
        'idempresa' : widget.data.idempresa,
        'estado' : widget.data.estado,

        'kilometros':  '${dist[0]}',
        'coord_origen' : widget.data.coord_origen,
        'coord_destino' : widget.data.coord_destino,
        'costo': '$costo',
      });
      var data = response.body!='error'?json.decode(response.body):{'0' : "-1"};
      print(data);
      switch ("${data['0']}") {
        case "0":
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "No se pudo registrar"),
            ),
          );
          break;
        case "1":
          Navigator.of(context).pushNamed('/principal_empresa', arguments: '1');
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 10),
              content:
              Text("Ocurrió algo inesperado\n Motivo: Error del Servidor"),
            ),
          );
          break;
      }

  }
}
