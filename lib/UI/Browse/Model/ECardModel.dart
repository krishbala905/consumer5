import 'dart:convert';


List<ECardModel> eCardModelFromJson(String str) =>
    List<ECardModel>.from(json.decode(str).map((x) => ECardModel.fromJson(x)));
String ECardModelToJson(List<ECardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ECardModel {
  ECardModel({
    required this. programIDlist,
    required this. programTypelist ,
    required this. programNamelist ,
    required this. bannerImagelist ,
    required this. programRewardslist,
    required this. outletIDlist,
    required this. outletNamelist,
    required this. distancelist ,
    required this. originalPricelist ,
    required this. currentPricelist ,
    required this. likeCountlist ,
    required this. likeStatuslist ,
    required this. rewardsIDlist ,
    required this. merchantIDlist,
    required this. merchantNamelist,
    required this. currencylist,
    required this. programImagerURLS ,
    required this. emailIds ,
    required this. phoneNumbers,
    required this.downloadflag
  });

  var programIDlist;
  var programTypelist ;
  var programNamelist ;
  var bannerImagelist ;
  var programRewardslist;
  var outletIDlist;
  var outletNamelist;
  var distancelist ;
  var originalPricelist ;
  var currentPricelist ;
  var likeCountlist ;
  var likeStatuslist ;
  var rewardsIDlist ;
  var merchantIDlist;
  var merchantNamelist;
  var currencylist;
  var programImagerURLS ;
  var emailIds ;
  var phoneNumbers ;
  var downloadflag;

  factory ECardModel.fromJson(Map<String, dynamic> json) => ECardModel(
      programIDlist : json["programIDlist"],
      programTypelist  : json["programTypelist"],
  programNamelist  : json["programNamelist"],
  bannerImagelist  : json["bannerImagelist"],
      programRewardslist : json["programRewardslist"],
      outletIDlist : json["outletIDlist"],
      outletNamelist : json["outletNamelist"],
  distancelist  : json["distancelist"],
  originalPricelist  : json["originalPricelist"],
      currentPricelist  : json["currentPricelist"],
      likeCountlist  : json["likeCountlist"],
      likeStatuslist  : json["likeStatuslist"],
  rewardsIDlist  : json["rewardsIDlist"],
  merchantIDlist : json["merchantIDlist"],
      merchantNamelist : json["merchantNamelist "],
      currencylist : json["currencylist"],
      programImagerURLS  : json["programImagerURLS"],
      emailIds  : json["emailIds "],
      phoneNumbers :json["phoneNumbers"],
      downloadflag:json["downloadflag"]


  );

  Map<String, dynamic> toJson() => {
    "programIDlist ": programIDlist,
    "programTypelist  ": programTypelist,
    "programNamelist  ": programNamelist,
    "bannerImagelist  ": bannerImagelist,
    "programRewardslist ": programRewardslist,
    "outletIDlist ": outletIDlist,
    "outletNamelist ": outletNamelist,
    "distancelist  ": distancelist,
    "originalPricelist  ": originalPricelist,
    "currentPricelist  ": currentPricelist,
    "likeCountlist  ": likeCountlist,
    "likeStatuslist  ": likeStatuslist,
    "rewardsIDlist  ": rewardsIDlist,
    "merchantIDlist ": merchantIDlist,
    "merchantNamelist ": merchantNamelist ,
    "currencylist ": currencylist,
    "programImagerURLS  ": programImagerURLS,
    "emailIds  ": emailIds ,
    "phoneNumbers ":phoneNumbers,
    "downloadflag":downloadflag

  };


}