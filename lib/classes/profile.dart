import 'dart:core';

class Inventory {
  String capacity;
  double latitude;
  double longitude;
  String veg;
  String productid;
  String userid;
  String date;
  //String url;
  Inventory(
      {
        required this.capacity,
        required this.latitude,
        required this.longitude,
        required this.veg,
        required this.productid,
        required this.userid,
        required this.date,
      //  required this.url,
      });
}
class donor{
  String uid;
  String email;
  donor({required this.email,required this.uid});
}