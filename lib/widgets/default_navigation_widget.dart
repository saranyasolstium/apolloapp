import 'package:get/get.dart';
import '../control/home_controller/home_controller.dart';
import '../utils/packeages.dart';

class DefaultAppBarWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final int? fromWhere;
  final int? address;
  final int? productId;
  final bool resizeToAvoidBottomInset;
  const DefaultAppBarWidget(
      {Key? key,
      required this.child,
      this.title,
      this.fromWhere,
      this.resizeToAvoidBottomInset = true,
      this.address,
      this.productId})
      : super(key: key);

  @override
  State<DefaultAppBarWidget> createState() => _DefaultAppBarWidgetState();
}

class _DefaultAppBarWidgetState extends State<DefaultAppBarWidget> {
  final homeCtrl = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      endDrawer: const NavigationWidget(),
      appBar: AppBar(
        backgroundColor: loginTextColor,
        title: Text(
          "${widget.title}",
          style: zzRegularWhiteAppBarTextStyle14,
        ),
        leading: InkWell(
          onTap: () {
            debugPrint('FROM WHERE ${widget.fromWhere}');
            debugPrint('FROM TITLE ${widget.title}');
            if (widget.fromWhere == 1) {
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              // Get.back();
              // Get.back();
              debugPrint("called 1 2");
             // Get.off(() => ViewProductListScreen(411246690548));

              if (widget.title == "Cart") {
                homeCtrl.applyPageCartCount();

                homeCtrl.update();
                debugPrint("called 1 3");

                Get.off(() => HomeScreen(index: 0)!);
              } else {
                homeCtrl.applyPageCartCount();

                homeCtrl.update();
                debugPrint("called 1 4");

                Get.off(() => HomeScreen(index: 0));
              }
            } else if (widget.fromWhere == 2) {
              debugPrint("called 2");
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              // Get.off(() => ViewProductListScreen(411246690548));
              Get.off(() => HomeScreen(index: 0));
            } else if (widget.fromWhere == 3) {
              // Get.off(() => ViewProductListScreen(411246690548));
              debugPrint("called 3");
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              //  Get.off(() => BookAppointment());
              Get.off(() => HomeScreen(index: 0));
            } else if (widget.fromWhere == 4) {
              debugPrint("called 4, 44");
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              Get.back();
              Get.back();
              // debugPrint("called 4");
              // Get.offAll(() => ViewProductListScreen(411246690548));
              // Get.off(() => HomeScreen(index: 0));
            } else if (widget.fromWhere == 4 ||
                widget.title == "Trial Request") {
              debugPrint("called 4, Trial Request");
              // Get.offAll(() => ViewProductListScreen(411246690548));
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              Get.offAll(() => HomeScreen(index: 0));
            } else if (widget.title == "Book Appointment") {
              debugPrint("called 4, Trial Request");
              // Get.offAll(() => ViewProductListScreen(411246690548));
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              Get.back();
              Get.back();
              // Get.offAll(() => HomeScreen(index: 0));
            } else if (widget.fromWhere == 5) {
              debugPrint("called 5");
              // Get.back();
              // Get.back();
              // Get.to(()=>HomeScreen(index: 0));
              debugPrint("called 5");
              // Get.ofFROM WHEREf(() => const HomeScreen());
              homeCtrl.applyPageCartCount();

              homeCtrl.update();
              //Get.offAll(() => const ViewProductListScreen(411246690548));
            }
            // else if(widget.fromWhere==7){
            //   Get.off(() => const TrialRequestProductList(411751645428));
            // }
            else {
              Get.back();
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 28.0,
          ),
        ),
        actions: <Widget>[
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  "assets/svg/left_menu.svg",
                  color: white,
                  height: 15.0,
                  width: 15.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            );
          }),
          SizedBox(
            width: 3.w,
          ), //IconButton
        ], //
      ),
      body: widget.child,
    ));
  }
}
