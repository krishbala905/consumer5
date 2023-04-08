import 'WalletCardDetailModel.dart';
import 'WalletCardDetailModel.dart';
import 'WalletCardDetailModel.dart';

class WalletCardDetailModel {
  WalletCardDetailModel({
    required this.data,
  });
  late final Data data;

  WalletCardDetailModel.fromJson(Map<String, dynamic> json){

    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.cardData,
    required this.locations,
    required this.aboutUs,
  });
  late final CardData cardData;
  late final List<Locations> locations;
  late final AboutUs aboutUs;

  Data.fromJson(Map<String, dynamic> json){
    cardData = CardData.fromJson(json['CardData']);
    locations = List.from(json['Locations']).map((e)=>Locations.fromJson(e)).toList();
    aboutUs = AboutUs.fromJson(json['AboutUs']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CardData'] = cardData.toJson();
    _data['Locations'] = locations.map((e)=>e.toJson()).toList();
    _data['AboutUs'] = aboutUs.toJson();
    return _data;
  }
}

class CardData {
  CardData({
    required this.merchantName,
    required this.PointExpiry,
    required this.punchPackageDesc,
    required this.totalpunches,
    required this.amttopurchase,
    required this.puncheddata,
    required this.punchquantity,
    required this.Description,
    required this.Tnc,
    required this.punchSlotStatus,
    required this.circleData,
    required this.upgradeData,
    required this.renewalData,
    required this.spinnerData,
    required this.canGift,
    required this.MerchantLogoSettings,
    required this.ProgramTitleSettings,
    required this.FontColor,
    required this.LogoURL,
    required this.ReferFriendOption,
    required this.ReferFriendLink,
    required this.ReferFriendContent,
    required this.ReferrelDescription,
  });
  late final String merchantName;
  late final String PointExpiry;
  late final String punchPackageDesc;
  late final String totalpunches;
  late final String amttopurchase;
  late final String puncheddata;
  late final String punchquantity;
  late final String Description;
  late final String Tnc;
  late final String punchSlotStatus;
  late final CircleData circleData;
  late final String upgradeData;
  late final String renewalData;
  late final SpinnerData spinnerData;
  late final String canGift;
  late final String MerchantLogoSettings;
  late final String ProgramTitleSettings;
  late final String FontColor;
  late final String LogoURL;
  late final String ReferFriendOption;
  late final String ReferFriendLink;
  late final String ReferFriendContent;
  late final String ReferrelDescription;

  CardData.fromJson(Map<String, dynamic> json){
    merchantName = json['merchant_name'];
    PointExpiry = json['PointExpiry'];
    punchPackageDesc = json['punch_package_desc'];
    totalpunches = json['totalpunches'];
    amttopurchase = json['amttopurchase'];
    puncheddata = json['puncheddata'];
    punchquantity = json['punchquantity'];
    Description = json['Description'];
    Tnc = json['Tnc'];
    punchSlotStatus = json['punch_slot_status'];
    circleData = CircleData.fromJson(json['circle_data']);
    upgradeData = json['upgrade_data'];
    renewalData = json['renewal_data'];
    spinnerData = SpinnerData.fromJson(json['spinner_data']);
    canGift = json['can_gift'];
    MerchantLogoSettings = json['MerchantLogoSettings'];
    ProgramTitleSettings = json['ProgramTitleSettings'];
    FontColor = json['FontColor'];
    LogoURL = json['LogoURL'];
    ReferFriendOption = json['ReferFriendOption'];
    ReferFriendLink = json['ReferFriendLink'];
    ReferFriendContent = json['ReferFriendContent'];
    ReferrelDescription = json['ReferrelDescription'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['merchant_name'] = merchantName;
    _data['PointExpiry'] = PointExpiry;
    _data['punch_package_desc'] = punchPackageDesc;
    _data['totalpunches'] = totalpunches;
    _data['amttopurchase'] = amttopurchase;
    _data['puncheddata'] = puncheddata;
    _data['punchquantity'] = punchquantity;
    _data['Description'] = Description;
    _data['Tnc'] = Tnc;
    _data['punch_slot_status'] = punchSlotStatus;
    _data['circle_data'] = circleData.toJson();
    _data['upgrade_data'] = upgradeData;
    _data['renewal_data'] = renewalData;
    _data['spinner_data'] = spinnerData.toJson();
    _data['can_gift'] = canGift;
    _data['MerchantLogoSettings'] = MerchantLogoSettings;
    _data['ProgramTitleSettings'] = ProgramTitleSettings;
    _data['FontColor'] = FontColor;
    _data['LogoURL'] = LogoURL;
    _data['ReferFriendOption'] = ReferFriendOption;
    _data['ReferFriendLink'] = ReferFriendLink;
    _data['ReferFriendContent'] = ReferFriendContent;
    _data['ReferrelDescription'] = ReferrelDescription;
    return _data;
  }
}

class CircleData {
  CircleData({
    required this.point1,
    required this.desc1,
  });
  late final String point1;
  late final String desc1;

  CircleData.fromJson(Map<String, dynamic> json){
    point1 = json['point1'];
    desc1 = json['desc1'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['point1'] = point1;
    _data['desc1'] = desc1;
    return _data;
  }
}

class SpinnerData {
  SpinnerData();

  SpinnerData.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Locations {
  Locations({
    required this.outletId,
    required this.shopName,
    required this.buildingName,
    required this.address,
    required this.tel,
    required this.openinghrs,
    required this.cityPostal,
    required this.lat,
    required this.long,
  });
  late final String outletId;
  late final String shopName;
  late final String buildingName;
  late final String address;
  late final String tel;
  late final String openinghrs;
  late final String cityPostal;
  late final String lat;
  late final String long;

  Locations.fromJson(Map<String, dynamic> json){
    outletId = json['outlet_id'];
    shopName = json['shop_name'];
    buildingName = json['building_name'];
    address = json['address'];
    tel = json['tel'];
    openinghrs = json['openinghrs'];
    cityPostal = json['city_postal'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['outlet_id'] = outletId;
    _data['shop_name'] = shopName;
    _data['building_name'] = buildingName;
    _data['address'] = address;
    _data['tel'] = tel;
    _data['openinghrs'] = openinghrs;
    _data['city_postal'] = cityPostal;
    _data['lat'] = lat;
    _data['long'] = long;
    return _data;
  }
}

class AboutUs {
  AboutUs();

  AboutUs.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}