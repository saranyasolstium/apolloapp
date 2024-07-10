import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as Badges;
import 'package:get/get.dart';
import 'package:infinite/utils/packeages.dart';

class BadgeController extends GetxController {
  RxInt totalItemCount = 0.obs;

  void updateTotalItemCount(int count) {
    totalItemCount.value = count;
  }

  Future<int> applyCartCount() async {
    try {
      int myCartCount = 0;
      int myBookCount = 0;
      int myFrameCount = 0;
      int myAddOnCount = 0;

      await Future.wait([
        localDBHelper!.getTotalOrderCount().then((value) {
          if (value != null) {
            myCartCount = value!;
            debugPrint("myCartCount: $value");
          }
        }),
        localDBHelper!.getTotalBookCount().then((value) {
          if (value != null) {
            myBookCount = value!;
            debugPrint("myBookCount: $value");
          }
        }),
        localDBHelper!.getTotalFrameCount().then((value) {
          if (value != null) {
            myFrameCount = value!;
            debugPrint("myFrameCount: $value");
          }
        }),
        localDBHelper!.getTotalAddOnCount().then((value) {
          if (value != null) {
            myAddOnCount = value!;
            debugPrint("myAddOnCount: $value");
          }
        }),
      ]);

      // Calculate total count
      int totalCount = myCartCount + myBookCount + myFrameCount + myAddOnCount;
      updateTotalItemCount(totalCount); // Update total count
      return totalCount;
    } catch (e) {
      debugPrint('Error in applyCartCount: $e');
      return 0; // Return 0 if an error occurs
    }
  }
}

class CartIcon extends StatelessWidget {
  final String? type;
  final String? route;
  final int? productId;

  const CartIcon({super.key, this.type, this.route, this.productId});

  @override
  Widget build(BuildContext context) {
    final BadgeController badgeController = Get.put(BadgeController());
    return FutureBuilder<int>(
      future: badgeController.applyCartCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle loading state
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error state
          return Text('Error: ${snapshot.error}');
        } else {
          // Render Badge widget with badge count
          return Obx(() => Badges.Badge(
                toAnimate: true,
                animationType: BadgeAnimationType.fade,
                shape: BadgeShape.circle,
                showBadge: snapshot.data! > 0,
                position: BadgePosition.topEnd(top: -20),
                badgeContent: Text(
                  "${badgeController.totalItemCount.value}",
                  style: zzRegularWhiteTextStyle12,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.off(() =>  Cart(productId: productId,routeType: type,productHandle: "",));
                  },
                  child: SvgPicture.asset(
                    "assets/svg/cart.svg",
                    color: white,
                    height: 20.0,
                    width: 20.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ));
        }
      },
    );
  }
}
