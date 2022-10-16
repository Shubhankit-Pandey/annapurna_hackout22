import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  double nextScreenLatitude = 0 ;
  double nextScreenLongitude = 0 ;
  void saveMyCoordinates() async {
    setState(() {
      UpdateMyCoordinates();
      update();
      print('$nextScreenLatitude and$nextScreenLongitude');
    });
    }

  void UpdateMyCoordinates()async{
    Location locator = Location();
    var locatorData = await locator.getLocation();
    setState(() {
      nextScreenLatitude =  locatorData.latitude! ;
      nextScreenLongitude = locatorData.longitude! ;
      print('$nextScreenLatitude and$nextScreenLongitude');

    });

  }
  double intialLatitude = 20.5937;
  double intitalLongitude = 78.9629;

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
      );
    });
  }

void update()async{
    var locationData = await _locationT.getLocation();
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
                  top: 700,
                    left: 30,
                    child: Container(
                      height: 100,
                      width: 170,
                      child: TextButton(
                            onPressed: (){
                             update();
                            },
                            child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                ),
                                child: Center(child: Text("Change my location",style: TextStyle(color: Colors.green,fontSize: 16),))
                            ),
                          ),
                    )),
                Positioned(
                    top: 700,
                    left: 220,
                    child: Container(
                      height: 100,
                      width: 170,
                      child: TextButton(
                        onPressed: (){
                              () {
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
                          };
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green
                            ),
                            child: Center(child: Text("Save my location",style: TextStyle(color: Colors.white,fontSize: 16),))
                        ),
                      ),



                    )),

              ],
            ),
          )


      ),
    );
  }
}
