import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final String lat;
  final String long;

  const Maps({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
// created controller for displaying Google Maps
  final Completer<GoogleMapController> _controller = Completer();

// given camera position

  Uint8List? marketimages;

// created empty list of markers
  final List<Marker> _markers = <Marker>[];

// declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    // initialize loadData method
    loadData();
  }

// created method for displaying custom markers according to index
  loadData() async {
    _markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(double.parse((widget.lat)), double.parse(widget.long)),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // given camera position
      initialCameraPosition: CameraPosition(
        target: LatLng(double.parse(widget.lat), double.parse(widget.long)),
        zoom: 15,
      ),
      // set markers on google map
      markers: Set<Marker>.of(_markers),
      // on below line we have given map type
      mapType: MapType.normal,
      // on below line we have enabled location
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      // on below line we have enabled compass
      compassEnabled: false,
      // below line displays google map in our app
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
