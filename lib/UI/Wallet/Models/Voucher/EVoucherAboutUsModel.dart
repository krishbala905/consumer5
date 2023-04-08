import 'dart:convert';

class EVoucherAboutUsModel {

  var brandname;
  var brandlogo;
  var branddescription;
  var websiteurl;
  var facebookurl;
  var instagramurl;
  var galleryurls;

  EVoucherAboutUsModel(
    this.brandname,
    this.brandlogo,
    this.branddescription,
    this.websiteurl,
    this.facebookurl,
    this.instagramurl,
    this.galleryurls,
  );

  EVoucherAboutUsModel.fromJson(Map<String, dynamic> json)
      : brandname = json['brandname'],
        brandlogo = json['brandlogo'],
        branddescription = json['branddescription'],
        websiteurl = json['websiteurl'],
        facebookurl = json['facebookurl'],
        instagramurl = json['instagramurl'],
        galleryurls = json['galleryurls'];

  Map<String, dynamic> toJson() => {
    'brandname': brandname,
    'brandlogo': brandlogo,
    'branddescription': branddescription,
    'websiteurl': websiteurl,
    'facebookurl': facebookurl,
    'instagramurl': instagramurl,
    'galleryurls': galleryurls,
  };


}