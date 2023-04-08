

import 'dart:convert';

List<InboxDetailsModel> InboxDetailsModelFromJson(String str) =>
    List<InboxDetailsModel>.from(json.decode(str).map((x) => InboxDetailsModel.fromJson(x)));
String InboxDetailsModelToJson(List<InboxDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class InboxDetailsModel {
  InboxDetailsModel({
  required this.HTML_FILE,
  required this. MESSAGE_ID ,
    required this. MESSAGE_TITLE,
    required this. MESSAGE_DESCRIPTION,
    required this.  MESSAGE_IMAGES ,
    required this.  EVENT_STATUS,
    required this.  VOUCHER_STATUS,
    required this.  BUTTON_STATUS,
    /*required this.VOUCHER_TITLE,
    required this.VOUCHER_URL,
    required this.BRAND_NAME,
    required this.BRAND_LOGO_URL,*/
 // required this. INBOX_COUNT,

  });

  var HTML_FILE,MESSAGE_ID,MESSAGE_TITLE,MESSAGE_DESCRIPTION,BUTTON_STATUS,
      VOUCHER_STATUS,EVENT_STATUS,MESSAGE_IMAGES;
  // ,VOUCHER_TITLE,VOUCHER_URL,BRAND_NAME,BRAND_LOGO_URL;
 // INBOX_COUNT;


  factory InboxDetailsModel.fromJson(Map<String, dynamic> json) => InboxDetailsModel(

  MESSAGE_ID :json["MESSAGE_ID"],
  HTML_FILE :json["HTML_FILE"],
    MESSAGE_TITLE:json["MESSAGE_TITLE"],
 MESSAGE_DESCRIPTION: json["MESSAGE_DESCRIPTION"],
 MESSAGE_IMAGES: json["MESSAGE_IMAGES"],
 EVENT_STATUS: json["EVENT_STATUS"],
      VOUCHER_STATUS:json["VOUCHER_STATUS"],
      BUTTON_STATUS: json["BUTTON_STATUS"],
    /*VOUCHER_TITLE:json["VOUCHER_TITLE"],
    VOUCHER_URL: json["VOUCHER_URL"],
    BRAND_NAME:json["BRAND_NAME"],
    BRAND_LOGO_URL:json["BRAND_LOGO_URL"],*/
 // INBOX_COUNT:json["INBOX_COUNT"],

  );

  Map<String, dynamic> toJson() => {
  "MESSAGE_ID": MESSAGE_ID ,
    "HTML_FILE":HTML_FILE,
    "MESSAGE_TITLE":  MESSAGE_TITLE,
    "MESSAGE_DESCRIPTION": MESSAGE_DESCRIPTION,
    "MESSAGE_IMAGES": MESSAGE_IMAGES,
    "EVENT_STATUS":EVENT_STATUS,
    "VOUCHER_STATUS": VOUCHER_STATUS,
    "BUTTON_STATUS": BUTTON_STATUS,
    /*"VOUCHER_TITLE":VOUCHER_TITLE,
    "VOUCHER_URL":VOUCHER_URL,
    "BRAND_NAME":BRAND_NAME,
    "BRAND_LOGO_URL":BRAND_LOGO_URL,*/
  // "INBOX_COUNT":INBOX_COUNT,

  };


}
