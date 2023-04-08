import 'dart:convert';

import 'ECardAboutUsModel.dart';
import 'ECardDetailsLocationModel.dart';
import 'ECardDetailsModel.dart';





class ECardAllDetailsModel {

  ECardDetailsModel? cardData;
  List<ECardDetailsLocationModel>? locations;
  ECardAboutUsModel? aboutUs;


  ECardAllDetailsModel({this.cardData, this.locations, this.aboutUs});




  ECardAllDetailsModel.fromJson(Map<String, dynamic> json) {

    cardData = json['CardData'] != null ? new ECardDetailsModel.fromJson(json['CardData']) : null;

    if (json['Locations'] != null) {
      locations = <ECardDetailsLocationModel>[];
      json['Locations'].forEach((v) { locations!.add(new ECardDetailsLocationModel.fromJson(v)); });
    }
    aboutUs = json['AboutUs'] != null ? new ECardAboutUsModel.fromJson(json['AboutUs']) : null;
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
