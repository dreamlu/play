import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/utils/global.dart';

class ContractPreviewPage extends StatefulWidget {
  final Map<String, dynamic> params;

  ContractPreviewPage(this.params);

  @override
  _ContractPreviewPageState createState() => _ContractPreviewPageState();
}

class _ContractPreviewPageState extends State<ContractPreviewPage> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    getDocument();
  }

  getDocument() async {
    document =
        await PDFDocument.fromURL('$MEDIA_PREFIX${Global.formRecord['url']}');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 27.w),
                child: Text(
                  ' 《合同名称》',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 27.w, bottom: 39.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${Global.formRecord['sign_time']}签订\n甲方：${Global.formRecord['pa']}\n乙方：${Global.formRecord['pb']}\n合同金额：${Global.formRecord['money']}元\n备注：${Global.formRecord['remark']}',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 24.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                color: Color(0xFFEEEEEE),
                height: 35.h,
              ),
              _formList(context),
            ],
          ),
        ),
      ),
      '查看合同',
    );
  }

  Widget _formList(
    BuildContext context,
  ) {
    return Container(
      height: (Global.fullHeight - Global.areaHeight - 1024).h,
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
}
