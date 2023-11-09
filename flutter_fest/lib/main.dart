import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ARMapScreen(),
    );
  }
}

class ARMapScreen extends StatefulWidget {
  @override
  _ARMapScreenState createState() => _ARMapScreenState();
}

class _ARMapScreenState extends State<ARMapScreen> {
  ArCoreController? arCoreController;
  GoogleMapController? googleMapController;
  Location location = Location();
  LatLng userLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  _getUserLocation() async {
    var currentLocation = await location.getLocation();
    setState(() {
      userLocation =
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });
  }

  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
  }

  _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // Harita üzerinde kullanıcının konumunu göstermek için bir işaretçi ekleyebilirsiniz.
    // googleMapController.addMarker(MarkerOptions(position: userLocation, infoWindowText: InfoWindowText('Kullanıcının Konumu', '')));
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR + Harita Örneği'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: userLocation,
              zoom: 15,
            ),
            markers: {
              // Kullanıcının konumu için bir marker ekleyebilirsiniz.
              Marker(
                  markerId: MarkerId('userLocation'), position: userLocation),
            },
          ),
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
            type: ArCoreViewType.AUGMENTEDIMAGES,
          ),
        ],
      ),
    );
  }
}
