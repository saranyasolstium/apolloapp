import 'package:get/get.dart';
import 'package:infinite/control/profile_controller/create_controller.dart';
import 'package:infinite/utils/packeages.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offAll(LoginScreenMail());
          return Future.value(false); 
        },
        child: GetBuilder<CreateProfileController>(
            init: CreateProfileController(),
            builder: (proCtrl) {
              return SafeArea(
                  child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: loading
                    ? Center(
                        child: Lottie.asset(
                          animationLoading,
                          repeat: true,
                          reverse: true,
                          animate: true,
                          width: ScreenSize.getScreenWidth(context) * 0.40,
                          height: ScreenSize.getScreenHeight(context) * 0.40,
                        ),
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () => Get.offAll(LoginScreenMail()),
                                icon: const Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: black,
                                ),
                                color: black,
                              ),
                              SizedBox(
                                width: 0.2.w,
                              ),
                              Text(
                                "Let's create a profile!",
                                style: zzBoldBlackTextStyle14,
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),

                                  Image.asset(
                                    "assets/images/inf_logo_tm.png",
                                   height: 120,
                                  ),
                                  SizedBox(
                                    height: 1.7.h,
                                  ),
                                  Stack(
                                      // alignment: Alignment.topCenter,
                                      children: [
                                        Container(
                                          // height: 640,
                                          //  height: ScreenSize.getScreenHeight(context)*0.80 ,
                                          // width: 90.0.w,
                                          margin: const EdgeInsets.only(
                                              top: 80.0,
                                              bottom: 10.0,
                                              right: 10.0,
                                              left: 10.0),
                                          padding: const EdgeInsets.only(
                                              top: 80.0,
                                              bottom: 10.0,
                                              right: 15.0,
                                              left: 15.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: lightBlue),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              SizedBox(
                                                height: 7.0.h,
                                                child: TextField(
                                                  controller:
                                                      proCtrl.nameController,
                                                  style:
                                                      zzRegularBlackTextStyle11,
                                                  decoration: InputDecoration(
                                                    // contentPadding:
                                                    //     const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    hintText: "First name",
                                                    hintStyle:
                                                        zzRegularGrayTextStyle10,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                height: 7.0.h,
                                                child: TextField(
                                                  controller: proCtrl
                                                      .lastNameController,
                                                  style:
                                                      zzRegularBlackTextStyle11,
                                                  decoration: InputDecoration(
                                                    // contentPadding:
                                                    // const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    hintText: "Last name",
                                                    hintStyle:
                                                        zzRegularGrayTextStyle10,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: grayTxt),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(4)),
                                                    color: Colors.white),
                                                height: 7.0.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CountryCodePicker(
                                                      onChanged: (CountryCode
                                                          countryCode) {
                                                        proCtrl.myCountryCode =
                                                            countryCode
                                                                .toString();
                                                        proCtrl.update();
                                                      },
                                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                      initialSelection: 'IN',
                                                      favorite: const [
                                                        '+91',
                                                        'IN'
                                                      ],
                                                      showCountryOnly: false,
                                                      showFlag: true,
                                                      enabled: false,
                                                      showDropDownButton: false,
                                                    ),
                                                    const VerticalDivider(
                                                      endIndent: 10.0,
                                                      indent: 10.0,
                                                      color: Colors.grey,
                                                      thickness: 1,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        autofocus: false,
                                                        controller: proCtrl
                                                            .phoneController,
                                                        style:
                                                            zzRegularBlackTextStyle11,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        maxLength: 10,
                                                        decoration:
                                                            InputDecoration(
                                                          counter:
                                                              const SizedBox(
                                                                  height: 0.0),
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Enter mobile number',
                                                          hintStyle:
                                                              zzRegularGrayTextStyle10,
                                                          filled: true,
                                                          fillColor: white,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  // ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                height: 7.0.h,
                                                child: TextField(
                                                  controller:
                                                      proCtrl.mailController,
                                                  style:
                                                      zzRegularBlackTextStyle11,
                                                  decoration: InputDecoration(
                                                    //  counter: const SizedBox(height: 0.0),
                                                    // contentPadding:
                                                    //     const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: grayTxt,
                                                          width: 1.0),
                                                    ),
                                                    hintText: "Email address",
                                                    hintStyle:
                                                        zzRegularGrayTextStyle10,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                height: 7.0.h,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        18)
                                                  ],
                                                  controller: proCtrl
                                                      .passwordController,
                                                  focusNode:
                                                      proCtrl.passwordNode,
                                                  // autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  obscureText: !proCtrl
                                                      .passwordVisibility,
                                                  style:
                                                      zzRegularBlackTextStyle11,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  decoration: InputDecoration(
                                                      // contentPadding:
                                                      // const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: grayTxt,
                                                            width: 1.0),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: grayTxt,
                                                            width: 1.0),
                                                      ),
                                                      suffixIcon: IconButton(
                                                          color: Colors.black54,
                                                          icon: proCtrl
                                                              .passwordSuffixIcon,
                                                          onPressed: () {
                                                            proCtrl
                                                                .changeVisibility();
                                                            proCtrl.update();
                                                          }),
                                                      hintText: "Password",
                                                      hintStyle:
                                                          zzRegularGrayTextStyle10),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              AbsorbPointer(
                                                absorbing:
                                                    proCtrl.absorbPointer,
                                                child: SizedBox(
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          context),
                                                  height: 6.0.h,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      String pattern = r'[0-9]';
                                                      RegExp regex =
                                                          RegExp(pattern);
                                                      // return regex.hasMatch(text);

                                                      String pattern2 =
                                                          r'[!@#\$%^&*(),.?":{}|<>]';
                                                      RegExp regex2 =
                                                          RegExp(pattern2);
                                                      //  return regex.hasMatch(text);

                                                      String pattern3 =
                                                          r'[A-Z]';
                                                      RegExp regex3 =
                                                          RegExp(pattern3);

                                                      String pattern4 =
                                                          r'[a-z]';
                                                      RegExp regex4 =
                                                          RegExp(pattern4);

                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      if (proCtrl
                                                          .nameController.text
                                                          .toString()
                                                          .isEmpty) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter your name");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                          .lastNameController
                                                          .text
                                                          .toString()
                                                          .isEmpty) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter last name");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                          .phoneController.text
                                                          .toString()
                                                          .isEmpty) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter mobile number");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                              .phoneController
                                                              .text
                                                              .length !=
                                                          10) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter 10 digit mobile number");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                          .mailController.text
                                                          .toString()
                                                          .isEmpty) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter email address");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (!(myMailRegex
                                                          .hasMatch(proCtrl
                                                              .mailController
                                                              .text
                                                              .toString()))) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            'Please enter valid email address');
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                          .passwordController
                                                          .text
                                                          .toString()
                                                          .isEmpty) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Please enter password");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (proCtrl
                                                              .passwordController
                                                              .text
                                                              .length <
                                                          8) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Password should have minimum 8 characters");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (!regex3.hasMatch(
                                                          proCtrl.passwordController.text)) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Password should have uppercase");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (!regex4.hasMatch(proCtrl.passwordController.text)) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Password should have lowercase");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (!regex.hasMatch(proCtrl.passwordController.text)) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Password should have numeric value");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else if (!regex2.hasMatch(proCtrl.passwordController.text)) {
                                                        proCtrl.absorbPointer =
                                                            true;
                                                        showErrorSnackBar(
                                                            context,
                                                            "Password should have special character");
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          proCtrl.absorbPointer =
                                                              false;
                                                        });
                                                      } else {
                                                        proCtrl
                                                            .checkIfCustomerExistByMobileNumber(
                                                                context);
                                                      }
                                                      proCtrl.update();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                loginTextColor),
                                                    child: Text(
                                                      "Proceed",
                                                      style:
                                                          zzBoldWhiteTextStyle14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          // top: 30,
                                          top: 15,
                                          // bottom: 216,
                                          // left: 35.0.w,
                                          left:
                                              MediaQuery.sizeOf(context).width /
                                                  3.2,
                                          //bottom: 80.0.h,
                                          // bottom: ScreenSize.getScreenHeight(context) * 1.02,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 66,
                                                  child: proCtrl.imageXFile1 !=
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 65,
                                                          backgroundImage:
                                                              FileImage(File(proCtrl
                                                                  .uploadProfileImg1)),
                                                          backgroundColor:
                                                              Colors.white,
                                                          // child: SvgPicture.asset('assets/svg/profile_img2.svg',width: 60,height: 60,fit: BoxFit.fill,),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 65,
                                                          // backgroundImage: FileImage(File(uploadProfileImg)),
                                                          backgroundColor:
                                                              Colors.white,
                                                          child:
                                                              SvgPicture.asset(
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
                                                    backgroundColor:
                                                        loginTextColor,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        //  getFromGallery();
                                                        proCtrl.showAlertDialog(
                                                            context);
                                                        proCtrl.update();
                                                      },
                                                      icon: SvgPicture.asset(
                                                        "assets/svg/camera_icon.svg",
                                                        color: white,
                                                        height: 20.0,
                                                        width: 20.0,
                                                        allowDrawingOutsideViewBox:
                                                            true,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ));
            }));
  }
}
