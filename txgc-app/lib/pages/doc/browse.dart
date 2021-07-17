import 'package:flutter/material.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_browse_list.dart';

class DocBrowsePage extends StatefulWidget {
  final Map<String, dynamic> params;
  DocBrowsePage(this.params);
  @override
  _DocBrowsePageState createState() => _DocBrowsePageState();
}

class _DocBrowsePageState extends State<DocBrowsePage> {
  final List<Map> statusList = [
    {'title': '未开始', 'color': Color(0xFFFF6565)},
    {'title': '浏览并确认', 'color': Color(0xFFD2D2D2)},
    {'title': '浏览未确认', 'color': Color(0xFF009CFF)},
  ];

  int tabIdx;

  @override
  void initState() {
    super.initState();
    tabIdx = 0;
  }

  void onTab(int index) {
    setState(() {
      tabIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      CardBrowseList(
        Global.formRecord['receive_ids'] ?? [],
        '暂无浏览情况',
        'images/receive-empty.png',
        getData: getData,
        statusList: statusList,
      ),
      '查看浏览情况',
    );
  }

  Future getData(BuildContext context, bool isReset) async {
    // context.read<AddressProvider>().getData(isReset: isReset);
    return '';
  }
}
