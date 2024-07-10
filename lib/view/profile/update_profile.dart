import 'package:get/get.dart';
import 'package:infinite/control/profile_controller/update_controller.dart';
import 'package:infinite/utils/packeages.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileUpdateController>(
        init: ProfileUpdateController(),
        builder: (proUpCtrl) {
          return DefaultAppBarWidget(
              title: "Edit Profile",
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Stack(alignment: Alignment.topCenter, children: [
                  Center(
                    child: Container(
                      height: 420,
                      margin: const EdgeInsets.only(
                          top: 80.0, bottom: 20.0, right: 20.0, left: 20.0),
                      padding: const EdgeInsets.only(
                          top: 80.0, bottom: 20.0, right: 20.0, left: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightBlue),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: proUpCtrl.nameController,
                              style: zzRegularBlackTextStyle13,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                                // hintText: "Your Name",
                                // hintStyle: zzRegularGrayTextStyle12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 78.0.w,
                            height: 50,
                            // padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(3.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffDDDDDD),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CountryCodePicker(
                                      onChanged: (CountryCode countryCode) {
                                        debugPrint(
                                            "New Country selected: $countryCode");
                                        proUpCtrl.myCountryCode =
                                            countryCode.toString();
                                        proUpCtrl.update();
                                      },
                                      initialSelection: 'IN',
                                      favorite: const ['+91', 'IN'],
                                      showCountryOnly: false,
                                      showFlag: true,
                                      enabled: false,
                                      showDropDownButton: false,
                                    ),
                                  ),
                                  const VerticalDivider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      controller: proUpCtrl.phoneController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      autofocus: false,
                                      enabled: false,
                                      style: zzRegularBlackTextStyle13,
                                      decoration: InputDecoration(
                                        counter: const SizedBox(height: 0.0),
                                        border: InputBorder.none,
                                        hintStyle: zzRegularGrayTextStyle12,
                                        hintText: 'Enter mobile number',
                                        filled: true,
                                        fillColor: white,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        // focusedBorder: OutlineInputBorder(
                                        //   borderSide: const BorderSide(color: Colors.grey),
                                        //   borderRadius: BorderRadius.circular(7.0),
                                        // ),
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderSide: const BorderSide(color: Colors.grey),
                                        //   borderRadius: BorderRadius.circular(7.0),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: proUpCtrl.mailController,
                              style: zzRegularBlackTextStyle13,
                              enabled: false,
                              decoration: InputDecoration(
                                counter: const SizedBox(height: 0.0),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                                hintText: "Email Address",
                                hintStyle: zzRegularGrayTextStyle12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (proUpCtrl.nameController.text
                                    .toString()
                                    .isEmpty) {
                                  showErrorSnackBar(
                                      context, "Please enter your name");
                                } else {
                                  Map<String, dynamic> data =
                                      <String, dynamic>{};
                                  Map<String, dynamic> aCustomerMap =
                                      <String, dynamic>{};
                                  XFile? imageFile;
                                  data['first_name'] =
                                      proUpCtrl.nameController.text.toString();
                                  data['email'] =
                                      proUpCtrl.mailController.text.toString();
                                  data['phone'] =
                                      "${proUpCtrl.myCountryCode}${proUpCtrl.phoneController.text.toString()}";
                                 
                                  aCustomerMap['customer'] = data;
                                  setState(() => loading = true);
                                  proUpCtrl.updateProfile(
                                      aCustomerMap, context);
                                }
                                proUpCtrl.update();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: loginTextColor),
                              child: Text(
                                "Submit",
                                style: zzBoldWhiteTextStyle14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 370,
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 66,
                            child: proUpCtrl.imageXFile2 != null
                                ? CircleAvatar(
                                    radius: 65,
                                    backgroundImage: FileImage(
                                        File(proUpCtrl.uploadProfileImg)),
                                    backgroundColor: Colors.white,
                                  )
                                : CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/svg/profile_img2.svg',
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                        Positioned(
                            top: 8,
                            right: 6,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: loginTextColor,
                              child: IconButton(
                                onPressed: () {
                                  proUpCtrl.showAlertDialog(context);
                                  proUpCtrl.update();
                                },
                                icon: SvgPicture.asset(
                                  "assets/svg/camera_icon.svg",
                                  color: white,
                                  height: 20.0,
                                  width: 20.0,
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                ]),
              ));
        });
  }
}
