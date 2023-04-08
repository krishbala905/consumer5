import 'dart:convert';

import 'EVocuherDetailsLocationModel.dart';
import 'EVocuherDetailsModel.dart';
import 'EVoucherAboutUsModel.dart';





class EVoucherAllDetailsModel {

  EVoucherDetailsModel? cardData;
  List<EVoucherDetailsLocationModel>? locations;
  EVoucherAboutUsModel? aboutUs;


  EVoucherAllDetailsModel({this.cardData, this.locations, this.aboutUs});




  EVoucherAllDetailsModel.fromJson(Map<String, dynamic> json) {

    cardData = json['CardData'] != null ? new EVoucherDetailsModel.fromJson(json['CardData']) : null;

    if (json['Locations'] != null) {
      locations = <EVoucherDetailsLocationModel>[];
      json['Locations'].forEach((v) { locations!.add(new EVoucherDetailsLocationModel.fromJson(v)); });
    }
    aboutUs = json['AboutUs'] != null ? new EVoucherAboutUsModel.fromJson(json['AboutUs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.cardData != null) {
      data['CardData'] = this.cardData!.toJson();
    }
    if (this.locations != null) {
      data['Locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    if (this.aboutUs != null) {
      data['AboutUs'] = this.aboutUs!.toJson();
    }
    return data;
  }
}
