import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/network/endpoints.dart';
import 'package:infinite/utils/global.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../res/colors.dart';
import '../../res/texts.dart';
import '../../services/network/dio_client.dart';
import '../../widgets/default_navigation_widget.dart';

class TalkToDoctor extends StatefulWidget {
  const TalkToDoctor({Key? key}) : super(key: key);

  @override
  State<TalkToDoctor> createState() => _TalkToDoctorState();
}

class _TalkToDoctorState extends State<TalkToDoctor> {
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
  TextEditingController dateController2 = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  String aName = "", aMobile = "", aMail = "", aLastN = '';

  var item2 = [
    'Speciality',
    'Opthalmology (Eye)',
    'Audiology (Ear)',
    'Nasal (Sleep)',
    'Dental (Oral)',
    'Dernatology (Skin)'
  ];
  String dropDownValue = 'Speciality';

  String dropDownValue3 = '0';
  selectAddressType(index) {
    setState(() {
      radioValue = index;
    });
  }

  @override
  void initState() {
    loading = false;
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

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: 'Talk to Doctor',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Relationship Type",
                                style: zzBoldBlackTextStyle13,
                                children: const [
                                  TextSpan(
                                      text: ' *',
                                      style:
                                          TextStyle(color: red, fontSize: 13))
                                ]),
                            maxLines: 1,
                          ),
                          SizedBox(
                            width: 85,
                            height: 50,
                            child: RadioListTile(
                              value: 1,
                              groupValue: radioValue,
                              contentPadding: EdgeInsets.zero,
                              activeColor: loginTextColor,
                              onChanged: (int? value) {
                                setState(() {
                                  radioValue = value!;
                                  firstController.text = aName.toString();
                                  lastController.text = aLastN.toString();
                                  mailController.text = aMail.toString();
                                  phoneController.text = aMobile.toString();
                                });
                              },
                              title:
                                  Text("Self", style: zzBoldBlackTextStyle10),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: RadioListTile(
                              value: 2,
                              groupValue: radioValue,
                              contentPadding: EdgeInsets.zero,
                              activeColor: loginTextColor,
                              onChanged: (int? value) {
                                setState(() {
                                  radioValue = value!;
                                  // firstController.clear();
                                  // lastController.clear();
                                  // mailController.clear();
                                  // phoneController.clear();
                                  firstController.text = aName.toString();
                                  lastController.text = aLastN.toString();
                                  mailController.text = aMail.toString();
                                  phoneController.text = aMobile.toString();
                                });
                              },
                              title: Text(
                                "Other",
                                style: zzBoldBlackTextStyle10,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: radioValue == 2,
                    child: Container(
                      height: 7.h,
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 0),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            )),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isDense: true,
                              isExpanded: true,
                              value: dropDownValue3,
                              items: selectRelationShipTypes,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue3 = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: radioValue == 2 ? 20 : 0),
                  radioValue == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: firstController,
                              keyboardType: TextInputType.text,
                              maxLength: 50,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter First Name',
                                labelText: 'First Name',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: firstController2,
                              keyboardType: TextInputType.text,
                              maxLength: 50,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter First Name',
                                labelText: 'First Name',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  radioValue == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: lastController,
                              keyboardType: TextInputType.text,
                              maxLength: 50,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Last Name',
                                labelText: 'Last Name',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: lastController2,
                              keyboardType: TextInputType.text,
                              maxLength: 50,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Last Name',
                                labelText: 'Last Name',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  radioValue == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone',
                                labelText: 'Phone',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: phoneController2,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone',
                                labelText: 'Phone',
                                counterText: '',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  radioValue == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: mailController,
                              keyboardType: TextInputType.emailAddress,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Email',
                                labelText: 'Email',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: mailController2,
                              keyboardType: TextInputType.emailAddress,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Email',
                                labelText: 'Email',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  radioValue == 1
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
                              showCursor: false,
                              onTap: () {
                                gotoDatePicker();
                                timeController.clear();
                              },
                              textAlignVertical: TextAlignVertical.center,
                              controller: dateController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'dd-mm-yyyy',
                                labelText: 'Preferred Date',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                // suffixIcon: InkWell(
                                //     onTap: () {
                                //       gotoDatePicker();
                                //       timeController.clear();
                                //     },
                                //     child: const Icon(Icons.calendar_month))
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
                              showCursor: false,
                              onTap: () {
                                gotoDatePicker2();
                                timeController2.clear();
                              },
                              textAlignVertical: TextAlignVertical.center,
                              controller: dateController2,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'dd-mm-yyyy',
                                labelText: 'Preferred Date',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                // suffixIcon: InkWell(
                                //     onTap: () {
                                //       gotoDatePicker();
                                //       timeController.clear();
                                //     },
                                //     child: const Icon(Icons.calendar_month))
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Visibility(
                  //     visible: dateController.text.isNotEmpty,
                  //     child:
                  Column(
                    children: [
                      radioValue == 1
                          ? Visibility(
                              visible: dateController.text.isNotEmpty,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      showCursor: false,
                                      readOnly: true,
                                      onTap: () {
                                        _selectTime(
                                            context,
                                            dateController.text,
                                            timeController);
                                        timeController.clear();
                                      },
                                      //  onChanged: (value){
                                      //getFormattedTime(value);
                                      //  },
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
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey)),
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                // gotoTimePicker(context);
                                                _selectTime(
                                                    context,
                                                    dateController.text,
                                                    timeController);
                                                timeController.clear();
                                              },
                                              child: const Icon(
                                                  Icons.access_time_rounded))),
                                    )),
                              ),
                            )
                          : Visibility(
                              visible: dateController2.text.isNotEmpty,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    showCursor: false,
                                    readOnly: true,
                                    onTap: () {
                                      _selectTime(context, dateController2.text,
                                          timeController2);
                                      timeController2.clear();
                                    },
                                    //  onChanged: (value){
                                    //getFormattedTime(value);
                                    //  },
                                    controller: timeController2,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '--:-- --',
                                        labelText: 'Preferred Time',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey)),
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              // gotoTimePicker(context);
                                              _selectTime(
                                                  context,
                                                  dateController2.text,
                                                  timeController2);
                                              timeController2.clear();
                                            },
                                            child: const Icon(
                                                Icons.access_time_rounded))),
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Container(
                    height: 7.h,
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: InputDecorator(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          )),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: dropDownValue,
                            items: item2.map((String value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  margin: const EdgeInsets.all(20),
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            if (radioValue == 1) {
                              if (dateController.text.isEmpty) {
                                showErrorSnackBar(context, "Select date");
                              } else if (timeController.text.isEmpty) {
                                showErrorSnackBar(context, "Select time");
                              } else if (dropDownValue == 'Speciality' ||
                                  dropDownValue.isEmpty) {
                                showErrorSnackBar(
                                    context, "Please choose the speciality");
                              } else {
                                loading = true;
                                Map<String, dynamic> map = {
                                  "first_name": firstController.text,
                                  "last_name": lastController.text,
                                  "email": mailController.text,
                                  "phone": phoneController.text,
                                  "date": dateController.text,
                                  "time": timeController.text,
                                  "speciality": dropDownValue != 'Speciality'
                                      ? dropDownValue
                                      : '',
                                  "form_type": "Self",
                                  "other_type": "",
                                };
                                talkWithDoctor(map, context);
                              }
                            } else if (radioValue == 2) {
                              print(dropDownValue3);
                              if (dropDownValue3 == '0') {
                                showErrorSnackBar(
                                    context, "Select relationship type");
                              } else if (firstController2.text.isEmpty) {
                                showErrorSnackBar(context, "Enter first name");
                              } else if (lastController2.text.isEmpty) {
                                showErrorSnackBar(context, "Enter last name");
                              } else if (phoneController2.text.isEmpty) {
                                showErrorSnackBar(
                                    context, "Enter phone number");
                              } else if (mailController2.text.isEmpty ||
                                  !myMailRegex.hasMatch(mailController2.text)) {
                                showErrorSnackBar(context,
                                    "Please enter a valid email address");
                              } else if (dateController2.text.isEmpty) {
                                showErrorSnackBar(context, "Select date");
                              } else if (timeController2.text.isEmpty) {
                                showErrorSnackBar(context, "Select time");
                              } else if (dropDownValue == 'Speciality' ||
                                  dropDownValue.isEmpty) {
                                showErrorSnackBar(
                                    context, "Please choose the speciality");
                              } else {
                                loading = true;
                                Map<String, dynamic> map = {
                                  "first_name": firstController2.text,
                                  "last_name": lastController2.text,
                                  "email": mailController2.text,
                                  "phone": phoneController2.text,
                                  "date": dateController2.text,
                                  "time": timeController2.text,
                                  "speciality": dropDownValue != 'Speciality'
                                      ? dropDownValue
                                      : '',
                                  "form_type": "Other",
                                  "other_type": dropDownValue3,
                                };
                                talkWithDoctor(map, context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: loginTextColor,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: white),
                          ),
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (radioValue == 2) {
                          radioValue = 1;
                          // firstController.clear();
                          // lastController.clear();
                          // mailController.clear();
                          // phoneController.clear();
                          dateController.clear();
                          timeController.clear();
                          dropDownValue = 'Speciality';
                          dropDownValue3 = 'Select Type';
                        } else {
                          dateController.clear();
                          timeController.clear();
                          dropDownValue = 'Speciality';
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: loginTextColor,
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String? formattedDate;
  DateTime? pickedDate;
  DateTime? pickedDate2;
  Future gotoDatePicker() async {
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
                    // onSurface: loginBlue
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
          debugPrint('FUTURE DATE::::::: $formattedDate');
          dateController.text = formattedDate!;
        });
      } else {
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(
              pickedDate!); // format date in required form here we use yyyy-MM-dd that means time is removed
          debugPrint('TODAY DATE $formattedDate');
          dateController.text = formattedDate!;
        });
      }
    }
  }

  Future gotoDatePicker2() async {
    pickedDate2 = await showDatePicker(
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
                    // onSurface: loginBlue
                  ),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          foregroundColor: loginTextColor))),
              child: child!);
        });
    if (pickedDate2 != null) {
      if (DateTime.now().day != pickedDate2!.day) {
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate2!);
          debugPrint('FUTURE DATE::::::: $formattedDate');
          dateController2.text = formattedDate!;
        });
      } else {
        setState(() {
          formattedDate = DateFormat('dd-MM-yyyy').format(
              pickedDate2!); // format date in required form here we use yyyy-MM-dd that means time is removed
          debugPrint('TODAY DATE $formattedDate');
          dateController2.text = formattedDate!;
        });
      }
    }
  }

  void talkWithDoctor(Map<String, dynamic> map, BuildContext context) {
    DioClient(myUrl: EndPoints.talkToDoctor, myMap: map)
        .doctorPost()
        .then((value) {
      if (value.statusCode == 200) {
        loading = true;
        showSuccessSnackBar(context, 'Successfully submitted');
        Get.back();
      } else {
        loading = false;
      }
    });
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, String selectDate,
      TextEditingController ctrlTime) async {
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
            ctrlTime.text =
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
          ctrlTime.text =
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
}
