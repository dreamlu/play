import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/model/share_edit.dart';
import 'package:txgc_app/provides/share_edit.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';
import 'components/panel_list.dart';

class EditorViewPage extends StatefulWidget {
  final Map<String, dynamic> params;
  EditorViewPage(
    this.params,
  );
  @override
  _EditorViewPageState createState() => _EditorViewPageState();
}

class _EditorViewPageState extends State<EditorViewPage> {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkList = [
    new CheckBoxType('是', false, 'app'),
    new CheckBoxType('否', false, 'msg'),
  ];

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

  Future getData(BuildContext context, bool isReset) async {
    // context.read<AddressProvider>().getData(isReset: isReset);
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
          color: Color(0xFFF7F7F7),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            reverse: widget.params["isView"] == 'false',
            child: Column(
              children: [
                _contentBody(),
                widget.params["isView"] == 'false' ? _formList() : Container()
              ],
            ),
          ),
        ),
        '提交共享编辑',
        resizeToAvoidBottomPadding: true);
  }

  Widget _contentBody() {
    List<ReceiveIds> data = Global.formRecord['receive_ids']
        .where((element) => element.status == 1)
        .toList();
    if (Global.formRecord['receive_id_log'] != null) {
      data.addAll(Global.formRecord['receive_id_log']);
    }
    return Container(
      color: Colors.white,
      child: Wrap(
        children: [
          _topBody(),
          PanelList(
              data,
              widget.params["isPublic"] == '1'
                  ? '当前共享编辑暂无最新提交'
                  : '当前共享编辑为非公开状态\n所有人提交内容相互之间无法查看',
              'images/editor-empty.png',
              getData: getData,

              // textLen: desc.length / 25,
              isView: widget.params["isView"]),
        ],
      ),
    );
  }

  Widget _topBody() {
    return Container(
      width: 750.w,
      margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${Global.formRecord['name']}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '${Global.formRecord['view_content']}',
            style: TextStyle(color: Color(0xFF010101), fontSize: 26.sp),
          ),
        ],
      ),
    );
  }

  Widget _formList() {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.h),
                color: Colors.white,
                padding: EdgeInsets.only(top: 30.h),
                child: Wrap(
                  children: [
                    ManaFormItem('content', "填写共享编辑", "点击输入您想输入的内容",
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        formItemColor: Color(0xFFF7F7F7),
                        formItemBorderColor: Color(0xFFD2D2D2)),
                    ManaFormItem('file', "", "", isMedia: true),
                  ],
                ),
              ),
              _formBtn(context)
            ]),
      ),
    );
  }

  void handleShowPickerModal(BuildContext context, List data) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.adapter.text);
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (await context.read<ShareEditProvider>().handleStatus()) {
            Timer(Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          }
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
          '提交${Global.formRecord["is_ay"] == '0' ? '' : '匿名'}共享编辑',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
