import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EndPoints {
  EndPoints._();

  /// DEFAULT ACCESS DETAILS
  static const String apiKey = "fe2d8ccea030a666efb044716e168ec6";
  static const String apiSecretKey = "74e65fa5e30d964b2be5bd0a8d3e0553";
  static const String storeName = "apollohospitals";
  static const String mainUrl = "https://apollohospitals.myshopify.com/";
  static const String accessToken = "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";
  static const String aToken = "Apollo12345";
  static const String aLoginToken = "e44583241c0b66f362b767ec913c07e9";

  // Virtual mirror webview
  static const String virtualMirror =
      'https://mirror.virtooal.com/app/7af8d58c19eef8a066e7fab8a5088ce8/arun.raj@solstium.net?c=000000&l=en';

  //Token:Apollo12345
  /// LIVE KEY ID
  // // 05/07/2023
  // static const String myRazorpayKey = "rzp_live_bNQlrdGj8nP5da";
  // static const String myRazorpaySecret = "u1oW7XvVpItgQUxLpbMnTUyZ";

  /// TEST KEY ID
  // 05/07/2023
  static const String myRazorpayKey = "rzp_test_yRvehUQlW46QZh";
  static const String myRazorpaySecret = "dk3Sks9GLgX6pvufaLmYH9EQ";

  /// FRESH CHAT
  // CLIENT
  static const String freshChatAppId = "a3c771aa-bf03-4c95-b8e3-7aa59f388943";
  static const String freshChatAppKey = "6c978415-d9a0-46ff-91da-a8fab3b1d721";
  static const String freshChatSDK = "msdk.in.freshchat.com";

  // OWN
  // static const String freshChatAppId = "351d4faf-68c8-49e0-8400-c3b5ca8ab61d";
  // static const String freshChatAppKey = "457084bf-a7d5-43ca-a3e9-fe6a2de811bf";
  // static const String freshChatSDK = "msdk.freshchat.com";

  /// FYI
  /// https://shopify.dev/docs/api/release-notes/2023-04
  static const String apiVersion =
      "2024-04"; // take latest version from shofipy website

  // static const String baseUrl = "https://$apiKey:$apiSecretKey@$storeName.myshopify.com/admin/api/$apiVersion/";

  //https://apollohospitals.myshopify.com/admin/api/{{api_version}}/orders.json

  static const String baseUrl =
      "https://apollohospitals.myshopify.com/admin/api/$apiVersion/";
  static const String baseUrl2 =
      "https://$apiKey:$apiSecretKey@$storeName.myshopify.com/admin/";

  static const String filterUrl =
      "https://eaglecrm.solstium.net/api/getApolloProductMetaFields";

  static const String createCustomer = "customers.json";

  // static const String createCustomerAddress = "customers/{{customer_id}}/addresses.json";
  //customers/{{customer_id}}.json
  static const String updateCustomer = "customers/";
  static const String checkCustomerAvailabilityByPhone =
      "customers.json?phone="; // by phone
  static const String checkCustomerAvailabilityByMail =
      "customers.json?email="; // by mail
  static const String checkCustomerAvailabilityById =
      "customers.json/"; // by customer id

  // Firebase
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get user => auth.currentUser!;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 25-03-2023
  static const String allProductsList = "products.json";
  static const String productsListCount = "products/count.json";

  //customers/{{customer_id}}/addresses.json

  static const String createCustomerAddress = "customers/";
  // static const String createCustomerAddress = "customers/";

  //  customers/{{customer_id}}/addresses/{{address_id}}.json

  static const String placeOrder2 = "orders.json";
  static const String placeOrder =
      "https://apollohospitals.myshopify.com/admin/api/$apiVersion/customers/";
  static const String createOrder =
      "https://apollohospitals.myshopify.com/admin/api/$apiVersion/orders.json";

  static const String orderListByCustomerId = "customers/";

  // 17/06/2023
  static const String createCheckout = "checkouts.json";
  static const String createCheckoutNew =
      "http://$storeName.myshopify.com/cart/70881412:1,70881382:1";

  // 17/06/2023
  static const String getDetailsOfStore = "shop.json";

  static const String emailLogin =
      "https://apollohospitals.myshopify.com/api/2023-04/graphql.json";
  // 27/06/2023
  // request OTP
  static const String createOtp =
      "https://eaglecrm.solstium.net/api/createMemberWithOtp";
  // submit OTP
  static const String submitOtp =
      "https://eaglecrm.solstium.net/api/verifyApolloMemberOTP";

  static const String singleProduct = "products/";
  static const String talkToDoctor =
      "https://eaglecrm.solstium.net/api/talktodoctor";

  static const String bookAppointment =
      "https://eaglecrm.solstium.net/api/bookhometest";
}
