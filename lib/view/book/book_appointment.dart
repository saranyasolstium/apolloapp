import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../utils/packeages.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int mySelectType = 1, mySelectAppointmentType = 1;
  String mySelectAppointmentType2 = 'In Home';
  String mySelectedStateId = "0", mySelectedCityId = "0";
  int radioValue = 1;
  TextEditingController firstController = TextEditingController();
  TextEditingController firstController2 = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController lastController2 = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController mailController2 = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pinController = TextEditingController();
  String radioButtonDefault = 'Home';
  String addressss = '', myAddressSelection = '';
  int activeStep = 0;
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? formattedDate;
  DateTime? pickedDate;
  DateTime selectedDate = DateTime.now();
  bool addressSelected = false;
  bool yours = false,
      address = false,
      slot = false,
      store = false,
      detail = false;
  String aName = "", aMobile = "", aMail = "", aLastN = '';
  bool absorbPointer = false;
  int? checkedIndex;
  String? selectedSlot;
  var item2 = [
    'Speciality',
    'Opthalmology (Eye)',
    'Audiology (Ear)',
    'Nasal (Sleep)',
    'Dental (Oral)',
    'Dernatology (Skin)'
  ];
  String dropDownValue = 'Speciality';

  var item3 = [
    'Select Type',
    'Father',
    'Mother',
    'Daughter',
    'Son',
    'Spouse',
    'Guardian'
  ];
  String dropDownValue3 = 'Select Type';

  var item4 = [
    'Category',
    'Eye Test',
    'Hearing Test',
    'Hearing Aid Trail',
    'Sleep Study',
    'CPAP/BiPAP Trail',
    'Laser Hair Reduction',
    'Hydrafacial',
    'Skin Rejuvenation',
    '3D Oral Scan'
  ];
  String dropDownValue4 = 'Category';

  @override
  void initState() {
    loading = false;
    yours = false;
    address = true;
    slot = true;
    store = true;
    detail = true;
    aMail = sharedPreferences!.getString("mail").toString();
    aName = sharedPreferences!.getString("firstName").toString();
    aLastN = sharedPreferences!.getString("lastName").toString();
    aMobile = sharedPreferences!.getString("mobileNumber").toString();

    firstController.text = aName.toString();
    lastController.text = aLastN.toString();
    mailController.text = aMail.toString();
    phoneController.text = aMobile.toString();

    super.initState();
  }

  Future gotoDatePicker(BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: loginTextColor,
                    onPrimary: Colors.white,
                  ),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          foregroundColor: loginTextColor))),
              child: child!);
        });
    if (pickedDate != null) {
      if (DateTime.now().day != pickedDate!.day) {
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
          dateController.text = formattedDate!;
        });
      } else {
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
          dateController.text = formattedDate!;
        });
      }
    }
  }

  Future<void> _selectTime(BuildContext context, String selectDate) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: loginTextColor,
              onPrimary: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(primary: loginTextColor),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;

        final DateTime currentDateTime = DateTime.now();
        final DateTime selectedDateTime = DateTime(
          int.parse(selectDate.split('-')[2]), // Year
          int.parse(selectDate.split('-')[1]), // Month
          int.parse(selectDate.split('-')[0]), // Day
          picked.hour,
          picked.minute,
        );

        final DateTime minAllowedTime =
            currentDateTime.add(const Duration(hours: 2));

        if (selectedDateTime.isAfter(minAllowedTime)) {
          if (picked.hour >= 8 && picked.hour < 20) {
            timeController.text =
                '${_addLeadingZeroIfNeeded(picked.hourOfPeriod)}:${_addLeadingZeroIfNeeded(picked.minute)} ${picked.period.name}'
                    .toUpperCase();
          } else {
            showErrorSnackBar(
                context, 'Please  select a time between 8 AM and 8 PM.');
          }
        } else {
          // Otherwise, show an error
          showErrorSnackBar(
              context, 'Please select a time at least two hours ahead.');
        }
      });
    } else {
      final DateTime currentDateTime = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        int.parse(selectDate.split('-')[2]), // Year
        int.parse(selectDate.split('-')[1]), // Month
        int.parse(selectDate.split('-')[0]), // Day
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final DateTime minAllowedTime =
          currentDateTime.add(const Duration(hours: 2));

      if (selectedDateTime.isAfter(minAllowedTime)) {
        if (_selectedTime.hour >= 8 && _selectedTime.hour < 20) {
          timeController.text =
              '${_addLeadingZeroIfNeeded(_selectedTime.hour)}:${_addLeadingZeroIfNeeded(_selectedTime.minute)} ${_selectedTime.period.name}'
                  .toUpperCase();
        } else {
          showErrorSnackBar(
              context, 'Please  select a time between 8 AM and 8 PM.');
        }
      } else {
        // Otherwise, show an error
        showErrorSnackBar(
            context, 'Please select a time at least two hours ahead.');
      }
    }
  }

  String _addLeadingZeroIfNeeded(int value) {
    if (value < 10) return '0$value';
    return value.toString();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DefaultAppBarWidget(
          title: "Book Home Test",
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    selectedColor: loginBlue2,
                    hoverColor: loginBlue2,
                    splashColor: loginBlue2,
                    tileColor: mySelectType == 1 ? loginBlue2 : white,
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          mySelectType = 1;
                          yours = false;
                          address = true;
                          slot = true;
                          store = true;
                          detail = true;
                        });
                      }
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 11.sp,
                                height: 11.sp,
                                child: mySelectType == 1
                                    ? SvgPicture.asset(
                                        "assets/svg/ayush_icon2.svg")
                                    : SvgPicture.asset(
                                        "assets/svg/ayush_icon.svg")),
                            Text("At Home",
                                style: GoogleFonts.lato(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text("Get expert to help you to your door step",
                            style: zzRegularBlackTextStyle9),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: ListTile(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          mySelectType = 2;
                          store = false;
                          address = true;
                          slot = true;
                          detail = true;
                        });
                      }
                    },
                    style: ListTileStyle.drawer,
                    hoverColor: loginBlue2,
                    splashColor: loginBlue2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    tileColor: mySelectType == 2 ? loginBlue2 : white,
                    selectedColor: loginBlue2,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 11.sp,
                                height: 11.sp,
                                child: mySelectType == 2
                                    ? SvgPicture.asset(
                                        "assets/svg/ayush_icon2.svg")
                                    : SvgPicture.asset(
                                        "assets/svg/ayush_icon.svg")),
                            Text("Visit Store",
                                style: GoogleFonts.lato(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                            "Visit nearby store for an advance and expert help",
                            style: zzRegularBlackTextStyle9)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: mySelectType == 1,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('1. Your Details',
                                    style: GoogleFonts.lato(
                                        color:
                                            mySelectType == 1 && yours == false
                                                ? loginTextColor
                                                : Colors.grey.shade300,
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.bold)))),
                        Visibility(
                            visible: mySelectType == 2,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('1. Locate Store',
                                    style: GoogleFonts.lato(
                                        color:
                                            mySelectType == 2 && store == false
                                                ? loginTextColor
                                                : Colors.grey.shade300,
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.bold)))),
                        Divider(
                          color: yours == false || store == false
                              ? loginTextColor
                              : Colors.grey.shade300,
                          thickness: 2.sp,
                        ),
                        Visibility(
                            visible: mySelectType == 1,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('2. Address Details',
                                    style: GoogleFonts.lato(
                                        color: mySelectType == 1 &&
                                                address == false
                                            ? loginTextColor
                                            : Colors.grey.shade300,
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.bold)))),
                        Visibility(
                            visible: mySelectType == 2,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('2. Your details',
                                    style: GoogleFonts.lato(
                                        color:
                                            mySelectType == 2 && detail == false
                                                ? loginTextColor
                                                : Colors.grey.shade300,
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.bold)))),
                        Divider(
                          color: address == false || detail == false
                              ? loginTextColor
                              : Colors.grey.shade300,
                          thickness: 2.sp,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('3. Preferred Slot',
                                style: GoogleFonts.lato(
                                    color: slot == false
                                        ? loginTextColor
                                        : Colors.grey.shade300,
                                    fontSize: 13.0.sp,
                                    fontWeight: FontWeight.bold))),
                        Divider(
                          color: slot == false
                              ? loginTextColor
                              : Colors.grey.shade300,
                          thickness: 2.sp,
                        ),
                        SizedBox(height: 15.sp),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: mySelectType == 1 &&
                            yours == false &&
                            address == true &&
                            slot == true,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: lightBlue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.sp),
                            child: Column(
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "Relationship Type",
                                            style: zzBoldBlackTextStyle13,
                                            children: const [
                                              TextSpan(
                                                  text: ' *',
                                                  style: TextStyle(
                                                      color: red, fontSize: 13))
                                            ]),
                                        maxLines: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 85,
                                            child: RadioListTile(
                                              value: 1,
                                              groupValue: radioValue,
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: loginTextColor,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  radioValue = value!;
                                                  firstController.text =
                                                      aName.toString();
                                                  lastController.text =
                                                      aLastN.toString();
                                                  mailController.text =
                                                      aMail.toString();
                                                  phoneController.text =
                                                      aMobile.toString();
                                                });
                                              },
                                              title: Text("Self",
                                                  style:
                                                      zzBoldBlackTextStyle10),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: RadioListTile(
                                              value: 2,
                                              groupValue: radioValue,
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: loginTextColor,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  radioValue = value!;
                                                 
                                                  firstController.text =
                                                      aName.toString();
                                                  lastController.text =
                                                      aLastN.toString();
                                                  mailController.text =
                                                      aMail.toString();
                                                  phoneController.text =
                                                      aMobile.toString();
                                                });
                                              },
                                              title: Text(
                                                "Other",
                                                style: zzBoldBlackTextStyle10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                Visibility(
                                  visible: radioValue == 2,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        )),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          isDense: true,
                                          isExpanded: true,
                                          value: dropDownValue3,
                                          items: item3.map((String value) {
                                            return DropdownMenuItem(
                                                value: value,
                                                child: Text(value));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownValue3 = newValue!;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                                SizedBox(height: radioValue == 2 ? 20 : 0),
                                radioValue == 1
                                    ? SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: firstController,
                                          keyboardType: TextInputType.text,
                                          maxLength: 50,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter First Name',
                                            labelText: 'First Name',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: firstController2,
                                          keyboardType: TextInputType.text,
                                          maxLength: 50,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter First Name',
                                            labelText: 'First Name',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                radioValue == 1
                                    ? SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: lastController,
                                          keyboardType: TextInputType.text,
                                          maxLength: 50,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Last Name',
                                            labelText: 'Last Name',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: lastController2,
                                          keyboardType: TextInputType.text,
                                          maxLength: 50,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Last Name',
                                            labelText: 'Last Name',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                radioValue == 1
                                    ? SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: phoneController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Phone',
                                            labelText: 'Phone',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: phoneController2,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Phone',
                                            labelText: 'Phone',
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                radioValue == 1
                                    ? SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: mailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Email',
                                            labelText: 'Email',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: mailController2,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter Email',
                                            labelText: 'Email',
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade300)),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InputDecorator(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7)),
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        isDense: true,
                                        isExpanded: true,
                                        value: dropDownValue4,
                                        items: item4.map((String value) {
                                          return DropdownMenuItem(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropDownValue4 = newValue!;
                                          });
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (radioValue == 1) {
                                            if (dropDownValue4 == 'Category') {
                                              showErrorSnackBar(context,
                                                  'Please select Category type');
                                            } else {
                                              mySelectType = 1;
                                              address = false;
                                              yours = true;
                                              scrollController.animateTo(0,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.easeIn);
                                            }
                                          } else if (radioValue == 2) {
                                            if (firstController2.text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter first name');
                                            } else if (lastController2
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter last name');
                                            } else if (mailController2
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter email');
                                            } else if (phoneController2
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter mobile number');
                                            } else if (dropDownValue3 ==
                                                'Select Type') {
                                              showErrorSnackBar(context,
                                                  'Please select relationship type');
                                            } else if (dropDownValue4 ==
                                                'Category') {
                                              showErrorSnackBar(context,
                                                  'Please select Category type');
                                            } else {
                                              mySelectType = 1;
                                              address = false;
                                              yours = true;
                                              scrollController.animateTo(0,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.easeIn);
                                            }
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.only(
                                              right: 30.sp,
                                              left: 30.sp,
                                              top: 15,
                                              bottom: 15),
                                          backgroundColor: loginTextColor),
                                      child: const Text(
                                        "Next",
                                        style: TextStyle(color: white),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: mySelectType == 1 &&
                              address == false &&
                              slot == true,
                          child: Padding(
                            padding: EdgeInsets.only(left: 1.sp, right: 1.sp),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: lightBlue,
                                  width: 3,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: address1Controller,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText: "House No. / Floor No.",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: address2Controller,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText:
                                              "Location (Apartment/Road/Area)",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: pinController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 6,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText: "Pincode",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 2.sp, right: 2.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Label as:",
                                            style: GoogleFonts.lato(
                                                fontSize: 13.0),
                                          ),
                                          Radio(
                                            value: 'Home',
                                            activeColor: loginTextColor,
                                            groupValue: radioButtonDefault,
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => loginTextColor),
                                            onChanged: (val) {
                                              setState(() {
                                                
                                                radioButtonDefault = 'Home';
                                              });
                                            },
                                          ),
                                          Text(
                                            'Home',
                                            style: GoogleFonts.lato(
                                                fontSize: 12.0),
                                          ),
                                          Radio(
                                            value: 'Office',
                                            activeColor: loginTextColor,
                                            groupValue: radioButtonDefault,
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => loginTextColor),
                                            onChanged: (val) {
                                              setState(() {
                                                
                                                radioButtonDefault = 'Office';
                                              });
                                            },
                                          ),
                                          Text(
                                            'Office',
                                            style: GoogleFonts.lato(
                                                fontSize: 12.0),
                                          ),
                                          Radio(
                                            value: 'Other',
                                            activeColor: loginTextColor,
                                            groupValue: radioButtonDefault,
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => loginTextColor),
                                            onChanged: (val) {
                                              setState(() {
                                                
                                                radioButtonDefault = 'Other';
                                              });
                                            },
                                          ),
                                          Text(
                                            'Other',
                                            style: GoogleFonts.lato(
                                                fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (address1Controller
                                                  .text.isEmpty) {
                                                showErrorSnackBar(context,
                                                    'Please enter house no');
                                              } else if (address2Controller
                                                  .text.isEmpty) {
                                                showErrorSnackBar(context,
                                                    'Please enter location');
                                              } else if (pinController
                                                  .text.isEmpty) {
                                                showErrorSnackBar(context,
                                                    'Please enter pincode');
                                              } else {
                                                mySelectType = 1;
                                                slot = false;
                                                address = true;
                                                scrollController.animateTo(0,
                                                    duration:
                                                        Duration(seconds: 1),
                                                    curve: Curves.easeIn);
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  right: 30.sp,
                                                  left: 30.sp,
                                                  top: 15,
                                                  bottom: 15),
                                              backgroundColor: loginTextColor),
                                          child: const Text(
                                            "Next",
                                            style: TextStyle(color: white),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 2.sp,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              mySelectType = 1;
                                              yours = false;
                                              address = true;
                                              address1Controller.clear();
                                              address2Controller.clear();
                                              pinController.clear();
                                              
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  right: 30.sp,
                                                  left: 30.sp,
                                                  top: 15,
                                                  bottom: 15),
                                              backgroundColor: loginTextColor),
                                          child: const Text(
                                            "Previous",
                                            style: TextStyle(color: white),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Visibility(
                          visible: slot == false,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: lightBlue),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                children: [
                                  TextFormField(
                                    readOnly: true,
                                    showCursor: false,
                                    onTap: () {
                                      gotoDatePicker(context);
                                      timeController.clear();
                                      dateController.clear();
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: dateController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'dd-mm-yyyy',
                                        labelText: 'Preferred Date',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              gotoDatePicker(context);
                                              dateController.clear();
                                              timeController.clear();
                                              debugPrint(
                                                  'SHOW THE DATE SELECTION:::::${dateController.text.toString()}');
                                            },
                                            child: const Icon(
                                                Icons.calendar_month))),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Visibility(
                                    visible: dateController.text.isNotEmpty,
                                    child: TextFormField(
                                      showCursor: false,
                                      readOnly: true,
                                      onTap: () {
                                        _selectTime(
                                            context, dateController.text);
                                        timeController.clear();
                                      },
                                      
                                      controller: timeController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '--:-- --',
                                          labelText: 'Preferred Time',
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300)),
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                
                                                _selectTime(context,
                                                    dateController.text);
                                                timeController.clear();
                                              },
                                              child: const Icon(
                                                  Icons.access_time_rounded))),
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (dateController.text.isEmpty) {
                                              showErrorSnackBar(
                                                  context, 'Please enter date');
                                            } else if (timeController.text
                                                .toString()
                                                .isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please select time');
                                            } else {
                                              Map<String, dynamic> data =
                                                  <String, dynamic>{};
                                              data['first_name'] =
                                                  firstController.text
                                                      .toString();
                                              data['email'] = mailController
                                                  .text
                                                  .toString();
                                              data['phone'] = phoneController
                                                  .text
                                                  .toString();
                                              data['date'] = dateController.text
                                                  .toString();
                                              
                                              data['time'] = timeController.text
                                                  .toString();
                                              data['category'] = dropDownValue4;
                                              data['apppointment_location'] =
                                                  mySelectType == 2
                                                      ? mySelectedCityId
                                                      : address2Controller.text;
                                              data['address'] = mySelectType ==
                                                      2
                                                  ? myAddressSelection
                                                  : "${address1Controller.text},${address2Controller.text},${pinController.text}";
                                              data['relation_ship'] =
                                                  mySelectType == 2
                                                      ? dropDownValue3
                                                      : '';
                                              bookRequest(data, context);
                                              debugPrint(
                                                  'SHOW THE SUBMITTED VALUE::::$data');
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                right: 30.sp,
                                                left: 30.sp,
                                                top: 15,
                                                bottom: 15),
                                            backgroundColor: loginTextColor),
                                        child: loading == true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.white))
                                            : const Text(
                                                "Book Request",
                                                style: TextStyle(color: white),
                                              )),
                                  ),
                                  SizedBox(
                                    height: 2.sp,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (mySelectType == 1) {
                                              mySelectType = 1;
                                              address = false;
                                              slot = true;
                                            } else {
                                              mySelectType = 2;
                                              detail = false;
                                              slot = true;
                                            }
                                            dateController.clear();
                                            
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                right: 30.sp,
                                                left: 30.sp,
                                                top: 15,
                                                bottom: 15),
                                            backgroundColor: loginTextColor),
                                        child: const Text(
                                          "Previous",
                                          style: TextStyle(color: white),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                          visible: mySelectType == 2 && store == false,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: lightBlue),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                children: [
                                  DropdownButtonFormField(
                                      dropdownColor: const Color(0xFFC8F8C8),
                                      iconDisabledColor: Colors.red,
                                      iconEnabledColor: colorPrimary,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7))),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        labelText: "Select State",
                                        alignLabelWithHint: true,
                                        filled: true,
                                        focusColor: colorPrimary,
                                        fillColor: grayLight,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        counter: const SizedBox(height: 0.0),
                                        labelStyle: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: black,
                                        ),
                                      ),
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        color: black,
                                      ),
                                      value: mySelectedStateId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          mySelectedStateId = newValue!;
                                          mySelectedCityId = "0";
                                        });
                                      },
                                      items: selectStates2),
                                  SizedBox(height: 3.5.sp),
                                  Visibility(
                                    visible: mySelectedStateId != "0",
                                    child: DropdownButtonFormField(
                                        dropdownColor: const Color(0xFFC8F8C8),
                                        iconDisabledColor: Colors.red,
                                        iconEnabledColor: colorPrimary,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(7))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(7))),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7)),
                                          ),
                                          labelText: "Select City",
                                          alignLabelWithHint: true,
                                          filled: true,
                                          focusColor: colorPrimary,
                                          fillColor: grayLight,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.auto,
                                          counter: const SizedBox(height: 0.0),
                                          labelStyle: GoogleFonts.lato(
                                            fontSize: 15,
                                            color: black,
                                          ),
                                        ),
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: black,
                                        ),
                                        value: mySelectedCityId,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            mySelectedCityId = newValue!;
                                          });
                                        },
                                        items: mySelectedStateId == "1"
                                            ? selectCitiesInAndhraPradesh
                                            : mySelectedStateId == "2"
                                                ? selectCitiesInKarnataka
                                                : mySelectedStateId == "3"
                                                    ? selectCitiesInMaharashtra
                                                    : mySelectedStateId == "4"
                                                        ? selectCitiesInMathyaPradesh
                                                        : mySelectedStateId ==
                                                                "5"
                                                            ? selectCitiesInTamilNadu2
                                                            : selectCitiesInTelangana),
                                  ),
                                  Visibility(
                                    visible: mySelectedStateId != "0" &&
                                        mySelectedCityId != "0",
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ListView.builder(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        itemCount: mySelectedStateId == "1" &&
                                                mySelectedCityId == "1"
                                            ? andhraPradeshList.length
                                            : mySelectedStateId == "2" &&
                                                    mySelectedCityId == "1"
                                                ? karnatakaList.length
                                                : mySelectedStateId == "2" &&
                                                        mySelectedCityId == "2"
                                                    ? karnatakaList2.length
                                                    : mySelectedStateId ==
                                                                "3" &&
                                                            mySelectedCityId ==
                                                                "1"
                                                        ? maharastraMList.length
                                                        : mySelectedStateId ==
                                                                    "3" &&
                                                                mySelectedCityId ==
                                                                    "2"
                                                            ? maharastraNList
                                                                .length
                                                            : mySelectedStateId ==
                                                                        "3" &&
                                                                    mySelectedCityId ==
                                                                        "3"
                                                                ? maharastraPList
                                                                    .length
                                                                : mySelectedStateId ==
                                                                            "4" &&
                                                                        mySelectedCityId ==
                                                                            "1"
                                                                    ? mathyaPradeshList2
                                                                        .length
                                                                    : mySelectedStateId ==
                                                                                "4" &&
                                                                            mySelectedCityId ==
                                                                                "2"
                                                                        ? mathyaPradeshList3
                                                                            .length
                                                                        : mySelectedStateId == "4" &&
                                                                                mySelectedCityId == "3"
                                                                            ? mathyaPradeshList.length
                                                                            : mySelectedStateId == "5" && mySelectedCityId == "1"
                                                                                ? tamilList.length
                                                                                : mySelectedStateId == "6" && mySelectedCityId == "1"
                                                                                    ? telunganaHList.length
                                                                                    : mySelectedStateId == "6" && mySelectedCityId == "2"
                                                                                        ? telunganaMList.length
                                                                                        : mySelectedStateId == "6" && mySelectedCityId == "3"
                                                                                            ? telunganaSList.length
                                                                                            : telunganaVList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          ClinicModel model;

                                          //ANDHRA PRADESH
                                          if (mySelectedStateId == "1" &&
                                              mySelectedCityId == "1") {
                                            model = andhraPradeshList[index];
                                          }
                                          //KARNATAKA
                                          else if (mySelectedStateId == "2" &&
                                              mySelectedCityId == "1") {
                                            model = karnatakaList[index];
                                          } else if (mySelectedStateId == "2" &&
                                              mySelectedCityId == "2") {
                                            model = karnatakaList2[index];
                                          }
                                          //MAHARASTRA

                                          else if (mySelectedStateId == "3" &&
                                              mySelectedCityId == "1") {
                                            model = maharastraMList[index];
                                          } else if (mySelectedStateId == "3" &&
                                              mySelectedCityId == "2") {
                                            model = maharastraNList[index];
                                          } else if (mySelectedStateId == "3" &&
                                              mySelectedCityId == "3") {
                                            model = maharastraPList[index];
                                          }

                                          //MATHYA PRADESH

                                          else if (mySelectedStateId == "4" &&
                                              mySelectedCityId == "1") {
                                            model = mathyaPradeshList2[index];
                                          } else if (mySelectedStateId == "4" &&
                                              mySelectedCityId == "2") {
                                            model = mathyaPradeshList3[index];
                                          } else if (mySelectedStateId == "4" &&
                                              mySelectedCityId == "3") {
                                            model = mathyaPradeshList[index];
                                          }

                                          //TAMIL NADU

                                          else if (mySelectedStateId == "5" &&
                                              mySelectedCityId == "1") {
                                            model = tamilList[index];
                                          }
                                          //TELUNGANA

                                          else if (mySelectedStateId == "6" &&
                                              mySelectedCityId == "1") {
                                            model = telunganaHList[index];
                                          } else if (mySelectedStateId == "6" &&
                                              mySelectedCityId == "2") {
                                            model = telunganaMList[index];
                                          } else if (mySelectedStateId == "6" &&
                                              mySelectedCityId == "3") {
                                            model = telunganaSList[index];
                                          } else {
                                            model = telunganaVList[index];
                                          }
                                          myAddressSelection = model.address!;
                                          return InkWell(
                                            onTap: () {
                                              debugPrint(
                                                  'TAMIL LIST SIZE:${tamilList.length}');
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  // height: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        model.clinicName
                                                            .toString(),
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Text(
                                                          model.address!,
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 13,
                                                            letterSpacing: 0.5,
                                                          ),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Open ",
                                                            style:
                                                                zzRegularGreenTextStyle12,
                                                          ),
                                                          Text(
                                                            "8:00 AM to 9:00 PM",
                                                            style:
                                                                zzRegularBlackTextStyle10,
                                                          ),
                                                        ],
                                                      ),
                                                      
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (model
                                                                        .phone ==
                                                                    0) {
                                                                  makeCallOrSendMessage(
                                                                      "call",
                                                                      myDefaultLandLineNumber,
                                                                      "");
                                                                } else {
                                                                  makeCallOrSendMessage(
                                                                      "call",
                                                                      model
                                                                          .phone
                                                                          .toString(),
                                                                      "");
                                                                }
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/svg/call_ayush_icon.svg",
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                debugPrint(
                                                                    "BOOK APPOINTMENT SCREEN VISIT CLINIC LNG: ${model.longitude} LAT: ${model.latitude}");
                                                                
                                                                launchMap(
                                                                    model
                                                                        .address!,
                                                                    model
                                                                        .latitude!,
                                                                    model
                                                                        .longitude!);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/svg/arrow_ayush_icon.svg",
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                addressSelected =
                                                                    true;
                                                                if (addressSelected ==
                                                                    true) {
                                                                  setState(() {
                                                                    mySelectType =
                                                                        2;
                                                                    detail =
                                                                        false;
                                                                    store =
                                                                        true;
                                                                    yours =
                                                                        true;
                                                                    
                                                                  });
                                                                }
                                                                setState(() {
                                                                  activeStep =
                                                                      2;
                                                                });
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      loginTextColor,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20,
                                                                          left:
                                                                              20)),
                                                              child: Text(
                                                                "Select",
                                                                style:
                                                                    zzRegularWhiteTextStyle14,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                          visible: mySelectType == 2 && detail == false,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: lightBlue),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: "Relationship Type",
                                              style: zzBoldBlackTextStyle13,
                                              children: const [
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                        color: red,
                                                        fontSize: 13))
                                              ]),
                                          maxLines: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 85,
                                              child: RadioListTile(
                                                value: 1,
                                                groupValue: radioValue,
                                                contentPadding: EdgeInsets.zero,
                                                activeColor: loginTextColor,
                                                onChanged: (int? value) {
                                                  setState(() {
                                                    radioValue = value!;
                                                    firstController.clear();
                                                    lastController.clear();
                                                    mailController.clear();
                                                    phoneController.clear();

                                                   
                                                  });
                                                },
                                                title: Text("Self",
                                                    style:
                                                        zzBoldBlackTextStyle10),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: RadioListTile(
                                                value: 2,
                                                groupValue: radioValue,
                                                contentPadding: EdgeInsets.zero,
                                                activeColor: loginTextColor,
                                                onChanged: (int? value) {
                                                  setState(() {
                                                    radioValue = value!;
                                                    firstController.clear();
                                                    lastController.clear();
                                                    mailController.clear();
                                                    phoneController.clear();
                                                   
                                                  });
                                                },
                                                title: Text(
                                                  "Other",
                                                  style: zzBoldBlackTextStyle10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                  Visibility(
                                    visible: radioValue == 2,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7)),
                                          )),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                            isDense: true,
                                            isExpanded: true,
                                            value: dropDownValue3,
                                            items: item3.map((String value) {
                                              return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropDownValue3 = newValue!;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: radioValue == 2 ? 20 : 0),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: firstController,
                                      keyboardType: TextInputType.text,
                                      maxLength: 50,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter First Name',
                                        labelText: 'First Name',
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: lastController,
                                      keyboardType: TextInputType.text,
                                      maxLength: 50,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Last Name',
                                        labelText: 'Last Name',
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Phone',
                                        labelText: 'Phone',
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: mailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Email',
                                        labelText: 'Email',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade300)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                        )),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          isDense: true,
                                          isExpanded: true,
                                          value: dropDownValue4,
                                          items: item4.map((String value) {
                                            return DropdownMenuItem(
                                                value: value,
                                                child: Text(value));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropDownValue4 = newValue!;
                                            });
                                          }),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (firstController.text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter first name');
                                            } else if (lastController
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter last name');
                                            } else if (mailController
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter email');
                                            } else if (phoneController
                                                .text.isEmpty) {
                                              showErrorSnackBar(context,
                                                  'Please enter mobile number');
                                            } else if (radioValue == 2 &&
                                                dropDownValue3 ==
                                                    'Select Type') {
                                              showErrorSnackBar(context,
                                                  'Please select relationship type');
                                            } else if (dropDownValue4 ==
                                                'Category') {
                                              showErrorSnackBar(context,
                                                  'Please select Category type');
                                            } else {
                                              mySelectType = 2;
                                              slot = false;
                                              detail = true;
                                              address = true;
                                              scrollController.animateTo(0,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.easeIn);
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                right: 30.sp,
                                                left: 30.sp,
                                                top: 15,
                                                bottom: 15),
                                            backgroundColor: loginTextColor),
                                        child: const Text(
                                          "Next",
                                          style: TextStyle(color: white),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            mySelectType = 2;
                                            store = false;
                                            detail = true;
                                          });
                                          
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                right: 30.sp,
                                                left: 30.sp,
                                                top: 15,
                                                bottom: 15),
                                            backgroundColor: loginTextColor),
                                        child: const Text(
                                          "Previous",
                                          style: TextStyle(color: white),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      const ContactUsWidget(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint(
            "Address: ${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
      } else {
        debugPrint("No address found for the given coordinates.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void launchMap(String address, double latitude, double longitude) async {
    String query = Uri.encodeComponent(address);
    getAddress(latitude, longitude);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  void bookRequest(Map<String, dynamic> data, BuildContext context) {
    try {
      loading = true;
      DioClient(myUrl: EndPoints.bookAppointment, myMap: data)
          .post2()
          .then((value) {
        if (value.statusCode == 200) {
          var aCustomerMap = value.data['status'];
          if (aCustomerMap == "success") {
            showSuccessSnackBar(context, "Book appointment has been placed.");
            Get.off(() => const HomeScreen(index: 0));
          }
        }
        loading = false;
      });
    } catch (d) {
      debugPrint("$d");
    }
  }
}
