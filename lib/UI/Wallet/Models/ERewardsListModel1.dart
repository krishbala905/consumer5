import 'dart:convert';

List<ERewardsListModel1> eRewardsListModel1FromJson(String str) =>
    List<ERewardsListModel1>.from(json.decode(str).map((x) => ERewardsListModel1.fromJson(x)));
String ERewardsListModel1ToJson(List<ERewardsListModel1> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ERewardsListModel1 {
  ERewardsListModel1({
    required this.program_id,
    required this.tier_id,
    required this.amt_to_purchase,
    required this.program_title,
    required this.program_type,
    required this.img_url,
    required this.vctnc,
    required this.MerchantLogoSettings,
    required this.ProgramTitleSettings,
    required this.LogoURL,
    required this.FontColor,


  });

  var program_id;
  var tier_id;
  var amt_to_purchase;
  var program_title;
  var program_type;
  var img_url;
  var vctnc;
  var MerchantLogoSettings;
  var ProgramTitleSettings;
  var LogoURL;
  var FontColor;



  factory ERewardsListModel1.fromJson(Map<String, dynamic> json) => ERewardsListModel1(
    program_id: json["program_id"],
    amt_to_purchase: json["amt_to_purchase"],
    tier_id: json["tier_id"],
    program_title: json["program_title"],
    img_url: json["img_url"],
    program_type: json["program_type"],
    LogoURL: json["LogoURL"],
    ProgramTitleSettings: json["ProgramTitleSettings"],
    MerchantLogoSettings: json["MerchantLogoSettings"],
    FontColor: json["FontColor"],
    vctnc: json["vctnc"],





  );

  Map<String, dynamic> toJson() => {

    "program_id": program_id,
    "program_title": program_title,
    "img_url": img_url,
    "vctnc": vctnc,
    "amt_to_purchase": amt_to_purchase,
    "tier_id": tier_id,
    "program_type": program_type,
    "LogoURL": LogoURL,
    "ProgramTitleSettings": ProgramTitleSettings,
    "MerchantLogoSettings": MerchantLogoSettings,
    "FontColor": FontColor,


  };


}