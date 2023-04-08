import 'dart:convert';

List<WalletmodelVoucher1New> WalletmodelVoucher1NewFromJson(String str) =>
    List<WalletmodelVoucher1New>.from(json.decode(str).map((x) => WalletmodelVoucher1New.fromJson(x)));
String WalletmodeToJson(List<WalletmodelVoucher1New> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class WalletmodelVoucher1New {
  WalletmodelVoucher1New({
    required this.program_id,
    required this.member_id,
    required this.program_title ,
    required this.program_type,
    required this.img_url,
    required this.merchant_name,
    required this.expire_date,
    required this.balance,
    required this.country_index,
    required this.sub_type,
    required this.merchant_id,
    required this.date_joined,
    required this.accept_status,
    required this.clickinformation,
    required this.sent_to_friend,
    required this.ProgramTitleSettings,
    required this.FontColor,
    required this.LogoURL,
    required this.full_run_no


  });

  var  program_id,
  member_id,
  program_title ,
  program_type,
  img_url,
  merchant_name,
  expire_date,
  balance,
  country_index,
  sub_type,
  merchant_id,
  date_joined,
  accept_status,
  clickinformation,
  sent_to_friend,
  ProgramTitleSettings,
  FontColor,
  LogoURL,full_run_no;


  factory WalletmodelVoucher1New.fromJson(Map<String, dynamic> json) => WalletmodelVoucher1New(
    program_id: json["program_id"],
    member_id: json["member_id"],
    program_title : json["program_title"],
    program_type: json["program_type"],
    img_url: json["img_url"],
    merchant_name: json["merchant_name"],
    expire_date: json["expire_date"],
    balance: json["balance"],
    country_index: json["country_index"],
    sub_type: json["sub_type"],
    merchant_id: json["merchant_id"],
    date_joined: json["date_joined"],
    accept_status: json["accept_status"],
    clickinformation: json["clickinformation"],
    sent_to_friend: json["sent_to_friend"],
    ProgramTitleSettings: json["ProgramTitleSettings"],
    FontColor: json["FontColor"],
    LogoURL: json["LogoURL"],
    full_run_no: json["full_run_no"],

  );

  Map<String, dynamic> toJson() => {

    "programID": program_id,
    "member_id": member_id,
    "program_title" : program_title ,
    "program_type": program_type,
    "img_url": img_url,
    "merchant_name": merchant_name,
    "expire_date": expire_date,
    "balance": balance,
    "country_index": country_index,
    "sub_type": sub_type,
    "merchant_id": merchant_id,
    "date_joined": date_joined,
    "accept_status": accept_status,
    "clickinformation ": clickinformation,
    "sent_to_friend": sent_to_friend,
    "ProgramTitleSettings": ProgramTitleSettings,
    "FontColor": FontColor,
    "LogoURL": LogoURL,
    "full_run_no": full_run_no,


  };


}

