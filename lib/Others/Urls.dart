import 'package:flutter/material.dart';

//  const BASEURL1 = "https://mbm.poket.com/main/";
 const BASEURL1 = "https://mbmdev.poket.com/main/";


const SERVER_SUB_HEADER = "newapi/";

const LOGIN_URL =  "$BASEURL1${SERVER_SUB_HEADER}ConsumerLoginCmd";

const SIGNUP_URL =  "$BASEURL1${SERVER_SUB_HEADER}ConsumerSignUpCmd";

const RESETPASSWORD_URL = "$BASEURL1${SERVER_SUB_HEADER}ForgotPasswordCmd";

const PRIVACY_URL = "https://mbm.poket.com/main/newapi/PrivacyCmd";

const TERMS_AND_CONDITION_URL = "https://mbm.poket.com/main/newapi/TermsCoditionsCmd";

const LOGOUT_URL ='$BASEURL1${SERVER_SUB_HEADER}ConsumerLogoutCmd';

const PROFILE_URL ='$BASEURL1${SERVER_SUB_HEADER}ConsumerProfileCmd';

const ABOUTUS_URL ="https://mbm.poket.com/main/newapi/AboutUsCmd";

const CHANGEPASSWORD_URL ='$BASEURL1${SERVER_SUB_HEADER}/ConsumerChangePasswordCmd';

const HISTORY_LOG_URL = BASEURL1+"consumer/CMAHistoryLogCmd";

const UPLOADPROFILEPHOTO_URL = "$BASEURL1${SERVER_SUB_HEADER}ConsumerPhotoCmd";

const PPN_URL ="$BASEURL1${SERVER_SUB_HEADER}PPNCmd" ;

const INBOX_URL ='$BASEURL1${SERVER_SUB_HEADER}InboxListCmd';

const BROWSEPROGRAMURL ='$BASEURL1${SERVER_SUB_HEADER}BrowseProgramsCmdMBMV2';

const INBOX_DETAILS_URL ='$BASEURL1${SERVER_SUB_HEADER}InboxListDetailsCmd';

const AccountDeletionUrl= BASEURL1 + SERVER_SUB_HEADER +"DeleteUserRequestCMD";

const INBOX_DETAILS_URL1 =     BASEURL1 + SERVER_SUB_HEADER + 'showwebview/getWebView/';

const WALLETCARDURL =     BASEURL1 + SERVER_SUB_HEADER +"CMAWalletSyncCmd";

const WALLETCARDURLNEW =     BASEURL1 + SERVER_SUB_HEADER +"MBMNewUiPoketWalletCmd  ";

const WALLETCARDDETAILSURLNEW =     BASEURL1 + SERVER_SUB_HEADER +"MBMNewUiPoketWalletCardDetailsCmd  ";

const PARTICIPATINGOUTLETCMD ="$BASEURL1${SERVER_SUB_HEADER}ParticipatingOutletsCmd" ;

const REDEEMVOUCHER_URL = BASEURL1 + "tabletapplication/" + "RedeemVoucherThroughCMACmd";

const GIFTPROGRAM_URL = "$BASEURL1${SERVER_SUB_HEADER}GiftProgramCmd";

const CARD_REWARDS_URL = "$BASEURL1${SERVER_SUB_HEADER}MemberCardPointsVisitsCmd";

const CARD_REWARDS_LIST_URL = "$BASEURL1${SERVER_SUB_HEADER}MBMNewUiRewards";

const DELETEPROGRAM_URL = "$BASEURL1${SERVER_SUB_HEADER}CMAPurgeProgramCmd";

const FEEDBACK_URL = "$BASEURL1${SERVER_SUB_HEADER}TransactionFeedbackCmd";

const POKETIT_URL = "$BASEURL1${SERVER_SUB_HEADER}PoketItCmd";

const VIEWPROGRAMDEATAIL_URL = "$BASEURL1${SERVER_SUB_HEADER}ViewProgramDetailsCmd";

const PAYMENT_URL = "$BASEURL1${SERVER_SUB_HEADER}onlinePaymentCarsearch";

const CARD_POINTS_EXPIRY = "$BASEURL1${SERVER_SUB_HEADER}MemberCardPointsExpiryCmd";

const CARTYPE_URL = "$BASEURL1${SERVER_SUB_HEADER}MbmDownloadCarDetailsCmdJson";

