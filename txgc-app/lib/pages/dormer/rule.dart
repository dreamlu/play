import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/location.dart';
import 'components/header_title.dart';
import 'components/mana_form_item.dart';

class DormerRulePage extends StatefulWidget {
  final Map<String, dynamic> params;
  DormerRulePage(this.params);
  @override
  _DormerRulePageState createState() => _DormerRulePageState();
}

class _DormerRulePageState extends State<DormerRulePage> {
  GlobalKey<FormState> _formKey;
  String locDesc;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    Global.formRecord['start_date'] = Day().format('YYYY-MM-DD hh:mm:ss');
    Global.formRecord['video_list'] = [
      {
        'type': 'network',
        'src':
            'https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4'
      },
    ];
    Global.formRecord['start_pic'] = [
      {'type': 'network', 'src': 'https://via.placeholder.com/220/09f/fff.png'},
    ];

    handleLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: _formList(),
        ),
      ),
      widget.params["type"] == '0' ? '填写上天窗细则' : '填写下天窗细则',
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
                'start_date',
                "${widget.params["type"] == '0' ? '开始' : '结束'}时间",
                "请选择开始时间",
                isClear: false,
                enabled: false,
              ),
              ManaFormItem(
                  'start_place',
                  "${widget.params["type"] == '0' ? '开始' : '结束'}地点",
                  "点击获取当前定位 ›",
                  isCustPicker: true,
                  onPicker: handleLocation,
                  value: locDesc),
              Hr(),
              HeaderTitle('${widget.params["type"] == '0' ? '领取' : '剩余'}物资情况',
                  '图片与视频均可上传'),
              ManaFormItem(
                'start_pic',
                "上传图片",
                "请上传图片",
                isMedia: true,
              ),
              ManaFormItem('video_list', "上传视频", "请上传视频",
                  isMedia: true, mediaType: ['video']),
              Hr(),
              HeaderTitle('${widget.params["type"] == '0' ? '参与' : '结束'}人员情况',
                  '图片与视频均可上传'),
              ManaFormItem('name', "上传图片", "请上传图片", isMedia: true),
              ManaFormItem('video_list', "上传视频", "请上传视频",
                  isMedia: true, mediaType: ['video']),
              Hr(),
              HeaderTitle(
                  '天窗事件${widget.params["type"] == '0' ? '任务内容' : '完成情况'}',
                  '文字、图片与视频均可上传'),
              ManaFormItem(
                'phone',
                '',
                "请填写天窗事件的${widget.params["type"] == '0' ? '任务内容' : '完成情况'}，可填写任务具体${widget.params["type"] == '0' ? '内容' : '完成'}信息",
                minLines: 5,
              ),
              ManaFormItem('name', "上传图片", "请上传图片", isMedia: true),
              ManaFormItem('video_list', "上传视频", "请上传视频",
                  isMedia: true, mediaType: ['video']),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
  }

  /// 获取地理位置
  void handleLocation() async {
    final Location location = await getLocation();
    Global.formRecord['start_place'] = location.desc;
    setState(() {
      locDesc = location.desc;
    });
  }

  void handleDateTime(TextEditingController controller) {}

  void handleShowPickerModal(BuildContext context, List data) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        selectedTextStyle: TextStyle(color: Colors.blue),
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
          '确认发布',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
