import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';

class MeetingManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  MeetingManaPage(this.params);
  @override
  _MeetingManaPageState createState() => _MeetingManaPageState();
}

class _MeetingManaPageState extends State<MeetingManaPage> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
    print(widget.params["id"] == null);
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: _formList(),
        ),
      ),
      widget.params["id"] == null ? '上传会议记录' : '查看会议记录',
    );
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          constraints: BoxConstraints(
              minHeight: (Global.fullHeight - Global.areaHeight - 322).h),
          child: Wrap(
            children: [
              ManaFormItem(
                'name',
                "会议签到表",
                "",
                isMedia: true,
              ),
              ManaFormItem(
                'phone',
                "会议记录",
                " ›",
                isMedia: true,
              ),
              ManaFormItem(
                'phone',
                "会议相关视频",
                " ›",
                isMedia: true,
                mediaType: ['video'],
              ),
              ManaFormItem(
                'phone',
                "会议相关音频",
                "会议相关音频请在PC端进行上传",
                enabled: false,
              ),
            ],
          ),
        ),
        widget.params["id"] == null ? _formBtn(context) : Container()
      ]),
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
          // if (await context.read<UserProvider>().handleUpdate()) {
          //   Timer(Duration(seconds: 2), () {
          //     Navigator.of(context).pop();
          //   });
          // }
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
          '确认上传',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
