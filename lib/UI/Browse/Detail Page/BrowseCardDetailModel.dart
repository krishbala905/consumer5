// To parse this JSON data, do
//
//     final browseCardDetailModel = browseCardDetailModelFromJson(jsonvar);

// To parse this JSON data, do
//
//     final browseCardDetailModel = browseCardDetailModelFromJson(jsonvar);

// To parse this JSON data, do
//
//     final browseCardDetailModel = browseCardDetailModelFromJson(jsonvar);

import 'dart:convert';

List<BrowseCardDetailModel> browseCardDetailModelFromJson(String str) =>
    List<BrowseCardDetailModel>.from(json.decode(str).map((x) => BrowseCardDetailModel.fromJson(x)));
String browseCardDetailModelToJson(List<BrowseCardDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/*
BrowseCardDetailModel browseCardDetailModelFromJson(String str) => BrowseCardDetailModel.fromJson(json.decode(str));

String browseCardDetailModelToJson(BrowseCardDetailModel data) => json.encode(data.toJson());
*/

class BrowseCardDetailModel {
  BrowseCardDetailModel({
    required this.expiryDetails,
    required this.benefits,
    required this. rewards,
    required this.rewardsPointList,
    required this.tnc,
    required this.rewardsDescList,
    required this.rewardsExpiryList,
    required this.merchantinfo,
    required this.outletID ,
    required this.outletName,
    required this.outletBuiding,
    required this.outletAddress,
    required this.outletOpHours,
    required this.outletContact,
    required this.programImageURLs,
    required this.merchantLogoURL,
    required this.merchantName,
    required this.merchantSubCategory,
    required this.merchantRating,
    required this.merchantEmail,
    required this.merchantWebsite,
    required this.merchantGalleryURLs,
  });

  var expiryDetails;
  var benefits;
  var  rewards;
  var rewardsPointList;
  var tnc;
  var rewardsDescList;
  var rewardsExpiryList;
  var merchantinfo;
  var outletID ;
  var outletName;
  var outletBuiding;
  var outletAddress;
  var outletOpHours;
  var outletContact;
  var programImageURLs;
  var merchantLogoURL;
 var merchantName, merchantSubCategory, merchantRating, merchantEmail, merchantWebsite,merchantGalleryURLs;

  factory BrowseCardDetailModel.fromJson(Map<String, dynamic> json) => BrowseCardDetailModel(
    expiryDetails: json["expiryDetails"],
    benefits: json["benefits"],
     rewards: json["rewards"],
    rewardsPointList: json["rewardsPointList"],
    tnc: json["tnc"],
    rewardsDescList: json["rewardsDescList"],
    rewardsExpiryList: json["rewardsExpiryList"],
    merchantinfo: json["merchantinfo"],
    outletID : json["outletID"],
    outletName: json["outletName"],
    outletBuiding: json[" outletBuiding"],
    outletAddress: json["outletAddress"],
    outletOpHours: json["outletOpHours"],
    outletContact: json["outletContact"],
    programImageURLs: json["programImageURLs"],
    merchantLogoURL: json["merchantLogoURL"],
    merchantName: json["merchantName"],
    merchantSubCategory: json["merchantSubCategory"],
    merchantRating: json["merchantRating"],
    merchantEmail: json["merchantEmail"],
    merchantWebsite: json["merchantWebsite"],
    merchantGalleryURLs: json["merchantGalleryURLs"],
  );

  Map<String, dynamic> toJson() => {
    "expiryDetails": expiryDetails,
    "benefits": benefits,
    "rewards":  rewards,
    "rewardsPointList":  rewardsPointList,
    "tnc": tnc,
    "rewardsDescList": rewardsDescList,
    "rewardsExpiryList": rewardsExpiryList,
    "merchantinfo": merchantinfo,
    "outletID": outletID ,
    "outletName": outletName,
    "outletBuiding": outletBuiding,
    "outletAddress": outletAddress,
    "outletOpHours": outletOpHours,
    "outletContact": outletContact,
    "programImageURLs": programImageURLs,
    "merchantLogoURL": merchantLogoURL,
    "merchantName": merchantName,
    "merchantSubCategory":merchantSubCategory,
    "merchantRating":merchantRating,
    "merchantEmail":merchantEmail,
    "merchantWebsite":merchantWebsite,
    "merchantGalleryURLs":merchantGalleryURLs,
  };
}

/*class CardDetail {
  CardDetail({
    required this.amtToPurchase,
    required this.pointVoucherTitle,
    required this.voucherValidity,
  });

  var amtToPurchase;
  var pointVoucherTitle;
  var voucherValidity;

  factory CardDetail.fromJson(Map<var, dynamic> json) => CardDetail(
    amtToPurchase: json["amt_to_purchase"],
    pointVoucherTitle: json["point_voucher_title"],
    voucherValidity: json["voucher_validity"],
  );

  Map<var, dynamic> toJson() => {
    "amt_to_purchase": amtToPurchase,
    "point_voucher_title": pointVoucherTitle,
    "voucher_validity": voucherValidity,
  };
}

class OutletDatum {
  OutletDatum({
    required this.outletId,
    required this.shopName,
    required this.buildingName,
    required this.address,
    required this.latLon,
    required this.telp,
    required this.openingHrsVal,
  });

  var outletId;
  var shopName;
  var buildingName;
  var address;
  var latLon;
  var telp;
  var openingHrsVal;

  factory OutletDatum.fromJson(Map<var, dynamic> json) => OutletDatum(
    outletId: json["outlet_id"],
    shopName: json["shop_name"],
    buildingName: json["building_name"],
    address: json["address"],
    latLon: json["lat_lon"],
    telp: json["telp"],
    openingHrsVal: json["opening_hrs_val"],
  );

  Map<var, dynamic> toJson() => {
    "outlet_id": outletId,
    "shop_name": shopName,
    "building_name": buildingName,
    "address": address,
    "lat_lon": latLon,
    "telp": telp,
    "opening_hrs_val": openingHrsVal,
  };
}*/
