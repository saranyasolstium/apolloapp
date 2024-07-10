import 'package:get/get.dart';

import '../../utils/packeages.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String myCountryCode = "+91";
  String uploadProfileImg = '';
  String aName = "", aMobile = "", aMail = "";
  int aId = 0;

  @override
  void onInit() {
    aMail = sharedPreferences!.getString("mail").toString();
    aName = sharedPreferences!.getString("firstName").toString();
    aMobile = sharedPreferences!.getString("mobileNumber").toString();
    aId = sharedPreferences!.getInt("id")!.toInt();
    debugPrint("UPDATE ID: $aId");
    debugPrint("PHONE NO: $aMobile");
    nameController.text = aName.toString();
    mailController.text = aMail.toString();
    phoneController.text = aMobile.toString().replaceAll("+91", "");
    super.onInit();
  }

  /// Upload Shop Proof
  XFile? imageXFile2;
  final ImagePicker _picker2 = ImagePicker();

  Future<void> _getImage2(int i) async {
    try {
      if (i == 0) {
        var status = await Permission.camera.status;
        if (!status.isGranted) {
          await Permission.camera.request();
        } else {
          if (await Permission.camera.request().isGranted) {
            imageXFile2 = (await _picker2.pickImage(
                source: ImageSource.camera, maxWidth: 600))!;
            uploadProfileImg = imageXFile2!.path;
           // _uploadImageToShopify(aId, uploadProfileImg);

            update();
          }
        }
      } else if (i == 1) {
        try {
          var status = await Permission.storage.status;
          if (status.isPermanentlyDenied) {
            openAppSettings();
          } else if (status.isDenied) {
            openAppSettings();
          } else if (status.isGranted) {
            if (i == 1) {
              imageXFile2 =
                  (await _picker2.pickImage(source: ImageSource.gallery))!;
              uploadProfileImg = imageXFile2!.path;
             // _uploadImageToShopify(aId, uploadProfileImg);
              update();
            }
          } else {
            await Permission.storage.request();
          }
        } catch (e) {
          debugPrint('$e');
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  // Future<void> _uploadImageToShopify(int customerId, String imagePath) async {
  //   List<int> imageBytes = await File(imagePath).readAsBytes();
  //   String base64Image = base64Encode(imageBytes);

  //   // Prepare the request payload
  //  Map<String, dynamic> payload = {
  //   "metafield": {
  //     "namespace": "customer",
  //     "key": "profile_image",
  //     "value": base64Image,
  //     "value_type": "string",
  //     "owner_id": customerId.toString(),
  //     "owner_resource": "customer"
  //   }
  // };


  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'X-Shopify-Access-Token': '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',
  //   };

  //   String apiUrl =
  //       'https://apollohospitals.myshopify.com/admin/api/2024-04/metafields.json';

  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: headers,
  //     body: jsonEncode(payload),
  //   );
  //   print('saranya');

  //   print(response.body);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print(response.statusCode);
  //     print('Image uploaded successfully');
  //   } else {
  //     print('Image upload failed: ${response.body}');
  //   }
  // }

  Future<void> updateProfile(
      Map<String, dynamic> data, BuildContext context) async {
    try {
      // List<int> imageBytes = await File(uploadProfileImg).readAsBytes();
      // String base64Image = base64Encode(imageBytes);
      // data['customer']['profile_image'] = base64Image;

      // print(data);
      DioClient(myUrl: "${EndPoints.updateCustomer}$aId.json", myMap: data)
          .update()
          .then((value) {
        loading = false;
        if (value.statusCode == 201 || value.statusCode == 200) {
          showSuccessSnackBar(
              context, "Your profile has been successfully created");
          var aCustomerMap = value.data['customer'];
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
          // Get.off(() => const HomeScreen(index: 1));
        } else {
          if (value.data['errors'] != null) {
            Map<String, dynamic> aErrMap = value.data['errors'];
            if (aErrMap.containsKey('email')) {
              String aErrMsg = aErrMap['email'].cast<String>()[0];
              showErrorSnackBar(context, "This mail id has already been taken");
            } else if (aErrMap.containsKey('phone')) {
              String aErrMsg = aErrMap['phone'].cast<String>()[0];
              showErrorSnackBar(
                  context, "This mobile number has already been taken");
            }
          }
          debugPrint('ERROR STATUS CODE  ${value.statusCode}');
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select anyone'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        Navigator.pop(context);
                        _getImage2(0);
                        update();
                      }),
                      child: Text('Camera', style: zzRegularBlackTextStyle14A)),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        Navigator.pop(context);
                        _getImage2(1);
                        update();
                      }),
                      child:
                          Text('Gallery', style: zzRegularBlackTextStyle14A)),
                ],
              )
            ],
          );
        });
  }
}
