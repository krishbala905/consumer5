class BrowseCardDetailModel {
  String? status;
  String? cardValidity;
  String? mktgInfo;
  List<CardDetails>? cardDetails;
  String? tnc;
  String? brandDescription;
  List<OutletData>? outletData;
  String? mainCardImageUrl;
  String? logoImageUrl;
  String? brand;
  String? catName;
  String? emptyInfo;
  String? email1;
  String? email2;
  String? productInfo;

  BrowseCardDetailModel(
      {this.status,
        this.cardValidity,
        this.mktgInfo,
        this.cardDetails,
        this.tnc,
        this.brandDescription,
        this.outletData,
        this.mainCardImageUrl,
        this.logoImageUrl,
        this.brand,
        this.catName,
        this.emptyInfo,
        this.email1,
        this.email2,
        this.productInfo});

  BrowseCardDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cardValidity = json['card_validity'];
    mktgInfo = json['mktg_info'];
    if (json['card_details'] != null) {
      cardDetails = <CardDetails>[];
      json['card_details'].forEach((v) {
        cardDetails!.add(new CardDetails.fromJson(v));
      });
    }
    tnc = json['tnc'];
    brandDescription = json['brand_description'];
    if (json['outlet_data'] != null) {
      outletData = <OutletData>[];
      json['outlet_data'].forEach((v) {
        outletData!.add(new OutletData.fromJson(v));
      });
    }
    mainCardImageUrl = json['main_card_image_url'];
    logoImageUrl = json['logo_image_url'];
    brand = json['brand'];
    catName = json['cat_name'];
    emptyInfo = json['empty_info'];
    email1 = json['email_1'];
    email2 = json['email_2'];
    productInfo = json['product_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['card_validity'] = this.cardValidity;
    data['mktg_info'] = this.mktgInfo;
    if (this.cardDetails != null) {
      data['card_details'] = this.cardDetails!.map((v) => v.toJson()).toList();
    }
    data['tnc'] = this.tnc;
    data['brand_description'] = this.brandDescription;
    if (this.outletData != null) {
      data['outlet_data'] = this.outletData!.map((v) => v.toJson()).toList();
    }
    data['main_card_image_url'] = this.mainCardImageUrl;
    data['logo_image_url'] = this.logoImageUrl;
    data['brand'] = this.brand;
    data['cat_name'] = this.catName;
    data['empty_info'] = this.emptyInfo;
    data['email_1'] = this.email1;
    data['email_2'] = this.email2;
    data['product_info'] = this.productInfo;
    return data;
  }
}

class CardDetails {
  String? amtToPurchase;
  String? pointVoucherTitle;
  String? voucherValidity;

  CardDetails(
      {this.amtToPurchase, this.pointVoucherTitle, this.voucherValidity});

  CardDetails.fromJson(Map<String, dynamic> json) {
    amtToPurchase = json['amt_to_purchase'];
    pointVoucherTitle = json['point_voucher_title'];
    voucherValidity = json['voucher_validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amt_to_purchase'] = this.amtToPurchase;
    data['point_voucher_title'] = this.pointVoucherTitle;
    data['voucher_validity'] = this.voucherValidity;
    return data;
  }
}

class OutletData {
  String? outletId;
  String? shopName;
  String? buildingName;
  String? address;
  String? latLon;
  String? telp;
  String? openingHrsVal;

  OutletData(
      {this.outletId,
        this.shopName,
        this.buildingName,
        this.address,
        this.latLon,
        this.telp,
        this.openingHrsVal});

  OutletData.fromJson(Map<String, dynamic> json) {
    outletId = json['outlet_id'];
    shopName = json['shop_name'];
    buildingName = json['building_name'];
    address = json['address'];
    latLon = json['lat_lon'];
    telp = json['telp'];
    openingHrsVal = json['opening_hrs_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outlet_id'] = this.outletId;
    data['shop_name'] = this.shopName;
    data['building_name'] = this.buildingName;
    data['address'] = this.address;
    data['lat_lon'] = this.latLon;
    data['telp'] = this.telp;
    data['opening_hrs_val'] = this.openingHrsVal;
    return data;
  }
}