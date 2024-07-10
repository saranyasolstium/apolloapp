import '../../utils/packeages.dart';

class BookAppointmentSlot extends StatefulWidget {
  const BookAppointmentSlot({Key? key}) : super(key: key);

  @override
  State<BookAppointmentSlot> createState() => _BookAppointmentSlotState();
}

class _BookAppointmentSlotState extends State<BookAppointmentSlot> {
  int checkedIndex = 2;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTimeForManipulation = DateTime.now();
  String mySelectedDate = "", mySelectedDateForBooking = "";
  int myDefaultDateForIncAndDec = 0;
  bool absorbPointer = false;
  @override
  void initState() {
    mySelectedDate = myDefaultDateFormatOne.format(selectedDate).toString();
    mySelectedDateForBooking =
        myDefaultDateFormatForBooking.format(selectedDate).toString();
    super.initState();
  }

  void showDateSelectionDialog(BuildContext context) {
    try {
      FocusScope.of(context).unfocus();
      showDatePickerDialog(context, selectedDate, 'future').then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              selectedDate = value;
              mySelectedDate = myDefaultDateFormatOne.format(value);
              mySelectedDateForBooking =
                  myDefaultDateFormatForBooking.format(value);
              debugPrint(
                  "SHOW BOOK APPOINTMENT SLOT DATE PICKER: $mySelectedDate === $mySelectedDateForBooking");
            });
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
        title: "Book Home Test",
        child: Column(children: [
          Container(
            color: loginBlue,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("assets/svg/radio_symbol.svg"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Book Slot",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotStepper(
                      dotCount: 3,
                      dotRadius: 12,
                      activeStep: 1,
                      shape: Shape.circle,
                      spacing: 40,
                      tappingEnabled: false,
                      lineConnectorsEnabled: true,
                      indicator: Indicator.jump,
                      fixedDotDecoration: const FixedDotDecoration(
                        color: lightBlue3,
                      ),
                      indicatorDecoration: const IndicatorDecoration(
                        color: loginTextColor,
                      ),
                      lineConnectorDecoration: const LineConnectorDecoration(
                        color: lightBlue3,
                        strokeWidth: 0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AbsorbPointer(
                absorbing: absorbPointer,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black26,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        DateTime currentDate = DateTime.now();
                        selectedDate = DateTime(selectedDate.year,
                            selectedDate.month, selectedDate.day - 1);
                        if (selectedDate != currentDate) {
                          setState(() {
                            debugPrint(
                                'SHOW BOOK APPOINTMENT DECREASE: ${selectedDate.isBefore(currentDate)} === ${selectedDate.isAfter(currentDate)}');
                            debugPrint(
                                'SHOW BOOK APPOINTMENT DECREASE 1: $currentDate === $selectedDate');
                            if (selectedDate.isAfter(currentDate)) {
                              mySelectedDate =
                                  myDefaultDateFormatOne.format(selectedDate);
                              mySelectedDateForBooking =
                                  myDefaultDateFormatForBooking
                                      .format(selectedDate);
                            } else {
                              absorbPointer = true;
                              showErrorSnackBar(
                                  context, "You are not allowed to this..!");
                              Future.delayed(const Duration(seconds: 2), () {
                                absorbPointer = false;
                              });
                            }
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => showDateSelectionDialog(context),
                child: Text(
                  mySelectedDateForBooking,
                  style: zzRegularBlackTextStyle13A,
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black26,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      selectedDate = DateTime(selectedDate.year,
                          selectedDate.month, selectedDate.day + 1);
                      setState(() {
                        mySelectedDate =
                            myDefaultDateFormatOne.format(selectedDate);
                        mySelectedDateForBooking =
                            myDefaultDateFormatForBooking.format(selectedDate);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10.0),
            child: const Divider(
              color: Colors.black26,
              thickness: 3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 2.5,
                ),
                shrinkWrap: true,
                itemCount: 30,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        checkedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: (checkedIndex == index ? loginBlue2 : loginBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(4),
                      child: Center(
                          child: Text('8:00 AM - 8:30 AM',
                              style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: (checkedIndex == index
                                      ? Colors.black
                                      : Colors.black26)))),
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                  color: loginBlue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('* Rs. 500 will need to pay\n before request'),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: loginTextColor,
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                    child: Text(
                      'Add to cart',
                      style: zzBoldBlueDarkTextStyle10A1,
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
