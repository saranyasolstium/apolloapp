import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

const String animationLoading = 'assets/animation/loading.json';
const openSansRegular = "Open-Sans-Regular";
const openSansBold = "Open-Sans-Bold";
const openSansSemiBold = "Open-Sans-SemiBold";

final zzRegularGreenTextStyle14 = GoogleFonts.lato(
  color: colorPrimary,
  fontSize: 14.0.sp,

);

final zzRegularWhiteTextStyle14 = GoogleFonts.lato(
  color: white,
  fontSize: 14.0.sp,
);

final zzRegularWhiteTextStyle12 = GoogleFonts.lato(
  color: white,
  fontSize: 12.0.sp,
);

final zzRegularBlackTextStyle14 = GoogleFonts.lato(
  color: black,
  fontSize: 14.0.sp,
);

final zzRegularBlackTextStyle14A = GoogleFonts.lato(
  color: white,
  fontWeight: FontWeight.bold,
  background: Paint()..color = loginTextColor
    ..strokeWidth = 17,
  fontSize: 14.0.sp,
);



final zzRegularWhiteAppBarTextStyle14 = GoogleFonts.lato(
  color: white,
  fontWeight: FontWeight.bold,
  fontSize: 14.0.sp,
);

final zzRegularBlackTextStyle13 = GoogleFonts.lato(
  color: black,
  fontSize: 13.0.sp,
);
final zzRegularBlackTextStyle13B = GoogleFonts.lato(
  color: black,
  fontSize: 12.0.sp,
);
final zzRegularBlackTextStyle13A = GoogleFonts.lato(
    color: black, fontSize: 14.0.sp, fontWeight: FontWeight.bold);

