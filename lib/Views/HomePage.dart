import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_foodapp/Utils/themes.dart';
import 'package:my_foodapp/ViewModels/CartViewModel.dart';
import 'package:my_foodapp/ViewModels/MyAccountViewModel.dart';
import 'package:my_foodapp/Views/TrackOrder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String? orderId;
  const HomePage({Key? key, this.orderId}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;

  LatLng? currentLocation;
  LatLng destination = LatLng(28.6280, 77.3649);

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  String distanceText = "";

  final String googleApiKey = "AIzaSyCBPUja4UQfxYYr56ux8BkFqQdXkj0Nc-o";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    currentLocation = LatLng(position.latitude, position.longitude);

    addMarkers();
    getPolyline();
    // calculateDistance();

    setState(() {});
  }

  void addMarkers() {
    markers.clear();

    markers.add(
      Marker(
        markerId: MarkerId("current"),
        position: currentLocation!,
        infoWindow: InfoWindow(title: "My Location"),
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId("destination"),
        position: destination,
        infoWindow: InfoWindow(title: "Delivery Location"),
      ),
    );
  }

  // void calculateDistance() {
  //   double distanceInMeters = Geolocator.distanceBetween(
  //     currentLocation!.latitude,
  //     currentLocation!.longitude,
  //     destination.latitude,
  //     destination.longitude,
  //   );

  //   // double distanceInKm = distanceInMeters / 1000;

  //   // distanceText = "${distanceInKm.toStringAsFixed(2)} KM";
  // }

  Future<void> getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints(apiKey: googleApiKey);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();

      polylines.add(Polyline(polylineId: PolylineId("route"), points: polylineCoordinates, width: 5, color: Colors.blue));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CartViewModel>();
    final vm1 = context.watch<MyAccountViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.more_vert_outlined)],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.white,

        title: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: AppFontWeights.bold),
            children: [
              TextSpan(
                text: 'Track Order:',
                style: TextStyle(fontSize: 18, fontWeight: AppFontWeights.bold, color: AppColors.primaryBlack),
              ),

              TextSpan(
                text: '#120340',
                style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.regular, color: AppColors.darkCharcoal),
              ),
            ],
          ),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,

          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                currentLocation == null
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        width: 600.38,
                        height: 469.48,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(target: currentLocation!, zoom: 14),
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          markers: markers,
                          polylines: polylines,
                          myLocationEnabled: true,
                        ),
                      ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset('assets/images/Avtar.png'),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          vm1.userNameController.text,
                          style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                        ),
                        Text('Delivery guy'),
                      ],
                    ),
                    Spacer(),
                    Image.asset('assets/images/Action Icon.png'),
                    SizedBox(width: 5),
                    Image.asset('assets/images/Action Icon (1).png'),
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: 10),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 5),
                    Text('Estimated Time'),
                    Spacer(),
                    Text(
                      '30mins',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 5),
                    Text('Deliver to'),
                    Spacer(),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 15, fontWeight: AppFontWeights.regular, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 353,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      if (context.mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder(orderId: widget.orderId!)));
                      }
                    },
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))),
                    child: Text(
                      'More Details',
                      style: TextStyle(fontSize: AppFontSize.medium, fontWeight: AppFontWeights.medium, color: Color.fromRGBO(54, 58, 51, 1)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
