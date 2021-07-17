import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/order_form_item.dart';

class OrderViewPage extends StatefulWidget {
  final Map<String, dynamic> params;
  OrderViewPage(this.params);
  @override
  _OrderViewPageState createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _formList(context),
              widget.params["tabIdx"] == '0' ? _formBtn(context) : Container()
            ],
          ),
        ),
      ),
      '查看详情',
    );
  }

  Widget _formList(
    BuildContext context,
  ) {
    return Container(
      constraints: BoxConstraints(
          minHeight: (Global.fullHeight - Global.areaHeight - 322).h),
      child: Wrap(
        children: [
          OrderFormItem('content', "工单内容", "暂未填写", minLines: 5, enabled: false),
          OrderFormItem(
            'img',
            "工单图片",
            "未上传图片",
            isMedia: true,
            enabled: false,
          ),
          widget.params["tabIdx"] == '1'
              ? OrderFormItem('reply_content', "回执内容", "负责人暂未回执",
                  minLines: 5, enabled: false)
              : Container(),
          widget.params["tabIdx"] == '1'
              ? OrderFormItem(
                  'reply_img',
                  "回执图片",
                  "负责人暂未上传回执图片",
                  isMedia: true,
                  enabled: false,
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {},
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
          '填写回执',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