final zzBoldBlackTextStyle14 = GoogleFonts.lato(
  color: black,
  fontSize: 14.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldWhiteTextStyle14 = GoogleFonts.lato(
  color: white,
  fontSize: 14.0.sp,
  fontWeight: FontWeight.bold,
);
final zzBoldWhiteTextStyle15 = GoogleFonts.lato(
  color: white,
  fontSize: 15.0.sp,
  fontWeight: FontWeight.bold,
);
final zzBoldWhiteTextStyle14B = GoogleFonts.lato(
  color: black,
  fontSize: 15.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldWhiteTextStyle14A = GoogleFonts.lato(
  color: white,
  fontSize: 14.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldWhiteTextStyle19 = GoogleFonts.lato(
  color: white,
  fontSize: 9.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldBlackTextStyle12 = GoogleFonts.lato(
  color: black,
  fontSize: 12.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldBlackTextStyle13 = GoogleFonts.lato(
  fontSize: 13.0.sp,
  color: black,
);

final zzBoldBlackTextStyle13A = GoogleFonts.lato(
  color: black,
  fontSize: 14.0.sp,
  fontWeight: FontWeight.bold,
);

final zzBoldBlackTextStyle16 = GoogleFonts.lato(
  color: black,
  fontSize: 16.0.sp,
  fontWeight: FontWeight.bold,
);
final zzBlackTextStyle16 = GoogleFonts.lato(
  color: black,
  fontSize: 16.0.sp,
);

final zzRegularGrayTextStyle12 = GoogleFonts.lato(
  color: gray,
  fontSize: 12.0.sp,
);
final zzRegularGrayTextStyle12A = GoogleFonts.lato(
  color: gray,
  fontSize: 11.0.sp,
);

final zzBoldBlueDarkTextStyle10 = GoogleFonts.lato(
  color: loginTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 10.0.sp,
);
final zzBoldBlueDarkTextStyle10A = GoogleFonts.lato(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 12.0.sp,

);
final zzBoldBlueDarkTextStyle10A1 = GoogleFonts.lato(
  color: Colors.white,
  fontWeight: FontWeight.normal,
  fontSize: 12.0.sp,
);
final zzBoldBlueDarkTextStyle10B = GoogleFonts.lato(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 12.0.sp,

);

final zzBoldBlueDarkTextStyle14 = GoogleFonts.lato(
  color: loginTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 14.0.sp,
);

final zzBoldGrayTextStyle14 = GoogleFonts.lato(
  color: gray,
  fontWeight: FontWeight.bold,
  fontSize: 14.0.sp,
);

final zzBoldBlackTextStyle10 = GoogleFonts.lato(
  color: black,
  fontWeight: FontWeight.bold,
  fontSize: 10.0.sp,
);

final zzBoldGrayDarkStrikeTextStyle10 = GoogleFonts.lato(
  color: gray,
  decoration: TextDecoration.lineThrough,
  decorationThickness: 2,
  fontWeight: FontWeight.bold,
  fontSize: 10.0.sp,
);
final zzRegularBlackTextStyle12 = GoogleFonts.lato(
  color: black,
  fontSize: 12.0.sp,
);

final zzRegularGreenTextStyle12 = GoogleFonts.lato(
  color: green1,
  fontSize: 12.0.sp,
);

final zzRegularBlackTextStyle9 = GoogleFonts.lato(
  color: black,
  fontSize: 9.0.sp,
);
final zzRegularBlackTextStyle10A = GoogleFonts.lato(
  color: black,
  fontSize: 10.0.sp,
);


final zzRegularBlackTextStyle11 = GoogleFonts.lato(
  color: black,
  fontSize: 11.0.sp,
);

final zzBoldBlackTextStyle9 = GoogleFonts.lato(
  color: black,
  fontSize: 9.0.sp,
  fontWeight: FontWeight.bold,
);

final zzRegularGrayTextStyle10 = GoogleFonts.lato(
  color: gray,
  fontSize: 10.0.sp,
);

final zzRegularGrayTextStyle8 = GoogleFonts.lato(
  color: gray,
  fontSize: 8.0.sp,
);

final zzRegularBlackTextStyle8 = GoogleFonts.lato(
  color: black,
  fontSize: 8.0.sp,
);
final zzRegularBlackTextStyle10 = GoogleFonts.lato(
  color: black3,
  fontSize: 10.0.sp,
);

final zzRegularBlueTextStyle13 = GoogleFonts.lato(
  color: loginTextColor,
  fontSize: 13.0.sp,
  fontWeight: FontWeight.bold
);

fontMethod(BuildContext context){
  return GoogleFonts.lato(
      color: black3,
      fontSize: MediaQuery.of(context).size.height * 0.02);
}

fontMethodRed(BuildContext context){
  return GoogleFonts.lato(
      color: Colors.red,
      fontSize: MediaQuery.of(context).size.height * 0.02);
}

fontMethod2(BuildContext context){
  return GoogleFonts.lato(
      color: grayTxt,
      fontSize: MediaQuery.of(context).size.height * 0.02,
      decoration: TextDecoration.lineThrough,
      decorationColor: grayTxt,
      decorationStyle: TextDecorationStyle.solid,
      fontWeight: FontWeight.bold);
}

fontBoldMethod(BuildContext context){
  return GoogleFonts.lato(
  fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.height * 0.02);
}
imgFontMethod(BuildContext context){
  return MediaQuery.of(context).size.height * 0.13;
}
imgFontMethod2(BuildContext context){
  return MediaQuery.of(context).size.height * 0.07;
}

final zzRegularBlackTextStyle10_ = GoogleFonts.lato(
  color: grayTxt,
  fontSize: 10.0.sp,
  decoration: TextDecoration.lineThrough,
  decorationColor: grayTxt,
  decorationStyle: TextDecorationStyle.solid,
  fontWeight: FontWeight.bold,
);

final zzRegularBlackTextStyle15 = GoogleFonts.lato(
  color: black3,
  fontSize: 15.0.sp,
);

final zzRegularBlackTextStyle15A = GoogleFonts.lato(
  color: black3,
  fontSize: 13.0.sp,
);
final zzRegularBlackTextStyle15B = GoogleFonts.lato(
  color: black3,
  fontSize: 12.0.sp,
);


final zzBoldBlackTextStyle11 = GoogleFonts.lato(
  color: black2,
  fontWeight: FontWeight.bold,
  fontSize: 11.0.sp,
);
