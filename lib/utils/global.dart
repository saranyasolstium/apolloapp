import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:infinite/utils/packeages.dart';

SharedPreferences? sharedPreferences;
DBHelper2? localDBHelper;
DateFormat myDefaultDateFormat = DateFormat('dd-MM-yyyy');
DateFormat myDefaultDateFormatTwo = DateFormat('dd MMM yyyy');
DateFormat myDefaultDateFormatOne = DateFormat('yyyy-MM-dd');
DateFormat myDefaultDateFormatForBooking = DateFormat('dd MMMM yyyy (EEEE)');
DateFormat myDefaultDateFormatHome = DateFormat('MMMM dd, yyyy AT h:mm a');
DateFormat myDefaultTimeFormat = DateFormat("h:mm a");
DateFormat myDefaultTimeFormatForOrder = DateFormat("yyyy-MM-ddTh:mm:ss+05:30");
DateFormat myDefaultTimeFormatForOrderTwo = DateFormat("dd MMMM yyyy");
String myDefaultLandLineNumber = "18605002632";
String myDefaultMail = "services@my6senses.com";

bool loading = false;

const List<String> scopes = <String>[
  'email',
];
GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: scopes,
);

// final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

// final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
// GlobalKey<RefreshIndicatorState>();

RegExp myPasswordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
RegExp myMobileRegex = RegExp(r'^(?:[6-9])?[0-9]{10}$');
RegExp myMailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

