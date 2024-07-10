
import 'package:infinite/utils/packeages.dart';

class ExpansionPanelItem {
  final String headerText;
  final Widget body;
  bool isExpanded;

  ExpansionPanelItem({required this.headerText, required this.body, this.isExpanded = false});
}

class ExpansionPanelRadioSample extends StatefulWidget {
  @override
  _ExpansionPanelRadioSampleState createState() => _ExpansionPanelRadioSampleState();
}

class _ExpansionPanelRadioSampleState extends State<ExpansionPanelRadioSample> {
  List<ExpansionPanelItem> _data = <ExpansionPanelItem>[
    ExpansionPanelItem(
      headerText: 'Panel 1',
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Content for Panel 1'),
      ),
    ),
    ExpansionPanelItem(
      headerText: 'Panel 2',
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Content for Panel 2'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionPanelRadio Sample'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
            child: ExpansionPanelList.radio(
              elevation: 2,
              expandIconColor: black,
              expandedHeaderPadding: EdgeInsets.zero,
              animationDuration: kThemeAnimationDuration,
              children: _data.map<ExpansionPanelRadio>((ExpansionPanelItem item) {
                return ExpansionPanelRadio(
                  value: item,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      dense: true,
                      title: Text(item.headerText),
                    );
                  },
                  body: item.body,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
