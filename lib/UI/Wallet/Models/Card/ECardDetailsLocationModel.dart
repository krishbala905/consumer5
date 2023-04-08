import 'dart:convert';


List<ECardDetailsLocationModel> eCardDetailsLocationModelFromJson(String str) =>
    List<ECardDetailsLocationModel>.from(json.decode(str).map((x) => ECardDetailsLocationModel.fromJson(x)));
String ECardDetailsModelToJson(List<ECardDetailsLocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ECardDetailsLocationModel {
  ECardDetailsLocationModel({

    required this.outlet_id,
    required this.shop_name,
    required this.building_name,
    required this.address,
    required this.tel,
    required this.openinghrs,
    required this.city_postal,


  });


  var outlet_id;
  var shop_name;
  var building_name;
  var address;
  var tel;
  var openinghrs;
  var city_postal;




  factory ECardDetailsLocationModel.fromJson(Map<String, dynamic> json) => ECardDetailsLocationModel(
    outlet_id: json["outlet_id"],
    shop_name: json["shop_name"],
    building_name: json["building_name"],
    address: json["address"],
    tel: json["tel"],
    openinghrs : json["openinghrs"],
    city_postal: json["city_postal"],

  );

  Map<String, dynamic> toJson() => {
    "outlet_id": outlet_id,
    "shop_name": shop_name,
    "building_name": building_name,
    "address": address,
    "tel": tel,
    "openinghrs": openinghrs,
    "city_postal": city_postal,


  };


}