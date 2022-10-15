import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  void saveMyCoordinates() async {
    setState(() {
      UpdateMyCoordinates();
    });
    if(nextScreenLatitude != 0 && nextScreenLongitude != 0){
      print("Lat: ${nextScreenLatitude} and Long: ${nextScreenLongitude}");

    }
  }
  void UpdateMyCoordinates()async{
    Location locator = Location();
    var locatorData = await locator.getLocation();
    setState(() {
      nextScreenLatitude =  locatorData.latitude! ;
      nextScreenLongitude = locatorData.longitude! ;
    });

  }
  double intialLatitude = 20.5937;
  double intitalLongitude = 78.9629;
  double nextScreenLatitude = 0 ;
  double nextScreenLongitude = 0 ;
  late GoogleMapController mapController ;
  late Marker marker= Marker(markerId: MarkerId("initial"));
  Location _locationT = Location();
  late  StreamSubscription _locationSubscription ;
  void updateMarker(LocationData locationData )async {
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
    setState(() {
      marker = Marker(
          markerId: MarkerId("Marker",),
          position:  latLng,
          zIndex: 2,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          rotation: locationData.heading!


      );

    });
  }
  /*Future<Uint8List> getImageData()async{
    ByteData unit = await DefaultAssetBundle.of(context).load("Images/img.png");
    return unit.buffer.asUint8List();

}*/

  void update()async{
    var locationData = await _locationT.getLocation();
    // var imagedata = await getImageData();

    updateMarker(locationData);

    if(mapController!= null) {
      mapController.animateCamera(
          CameraUpdate.newCameraPosition(new CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 17.44,

          )));
    }
    UpdateMyCoordinates();



    updateMarker(locationData);




  }


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              update();
            },
            child: Icon(Icons.location_searching_rounded),
          ),
          body: Container(

            child: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: (controller){
                    mapController = controller ;
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(intialLatitude,intitalLongitude),
                      zoom: 5.23




                  ),
                  markers: Set.of( marker != null ? [marker] : []),

                ),
                Positioned(
                    left: 300,
                    child: Container(
                        decoration: BoxDecoration(

                        ),
                        child: IconButton(
                            icon: Icon(Icons.done_outline,color: Colors.green,),
                            iconSize: 40,
                            splashRadius: 5,
                            splashColor: Colors.black,
                            onPressed: () {
                              if (nextScreenLongitude != 0 &&
                                  nextScreenLatitude != 0) {

                                saveMyCoordinates();

                              }
                              else{
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    content: Text("Please enter a valid location"),
                                    contentPadding: EdgeInsets.all(30),
                                  );

                                });

                              }
                            }
                        )
                    )),

              ],
            ),
          )


      ),
    );
  }
}