/// SHOW DATE PICKER DIALOG
Future<DateTime?> showDatePickerDialog(
    BuildContext context, DateTime selectedDate, String? title) async {
  try {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: selectedDate,
        firstDate: title == 'past' ? DateTime(1900) : DateTime.now(),
        lastDate: title == 'future' ? DateTime(2500) : DateTime.now(),
        builder: (BuildContext buildContext, Widget? child) {
          return Theme(
            data: ThemeData(
              splashColor: Colors.green.shade100,
              colorScheme: const ColorScheme.light(
                  // change the border color
                  primary: colorPrimary,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  // change the text color
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (picked != null) {
      return picked;
    }
    return null;
  } catch (e) {
    debugPrint('$e');
  }
}

/// SHOW TIME PICKER DIALOG
Future<TimeOfDay?> showTimePickerDialog(
    BuildContext context, TimeOfDay dayTime) async {
  try {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: dayTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked != null) {
      return picked;
    }
    return null;
  } catch (e) {
    debugPrint('$e');
  }
}

/// SHOW SNACKBAR DIALOG
void showSuccessSnackBar(BuildContext context, String message) {
  try {
    final snackDemo = SnackBar(
      content: Text(
        message,
        style: zzRegularWhiteTextStyle14,
      ),
      backgroundColor: colorPrimary,
      elevation: 10,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      action: SnackBarAction(
        label: dismiss,
        textColor: white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
  } catch (e) {
    debugPrint('$e');
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  try {
    final snackDemo = SnackBar(
      content: Text(
        message,
        style: zzRegularWhiteTextStyle14,
      ),
      backgroundColor: Colors.red,
      elevation: 10,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      action: SnackBarAction(
        label: dismiss,
        textColor: white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
  } catch (e) {
    debugPrint("$e");
  }
}

/// METHOD FOR MAKING A CALL
void makeCallOrSendMessage(
    String title, String? customerNumber, String aContent) async {
  try {
    if (title == 'msg') {
      debugPrint('SHOW SEND SMS TEMPLATE: $aContent');
      final Uri smsLaunchUri = Uri(
        scheme: 'sms',
        path: '+91$customerNumber',
        queryParameters: <String, String>{
          'body': aContent,
        },
      );
      await launchUrl(smsLaunchUri);
    } else if (title == "mail") {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: customerNumber,
        query: encodeQueryParameters(<String, String>{
          'subject': 'Example Subject & Symbols are allowed!',
        }),
      );

      launchUrl(emailLaunchUri);
    } else {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: '$customerNumber',
      );
      await launchUrl(launchUri);
    }
  } catch (e) {
    debugPrint('$e');
  }
}

Widget buildReadOnlyRatingBar(double initialRating) {
  return RatingBar.readOnly(
    filledIcon: Icons.star,
    isHalfAllowed: true,
    halfFilledIcon: Icons.star_half,
    emptyIcon: Icons.star_border,
    initialRating: initialRating,
    size: 18,
  );
}


String? encodeQueryParameters(Map<String, String> params) {
  try {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  } catch (e) {
    debugPrint('$e');
  }
}

void sendMessageToWhatsApp(
    String mobile, BuildContext context, String aContent) async {
  try {
    debugPrint('SHOW WHATSAPP TEMPLATE: $aContent MOBILE NUMBER: +91$mobile');
    var whatsappUrl =
        "whatsapp://send?phone=+91$mobile&text=${Uri.encodeComponent(aContent)}";
    // var whatsappUrl = "https://wa.me/$mobile?text=$aContent";
    try {
      launch(whatsappUrl);
    } catch (e) {
      //To handle error and display error message
      showErrorSnackBar(context, 'Whatsapp Not Installed in the Device');
    }
  } catch (e) {
    debugPrint('$e');
  }
}

Color getColorFromStringValue(String name) {
  if (name == 'red') {
    return Colors.red;
  } else if (name == "black") {
    return Colors.black;
  } else if (name == "white") {
    return Colors.white;
  } else if (name == "blue") {
    return Colors.blue;
  } else if (name == "pink") {
    return Colors.pink;
  } else if (name == "yellow") {
    return Colors.yellow;
  } else if (name == "brown") {
    return Colors.brown;
  } else if (name == "green") {
    return Colors.green;
  } else if (name == "beige") {
    return const Color(0xFFf5f5dc);
  } else if (name == "grey") {
    return Colors.grey;
  } else {
    return Colors.black;
  }
}

void handleFreshchatNotification(Map<String, dynamic> message) async {
  try {
    if (await Freshchat.isFreshchatNotification(message)) {
      debugPrint("is Freshchat notification");
      Freshchat.handlePushNotification(message);
    }
  } catch (e) {
    debugPrint('$e');
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  try {
    debugPrint("Inside background handler");
    await Firebase.initializeApp();
    handleFreshchatNotification(message.data);
  } catch (e) {
    debugPrint('$e');
  }
}

List<ClinicModel> andhraPradeshList = [];
List<ClinicModel> karnatakaList = [];
List<ClinicModel> karnatakaList2 = [];

List<ClinicModel> maharastraPList = [];
List<ClinicModel> maharastraNList = [];
List<ClinicModel> maharastraMList = [];

List<ClinicModel> mathyaPradeshList = [];
List<ClinicModel> mathyaPradeshList2 = [];
List<ClinicModel> mathyaPradeshList3 = [];
List<ClinicModel> tamilList = [];

List<ClinicModel> telunganaHList = [];
List<ClinicModel> telunganaSList = [];
List<ClinicModel> telunganaVList = [];
List<ClinicModel> telunganaMList = [];

void showCategoryDialog(BuildContext context, Widget child, String title) {
  try {
    var alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(title,
          style: GoogleFonts.lato(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
      titleTextStyle: GoogleFonts.lato(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      content: child,
      // actions: [
      //   TextButton(
      //     style: ElevatedButton.styleFrom(
      //       padding: const EdgeInsets.symmetric(
      //           horizontal: 12.0, vertical: 8.0),
      //       backgroundColor: redLight,
      //     ),
      //     onPressed: () => Navigator.pop(context),
      //     child:
      //     Text('Cancel', style: GoogleFonts.lato(
      //         fontSize: 14, color: Colors.white)),
      //   ),
      //   const SizedBox(width: 10.0,),
      // ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  } catch (e) {
    debugPrint('$e');
  }
}

// LAUNCH USER TO MAP
Future<void> openMap(
  double latitude,
  double longitude,
) async {
  try {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String removeHtmlTags(String htmlString) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}
