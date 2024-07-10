import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/packeages.dart';

class LoginController extends GetxController {
  String myCountryCode = "+91";
  TextEditingController myMobileController = TextEditingController();
  TextEditingController myPswdController = TextEditingController();
  bool absorbPointer = false;
  bool isAuthorizeds = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String contactText = '';
  GoogleSignInAccount? currentUser;
  bool passwordVisibilit = false;
  Icon passwordIcon = const Icon(Icons.visibility_off);
  String aName = '', aId = '';
  String aMail = '', aProfile = '', aPass = '';

  void changeVisibility() {
    passwordVisibilit = !passwordVisibilit;
    passwordIcon =
        Icon(passwordVisibilit ? Icons.visibility : Icons.visibility_off);
    update();
  }

  @override
  void onInit() {
    googleSignIn.signInSilently();
    myCountryCode = "+91";
    super.onInit();
  }

  Future<void> goToGoogleSignIn(BuildContext context) async {
    try {
      await googleSignIn.signOut();
      googleSignIn.signIn().then((userData) {
        if (userData != null) {
          debugPrint("LOGIN SCREEN: $userData");
          aName = userData.displayName.toString();
          aMail = userData.email.toString();
          aProfile = userData.photoUrl.toString();
          aId = userData.id.toString();
          aPass = '${aName.substring(0, 5)}@1234';
          DioClient(myUrl: "${EndPoints.checkCustomerAvailabilityByMail}$aMail")
              .getDetails()
              .then((value) {
            loading = false;
            update();
            debugPrint("GMAIL RESPONSE EMAIL PAGE: $value");
            if (value.statusCode == 200) {
              if ((value.data['customers'] as List).isNotEmpty) {
                var aCustomerMap = value.data['customers'][0];
                int aId = aCustomerMap['id'];
                String aMail = aCustomerMap['email'] ?? '';
                String aFirstName = aCustomerMap['first_name'];
                String aLastName = aCustomerMap['last_name'] ?? '';
                String aMobile = aCustomerMap['phone'] ?? '';
                sharedPreferences!.setInt("id", aId);
                sharedPreferences!.setString("mail", aMail);
                sharedPreferences!.setString("firstName", aFirstName);
                sharedPreferences!.setString("lastName", aLastName);
                sharedPreferences!.setString("mobileNumber", aMobile);
                Get.offAll(() => const HomeScreen(index: 0));
              } else {
                // debugPrint('SHOW THE LOGIN:::::1');
                sharedPreferences!.clear();
                // googleSignIn.signOut();
                loading = false;
                update();
                addFieldsToMakeOTP(context);
              }
            } else {
              debugPrint('SHOW THE LOGIN:::::2');
              sharedPreferences!.clear();
              googleSignIn.signOut();
              loading = false;
              update();
              Get.to(() => CreateProfile(), arguments: [
                {"name": aName, "email": aMail, "fromwhere": "google_mail"}
              ]);
            }
          });
        } else {
          sharedPreferences!.clear();
          googleSignIn.signOut();
          //loading = false;
          loading = false;
          update();
          showErrorSnackBar(context, "Try again later");
        }
        update();
      }).catchError((e) {
        debugPrint('$e');
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void addFieldsToMakeOTP(BuildContext context) {
    try {
      loading = true;
      update();
      Map<String, dynamic> data = <String, dynamic>{};
      Map<String, dynamic> aCustomerMap = <String, dynamic>{};
      data['first_name'] = aName;
      data['last_name'] = '';
      data['email'] = aMail;
      data['password'] = aPass;
      data['password_confirmation'] = aPass;
      data['phone'] = "";
      aCustomerMap['customer'] = data;
      addProfile(aCustomerMap, context);
    } catch (e) {
      debugPrint("$e");
    }
  }

  // ADD PROFILE
  void addProfile(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(myUrl: EndPoints.createCustomer, myMap: data)
          .post()
          .then((value) {
        loading = false;
        update();
        if (value.statusCode == 201) {
          showSuccessSnackBar(
              context, "Your profile has been successfully created");
          var aCustomerMap = value.data['customer'];
          int aId = aCustomerMap['id'];
          String aMail = aCustomerMap['email'] ?? '';
          String aFirstName = aCustomerMap['first_name'];
          String aLastName = aCustomerMap['last_name'] ?? '';
          String aMobile = aCustomerMap['phone'] ?? '';
          String aPassword = aCustomerMap['password'] ?? '';

          sharedPreferences!.setInt("id", aId);
          sharedPreferences!.setString("mail", aMail);
          sharedPreferences!.setString("firstName", aFirstName);
          sharedPreferences!.setString("lastName", aLastName);
          sharedPreferences!.setString("mobileNumber", aMobile);
          sharedPreferences!.setString("password", aPassword);
          // Get.offAll(() => HomeScreen());

          showAlertDialog(context);
        } else {
          if (value.data['errors'] != null) {
            Map<String, dynamic> aErrMap = value.data['errors'];
            if (aErrMap.containsKey('email')) {
              String aErrMsg = aErrMap['email'].cast<String>()[0];
              showErrorSnackBar(context, "This mail id has already been taken");
              showErrorSnackBar(context, aErrMsg);
            } else if (aErrMap.containsKey('phone')) {
              String aErrMsg = aErrMap['phone'].cast<String>()[0];
              showErrorSnackBar(context, aErrMsg);
              showErrorSnackBar(
                  context, "This mobile number has already been taken");
            }
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign-In Success'),
            actions: <Widget>[
              const Divider(
                thickness: 2,
                color: lightBlue3,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      'Please notes your username is $aMail and password is $aPass, Don`t forgot.'),
                  SizedBox(height: 2.h),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        Get.offAll(() => const HomeScreen(index: 0));
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        update();
                      }),
                      child: Text('Go to Home',
                          style: zzRegularBlackTextStyle14A)),
                ],
              )
            ],
          );
        });
  }

