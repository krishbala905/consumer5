import 'dart:convert';


List<ERewardsModel> eCardModelFromJson(String str) =>
    List<ERewardsModel>.from(json.decode(str).map((x) => ERewardsModel.fromJson(x)));
String ERewardsModelToJson(List<ERewardsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ERewardsModel {
  ERewardsModel({
    required this. lastUpdated,
    required this. cardExpiry ,
    required this. yourPoints ,
    required this. oneYearSpending ,
    required this. accumulatedSpending,
    required this. autoUpgradeCriteria,
    required this. showButton,


  });

  var lastUpdated;
  var cardExpiry ;
  var yourPoints ;
  var oneYearSpending ;
  var accumulatedSpending;
  var autoUpgradeCriteria;
  var showButton;


  factory ERewardsModel.fromJson(Map<String, dynamic> json) => ERewardsModel(
      lastUpdated : json["lastUpdated"],
      cardExpiry  : json["cardExpiry"],
    yourPoints  : json["yourPoints"],
      oneYearSpending  : json["oneYearSpending"],
      accumulatedSpending : json["accumulatedSpending"],
      autoUpgradeCriteria : json["autoUpgradeCriteria"],
    showButton : json["showButton"],
  );

  Map<String, dynamic> toJson() => {
    "lastUpdated ": lastUpdated,
    "cardExpiry  ": cardExpiry,
    "yourPoints  ": yourPoints,
    "oneYearSpending  ": oneYearSpending,
    "accumulatedSpending ": accumulatedSpending,
    "autoUpgradeCriteria ": autoUpgradeCriteria,
    "showButton ": showButton,
  };


}