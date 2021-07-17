import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/header_title.dart';
import 'components/mana_form_item.dart';

class DormerViewPage extends StatefulWidget {
  final Map<String, dynamic> params;
  DormerViewPage(this.params);
  @override
  _DormerViewPageState createState() => _DormerViewPageState();
}

class _DormerViewPageState extends State<DormerViewPage> {
  @override
  void initState() {
    Global.formRecord['start_date'] = Day().format('YYYY-MM-DD hh:mm:ss');
    Global.formRecord['start_place'] = '浙江省杭州市江干区区天界幸福大道交界处';

    Global.formRecord['video_list'] = [
      {
        'type': 'network',
        'src':
            'https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4'
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              _formList(context, 0),
              widget.params["status"] == '2'
                  ? _formList(context, 2)
                  : Container(),
            ],
          ),
        ),
      ),
      '查看天窗细则',
    );
  }

  Widget _formList(BuildContext context, int status) {
    return Wrap(
      children: [
        ManaFormItem(
          'start_date',
          "${status == 0 ? '开始' : '结束'}时间",
          "",
          enabled: false,
        ),
        ManaFormItem('start_place', "${status == 0 ? '开始' : '结束'}地点", "",
            enabled: false, isAutoWrap: true),
        Hr(),
        HeaderTitle('${status == 0 ? '领取' : '剩余'}物资情况', '图片与视频均可上传'),
        ManaFormItem(
          'name',
          "上传图片",
          "未上传图片",
          isMedia: true,
          enabled: false,
        ),
        ManaFormItem('video_list', "上传视频", "未上传视频",
            enabled: false, isMedia: true, mediaType: ['video']),
        Hr(),
        HeaderTitle('${status == 0 ? '参与' : '结束'}人员情况', '图片与视频均可上传'),
        ManaFormItem('name', "上传图片", "未上传图片", enabled: false, isMedia: true),
        ManaFormItem('video_list', "上传视频", "未上传视频",
            enabled: false, isMedia: true, mediaType: ['video']),
        Hr(),
        HeaderTitle('天窗事件${status == 0 ? '任务内容' : '完成情况'}', '文字、图片与视频均可上传'),
        ManaFormItem('phone', '', "未填写内容",
            minLines: 5, enabled: false, isAutoWrap: true),
        ManaFormItem('name', "上传图片", "未上传图片", enabled: false, isMedia: true),
        ManaFormItem('video_list', "上传视频", "未上传视频",
            enabled: false, isMedia: true, mediaType: ['video']),
      ],
    );
  }
}
