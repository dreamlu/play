import 'dart:async';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/provides/file_receive.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

class DocViewPage extends StatefulWidget {
  final Map<String, dynamic> params;
  DocViewPage(this.params);
  @override
  _DocViewPageState createState() => _DocViewPageState();
}

class _DocViewPageState extends State<DocViewPage> with RouteAware {
  bool _isLoading = true;
  PDFDocument document;
  Day entryTime;

  @override
  void initState() {
    super.initState();
    entryTime = Day();
    getDocument();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 添加监听订阅
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    // 移除监听订阅
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPop() {
    super.didPop();
    Global.formRecord['status'] = 1;
    Global.formRecord['time'] = microseconds2Time(Day().diff(
      entryTime,
    ));

    context.read<FileReceiveProvider>().handleStatus();
  }

  getDocument() async {
    document =
        await PDFDocument.fromURL('$MEDIA_PREFIX${Global.formRecord['file']}');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _formList(context),
            widget.params["tabIdx"] == '0' ? _formBtn(context) : Container()
          ],
        ),
      ),
      '查看详情',
    );
  }

  Widget _formList(
    BuildContext context,
  ) {
    return Expanded(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              showNavigation: false,
              showPicker: false,
              document: document,
              zoomSteps: 1,
              scrollDirection: Axis.vertical),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        Global.formRecord['status'] = 2;
        Global.formRecord['time'] = microseconds2Time(Day().diff(
          entryTime,
        ));

        if (await context.read<FileReceiveProvider>().handleStatus()) {
          Timer(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 45.h,
            bottom: (35 + Global.areaHeight).h,
            left: 25.w,
            right: 25.w),
        width: 750.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x45005489),
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          '确认浏览完成',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