  void checkValidation(BuildContext context) {
    /// TO CREATE A CUSTOMER PROFILE
    FocusScope.of(context).unfocus();
    String aMobile = myMobileController.text.toString();
    String aPswd = myPswdController.text.toString();
    if (aMobile.isEmpty) {
      absorbPointer = true;
      showErrorSnackBar(context, "Please enter mobile number");
      Future.delayed(const Duration(seconds: 2), () {
        absorbPointer = false;
      });
    } else if (aMobile.isNotEmpty) {
      if (aMobile.length != 10) {
        absorbPointer = true;
        showErrorSnackBar(context, "Please enter 10 digit number");
        Future.delayed(const Duration(seconds: 2), () {
          absorbPointer = false;
        });
      } else if (aPswd.isEmpty) {
        absorbPointer = true;
        showErrorSnackBar(context, "Please enter password");
        Future.delayed(const Duration(seconds: 2), () {
          absorbPointer = false;
        });
      } else {
        loading = true;

        /// FOR CHECK IF THE CUSTOMER IS ALREADY REGISTERS OR NOT
        debugPrint("MY COUNTRY CODE :: $myCountryCode");
        DioClient(
                myUrl:
                    "${EndPoints.checkCustomerAvailabilityByPhone}$myCountryCode$aMobile&password=$aPswd")
            .getDetails()
            .then((value) {
          loading = false;
          debugPrint("SHOW LOGIN PAGE RESPONSE: $value");
          if (value.statusCode == 200) {
            if ((value.data['customers'] as List).isNotEmpty) {
              var aCustomerMap = value.data['customers'][0];
              int aId = aCustomerMap['id'];
              String aMail = aCustomerMap['email'] ?? '';
              String aFirstName = aCustomerMap['first_name'];
              String aLastName = aCustomerMap['last_name'] ?? '';
              String aMobile = aCustomerMap['phone'] ?? '';
              sharedPreferences!.setInt("id", aId);
              sharedPreferences!.setString("mail", aMail);
              sharedPreferences!.setString("firstName", aFirstName);
              sharedPreferences!.setString("lastName", aLastName);
              sharedPreferences!.setString("mobileNumber", aMobile);
              Get.offAll(() => const HomeScreen(index: 0));
            } else {
              loading = false;
              Get.to(() => CreateProfile(), arguments: [
                {"name": "", "email": aMobile, "fromwhere": "mobile"}
              ]);
            }
          } else {
            loading = false;
            Get.to(() => CreateProfile(), arguments: [
              {"name": "", "email": aMobile, "fromwhere": "mobile"}
            ]);
          }
        });
      }
    } else if (aPswd.isEmpty) {
      absorbPointer = true;
      showErrorSnackBar(context, "Please enter password");
      Future.delayed(const Duration(seconds: 2), () {
        absorbPointer = false;
      });
    } else {
      loading = true;

      /// FOR CHECK IF THE CUSTOMER IS ALREADY REGISTERS OR NOT
      debugPrint("MY COUNTRY CODE :: $myCountryCode");
      DioClient(
              myUrl:
                  "${EndPoints.checkCustomerAvailabilityByPhone}$myCountryCode$aMobile&password=$aPswd")
          .getDetails()
          .then((value) {
        loading = false;
        debugPrint("SHOW LOGIN PAGE RESPONSE: $value");
        if (value.statusCode == 200) {
          if ((value.data['customers'] as List).isNotEmpty) {
            var aCustomerMap = value.data['customers'][0];
            int aId = aCustomerMap['id'];
            String aMail = aCustomerMap['email'] ?? '';
            String aFirstName = aCustomerMap['first_name'];
            String aLastName = aCustomerMap['last_name'] ?? '';
            String aMobile = aCustomerMap['phone'] ?? '';
            sharedPreferences!.setInt("id", aId);
            sharedPreferences!.setString("mail", aMail);
            sharedPreferences!.setString("firstName", aFirstName);
            sharedPreferences!.setString("lastName", aLastName);
            sharedPreferences!.setString("mobileNumber", aMobile);
            Get.offAll(() => const HomeScreen(index: 0));
          } else {
            loading = false;
            Get.to(() => CreateProfile(), arguments: [
              {"name": "", "email": aMobile, "fromwhere": "mobile"}
            ]);
          }
        } else {
          loading = false;
          Get.to(() => CreateProfile(), arguments: [
            {"name": "", "email": aMobile, "fromwhere": "mobile"}
          ]);
        }
      });
    }
  }

