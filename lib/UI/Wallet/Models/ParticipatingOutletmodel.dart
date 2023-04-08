import 'dart:convert';


List<ParticipatingOutletmodel> homeInitModelFromJson(String str) =>
    List<ParticipatingOutletmodel>.from(json.decode(str).map((x) => ParticipatingOutletmodel.fromJson(x)));
String ParticipatingOutletmodelToJson(List<ParticipatingOutletmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ParticipatingOutletmodel {
  ParticipatingOutletmodel({
    required this.building_name,
    required this.tel,
    required this.address,
    required this.postal_code,
    required this.opening_hrs,
    required this.shop_name
  });

  var building_name;
  var tel;
  var address;
  var postal_code;
  var opening_hrs;
  var shop_name;



  factory ParticipatingOutletmodel.fromJson(Map<String, dynamic> json) => ParticipatingOutletmodel(
    building_name: json["building_name"],
    tel: json["tel"],
    address: json["address"],
    postal_code: json["postal_code"],
    opening_hrs: json["opening_hrs"],
    shop_name: json["shop_name"],


  );

  Map<String, dynamic> toJson() => {
    "building_name": building_name,
    "tel": tel,
    "address": address,
    "postal_code": postal_code,
    "opening_hrs": opening_hrs,
    "shop_name": shop_name,




  };


}