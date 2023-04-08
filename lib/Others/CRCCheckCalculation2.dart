import 'dart:core';

import 'CommonUtils.dart';

class CRCCheckCalculation2 {
  static final String TAG = "CRCCheckCalculation2";

  int program_id;
  int member_id;
  int countryindexid;
  String actiontype;
  int Q_ty;
  int G_iftOrderId;




   CRCCheckCalculation2(
    this.program_id ,
    this.member_id,
    this.actiontype,
    this.countryindexid,
    this.Q_ty,
    this.G_iftOrderId);




  String  converttoHex(int n)
  {return n.toRadixString(16);}


  String checkData(List test) {
  bool valid = true;
  int crc = 0xFFFF; // initial value
  int polynomial = 0x1021; // 0001 0000 0010 0001 (0, 5, 12)
  for (var b in test) {
  for (int i = 0; i < 8; i++) {
  bool bit = ((b >> (7 - i) & 1) == 1);
  bool c15 = ((crc >> 15 & 1) == 1);
  crc <<= 1;
  if (c15 ^ bit)
  crc ^= polynomial;
  }
  }
  crc &= 0xffff;
  return crc.toRadixString(16).toString();
  }


   String checkNewCRC(int current_program_type) {
    String qrimageformat = "";
    print("MK"+qrimageformat.toString());

    List test = List.filled(10, null, growable: false);
    int temp = 0;
    int num1 = 0;
    int num2 = 0;
    int num3 = 0;
    int num4 = 0;
    int num5 = 0;
    int num6 = 0;
    int num7 = 0;
    int num8 = 0;
    int num9 = 0;
    int num10 = 0;

    int num11 = 0;
    int num12 = 0;
    int num13 = 0;
    int num14 = 0;
    int num15 = 0;
    int num16 = 0;


    temp = current_program_type;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num1 = temp;
    temp = current_program_type;
    temp = temp & 0x000000ff;
    num2 = temp;

    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num3 = temp;
    temp = int.parse(CommonUtils.consumerID.toString()) ;
    temp = temp & 0x000000ff;
    num4 = temp;
    // /////////////////////////
    temp = member_id;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num5 = temp;
    temp = member_id;
    temp = temp & 0x000000ff;
    num6 = temp;

    temp = int.parse(CommonUtils.deviceTokenID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num7 = temp;
    temp =int.parse(CommonUtils.deviceTokenID.toString());// Integer.parseInt(device_token);
    temp = temp & 0x000000ff;
    num8 = temp;
    // /////////////////////////
    temp = program_id;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num9 = temp;
    temp = program_id;
    temp = temp & 0x000000ff;
    num10 = temp;

    test[0] = num1;
    test[1] =  num2;
    test[2] =  num3;
    test[3] =  num4;
    test[4] =  num5;
    test[5] =  num6;
    test[6] =  num7;
    test[7] =  num8;
    test[8] =  num9;
    test[9] =  num10;

    String crc_msg = checkData(test);
    String programtype = converttoHex(current_program_type);
//        Timber.d("hex program type: %s", programtype);
    String consumerid = converttoHex(int.parse(CommonUtils.consumerID .toString()));
    String memberid = converttoHex(member_id);
    String devicetokenid = converttoHex(int.parse(CommonUtils.deviceTokenID.toString()));
    String programid = converttoHex(program_id);
    String Qty = converttoHex(Q_ty);
    String GiftOrderId = converttoHex(G_iftOrderId);

    String programtypetoGenerateQR = CheckLengthIsEven(programtype);
    String consumeridtoGenerateQR = CheckLengthIsEven(consumerid);
    String memberidtoGenerateQR = CheckLengthIsEven(memberid);
    String devicetokenidtoGenerateQR = CheckLengthIsEven(devicetokenid);
    String programidtoGenerateQR = CheckLengthIsEven(programid);
    String programQtytoGenerateQR = CheckLengthIsEven(Qty);
    String programGiftOrderIdtoGenerateQR = CheckLengthIsEven(GiftOrderId);

    String crc_msgtoGenerateQR = checkLengthForChecksum(crc_msg);

    var a = getRandomNumberBetweenAndToCharacter();
    var b = getRandomNumberBetweenAndToCharacter();
    var c = getRandomNumberBetweenAndToCharacter();
    var d = getRandomNumberBetweenAndToCharacter();


    String random_alphabet1 = "o".toUpperCase();
    String random_alphabet2 = "j".toUpperCase();
    String random_alphabet3 = "r".toUpperCase();
    String random_alphabet4 = "z".toUpperCase();
    String random_alphabet5 = "u".toUpperCase();
    String random_alphabet6 = "v".toUpperCase();


    qrimageformat = "ML" + programtypetoGenerateQR + consumeridtoGenerateQR
        + random_alphabet1 + memberidtoGenerateQR + random_alphabet2
        + devicetokenidtoGenerateQR + random_alphabet3
        + programidtoGenerateQR + random_alphabet6
        + crc_msgtoGenerateQR + appendQRImagewithOtherDetails();// for

     print("ML" +":1"+ programtypetoGenerateQR  +":2"+ consumeridtoGenerateQR
         +":3"+ random_alphabet1 +":4"+ memberidtoGenerateQR  +":5"+ random_alphabet2
         +":6"+ devicetokenidtoGenerateQR  +":7"+ random_alphabet3
         +":8"+ programidtoGenerateQR  +":9"+ random_alphabet4
         +":0"+ programQtytoGenerateQR  +":1"+ random_alphabet5
         +":2"+ programGiftOrderIdtoGenerateQR  +":3"+ random_alphabet6
         +":4"+ crc_msgtoGenerateQR  +":5"+ appendQRImagewithOtherDetails());// f
    return qrimageformat;

  }

   String appendQRImagewithOtherDetails() {
    String qrimageformat = "";



    List test = List.filled(10, null, growable: false);
    int temp = 0;
    int num1 = 0;
    int num2 = 0;
    int num3 = 0;
    int num4 = 0;
    int num5 = 0;
    int num6 = 0;
    int num7 = 0;
    int num8 = 0;
    int num9 = 0;
    int num10 = 0;

    temp = CommonUtils.QRVERSION;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num1 = temp;
    temp = CommonUtils.QRVERSION;
    temp = temp & 0x000000ff;
    num2 = temp;
    temp = countryindexid;// CommonUtil.COUNTRYINDEXID;//countryindexid
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num3 = temp;
    temp = countryindexid;// CommonUtil.COUNTRYINDEXID;//countryindexid
    temp = temp & 0x000000ff;
    num4 = temp;

    temp = CommonUtils.SELECTEDLANGUAGEPACKAGEID;
    // temp = CommonUtil.APPLICATION_LANGUAGE_ID;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num5 = temp;
    temp = CommonUtils.SELECTEDLANGUAGEPACKAGEID;
    //temp = CommonUtil.APPLICATION_LANGUAGE_ID;
    temp = temp & 0x000000ff;
    num6 = temp;
    // /////////////////////////
    temp = CommonUtils.APPLICATIONID;
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num7 = temp;
    temp = CommonUtils.APPLICATIONID;
    temp = temp & 0x000000ff;
    num8 = temp;
    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp >> 8;
    temp = temp & 0x000000ff;
    num9 = temp;
    temp = int.parse(CommonUtils.consumerID.toString());
    temp = temp & 0x000000ff;
    num10 = temp;

    test[0] =  num1;
    test[1] =  num2;
    test[2] =  num3;
    test[3] =  num4;
    test[4] =  num5;
    test[5] =  num6;
    test[6] =  num7;
    test[7] =  num8;
    test[8] =  num9;
    test[9] =  num10;

    String crc_msgforappend = checkData(test);

    // AA: QR Version (1 letter)
    // BB: Country's ID Index (2 letters)
    // CC: rewards's Language ID (1 letter)
    // DD: Application's ID (2 letters)
    // CCCC: Checksum (With rewards's ID, 4 letters)

    // String con_id = converttoHex(CommonUtil.CONSUMER_ID);//
    // fordifferntiating
    String qrversion = converttoHex(CommonUtils.QRVERSION);
    String countryindex_idforqr = converttoHex(countryindexid);// CommonUtil.COUNTRYINDEXID
    String languagepackid = converttoHex(CommonUtils.SELECTEDLANGUAGEPACKAGEID);
    //String languagepackid = converttoHex(CommonUtil.APPLICATION_LANGUAGE_ID);
    String appid = converttoHex(CommonUtils.APPLICATIONID);
    appid = CheckLengthIsEven(appid);
    countryindex_idforqr = CheckLengthIsEven(countryindex_idforqr);

    var a = getRandomNumberBetweenAndToCharacter();
    var b = getRandomNumberBetweenAndToCharacter();
    var c = getRandomNumberBetweenAndToCharacter();

//        String random_alphabet1 = String.valueOf(a).toUpperCase();
//        String random_alphabet2 = String.valueOf(b).toUpperCase();
//        String random_alphabet3 = String.valueOf(c).toUpperCase();
//        String random_alphabet4 = String.valueOf(c).toUpperCase();

    String random_alphabet1 = "t".toUpperCase();
    String random_alphabet2 = "x".toUpperCase();
    String random_alphabet3 = "v".toUpperCase();
    String random_alphabet4 = "y".toUpperCase();
    String random_alphabet5 = "i".toUpperCase();
    // random_alphabet1+con_id+ no need
    crc_msgforappend = checkLengthForChecksum(crc_msgforappend);
    qrimageformat = random_alphabet1 + qrversion + random_alphabet2
        + countryindex_idforqr + random_alphabet3 + languagepackid
        + random_alphabet4 + appid + random_alphabet5
        + crc_msgforappend;
    print("1212"+random_alphabet1 + qrversion + random_alphabet2
        + countryindex_idforqr + random_alphabet3 + languagepackid
        + random_alphabet4 + appid + random_alphabet5
        + crc_msgforappend);

    return qrimageformat;
  }

   String checkLengthForChecksum(String crcstring) {
    String valuetoreturn = crcstring;
    int definedcrclength = 4;
    int length = crcstring.length;
    if (length != definedcrclength) {
      switch (length) {
        case 0:
          valuetoreturn = "0000" + crcstring;
          break;
        case 1:
          valuetoreturn = "000" + crcstring;
          break;
        case 2:
          valuetoreturn = "00" + crcstring;
          break;
        case 3:
          valuetoreturn = "0" + crcstring;
          break;
        case 4:
          valuetoreturn = crcstring;
          break;
      }
    } else {
      valuetoreturn = crcstring;
    }
    return valuetoreturn;
  }

   String CheckLengthIsEven(String checkLengthOFString) {
    String valuetoreturn = checkLengthOFString;
    if (CheckEvenNumberOrNot(checkLengthOFString.length)) {
      valuetoreturn = checkLengthOFString.toString();
    } else {
      valuetoreturn = "0" + checkLengthOFString.toString();
    }
    return valuetoreturn;
  }

   bool CheckEvenNumberOrNot(int checkthisnumber) {
    return (checkthisnumber % 2) == 0;
  }

}