

import '../utils/packeages.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  LifeCycleManagerState createState() => LifeCycleManagerState();
}

class LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    debugPrint("InitState");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("DidChangeDependencies");
  }

  @override
  void setState(fn) {
    debugPrint("SetState");
    super.setState(fn);
  }
  @override
  void deactivate() {
    debugPrint("Deactivate");
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('AppLifecycleState: $state');
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        debugPrint('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        debugPrint('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
      // sharedPreferences?.setInt("is_timer_started", 0);
        debugPrint('appLifeCycleState detached');
        break;
      default:
        debugPrint('app detached');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    debugPrint("Dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}