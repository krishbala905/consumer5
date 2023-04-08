import 'dart:convert';




class ECardDetailsModel {
  var merchant_name;
  var PointExpiry;
  var punch_package_desc;
  var totalpunches;
  var amttopurchase;
  var puncheddata;
  var punchquantity;
  var Description;
  var Tnc;
  var punch_slot_status;
  var circle_data;
  var upgrade_data;
  var renewal_data;
  var spinner_data;
  var can_gift;
  var MerchantLogoSettings;
  var ProgramTitleSettings;
  var FontColor;
  var LogoURL;
  var ReferFriendOption;
  var ReferFriendLink;
  var ReferFriendContent;
  var ReferrelDescription;


  ECardDetailsModel({

    required this.merchant_name,
    required this.PointExpiry,
    required this.punch_package_desc,
    required this.totalpunches,
    required this.amttopurchase,
    required this.puncheddata,
    required this.punchquantity,
    required this.Description,
    required this.Tnc,
    required this.punch_slot_status,
    required this.circle_data,
    required this.upgrade_data,
    required this.renewal_data,
    required this.spinner_data,
    required this.can_gift,
    required this.MerchantLogoSettings,
    required this.ProgramTitleSettings,
    required this.FontColor,
    required this.LogoURL,
    required this.ReferFriendOption,
    required this.ReferFriendLink,
    required this.ReferFriendContent,
    required this.ReferrelDescription,

  });





  factory ECardDetailsModel.fromJson(Map<String, dynamic> json) => ECardDetailsModel(
    merchant_name: json["merchant_name"],
    PointExpiry: json["PointExpiry"],
    punch_package_desc: json["punch_package_desc"],
    totalpunches: json["totalpunches"],
    amttopurchase: json["amttopurchase"],
    puncheddata: json["puncheddata"],
    punchquantity :json["punchquantity"],
    Description :json["Description"],
    Tnc :json["Tnc"],
    punch_slot_status :json["punch_slot_status"],
    circle_data :json["circle_data"],
    upgrade_data :json["upgrade_data"],
    renewal_data :json["renewal_data"],
    spinner_data :json["spinner_data"],
    can_gift :json["can_gift"],
    MerchantLogoSettings :json["MerchantLogoSettings"],
    ProgramTitleSettings :json["ProgramTitleSettings"],
    FontColor :json["FontColor"],
    LogoURL :json["LogoURL"],
    ReferFriendOption :json["ReferFriendOption"],
    ReferFriendLink :json["ReferFriendLink"],
    ReferFriendContent :json["ReferFriendContent"],
    ReferrelDescription :json["ReferrelDescription"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_name": merchant_name,
    "PointExpiry": PointExpiry,
    "punch_package_desc": punch_package_desc,
    "totalpunches": totalpunches,
    "amttopurchase": amttopurchase,
    "puncheddata": puncheddata,
    "punchquantity": punchquantity,
    "Description": Description,
    "Tnc": Tnc,
    "punch_slot_status": punch_slot_status,
    "circle_data": circle_data,
    "upgrade_data": upgrade_data,
    "renewal_data": renewal_data,
    "spinner_data": spinner_data,
    "can_gift": can_gift,
    "MerchantLogoSettings": MerchantLogoSettings,
    "ProgramTitleSettings": ProgramTitleSettings,
    "FontColor": FontColor,
    "LogoURL": LogoURL,
    "ReferFriendOption": ReferFriendOption,
    "ReferFriendLink": ReferFriendLink,
    "ReferFriendContent": ReferFriendContent,
    "ReferrelDescription": ReferrelDescription,

  };


}