import 'dart:convert';


List<EVoucherDetailsLocationModel> eVoucherDetailsLocationModelFromJson(String str) =>
    List<EVoucherDetailsLocationModel>.from(json.decode(str).map((x) => EVoucherDetailsLocationModel.fromJson(x)));
String EVoucherDetailsModelToJson(List<EVoucherDetailsLocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class EVoucherDetailsLocationModel {
  EVoucherDetailsLocationModel({

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




  factory EVoucherDetailsLocationModel.fromJson(Map<String, dynamic> json) => EVoucherDetailsLocationModel(
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