  Future<void> performGraphQLPost(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String aMobile = myMobileController.text.toString();
    String aPassword = myPswdController.text.toString();
    if (aMobile.isEmpty) {
      absorbPointer = true;
      showErrorSnackBar(context, "Please enter email address");
      Future.delayed(const Duration(seconds: 2), () {
        absorbPointer = false;
      });
    }
    else if (aPassword.isEmpty) {
      absorbPointer = true;
      showErrorSnackBar(context, "Please enter password");
      Future.delayed(const Duration(seconds: 2), () {
        absorbPointer = false;
      });
    } else {
      const String url =
          'https://apollohospitals.myshopify.com/api/2023-04/graphql.json'; // Replace with your GraphQL endpoint
      debugPrint('URL :: $url');

      final Map<String, dynamic> requestBody = {
        'query': '''
        mutation {
          customerAccessTokenCreate(input: {email: "$aMobile", password: "$aPassword"}) { 
            customerAccessToken {
              accessToken
              expiresAt
            }
            customerUserErrors {
              code
              field
              message
            }
          }
        }
      ''',
      };

      try {
        final http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'X-Shopify-Storefront-Access-Token':
                'e44583241c0b66f362b767ec913c07e9',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          debugPrint('RESPONSE BODY ::$responseData');
          if (responseData.containsKey('data')) {
            final accessToken = responseData['data']
                ['customerAccessTokenCreate']['customerAccessToken'];
            debugPrint('Access Token Mail: $accessToken');

            if (accessToken == null) {
              // showErrorSnackBar(context, 'Invalid email or password');
              // showErrorSnackBar(context, 'Invalid password');
            } else {
              debugPrint('Login successful');
              checkIfCustomerExistsByMail(context, aMobile);
            }
          }
        }
      } catch (error) {
        debugPrint('Exception: $error');
      }
    }
  }

  void checkIfCustomerExistsByMail(BuildContext context, String aEmail) {
    try {
      DioClient(myUrl: "${EndPoints.checkCustomerAvailabilityByPhone}$aEmail")
          .getDetails()
          .then((value) {
        loading = false;
        debugPrint("SHOW CUSTOMER EXISTS CHECK STATUS EMAIL: $value");
        if (value.statusCode == 200) {
          if ((value.data['customers'] as List).isNotEmpty) {
            // ACCOUNT EXITS
            var aCustomerMap = value.data['customers'][0];
            int aId = aCustomerMap['id'];
            String aMail = aCustomerMap['email'] ?? '';
            String aFirstName = aCustomerMap['first_name'];
            String aLastName = aCustomerMap['last_name'] ?? '';
            String aMobile = aCustomerMap['phone'] ?? '';
            sharedPreferences!.setInt("id", aId);
            sharedPreferences!.setString("mail", aMail);
            sharedPreferences!.setString("firstName", aFirstName);
            sharedPreferences!.setString("lastName", aLastName);
            sharedPreferences!.setString("mobileNumber", aMobile);
            showSuccessSnackBar(context, 'Login successfully');
            Get.offAll(() => const HomeScreen(index: 0));
          }
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }
}
