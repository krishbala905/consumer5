

 import 'dart:convert';

List<CarDetailsModel> CarDetailsModelFromJson(String str) =>
     List<CarDetailsModel>.from(json.decode(str).map((x) => CarDetailsModel.fromJson(x)));
 String CarDetailsModellToJson(List<CarDetailsModel> data) =>
     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


 class CarDetailsModel {
  CarDetailsModel({
 required this.brandName,
 required this.brandId,
 required this.brandModel,

 }

 );

 String brandName;
 String brandId;
 var brandModel;



 factory CarDetailsModel.fromJson(Map<String, dynamic> json) => CarDetailsModel(
  brandName: json["brand_names"],
  brandId: json["brand_ids"],

  brandModel: json["model"],

 );

 Map<String, dynamic> toJson() => {
 "brandName": brandName,
 "brandId": brandId,
 "brandModel": brandModel,
 };


 }