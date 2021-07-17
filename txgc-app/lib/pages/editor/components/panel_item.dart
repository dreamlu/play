import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/share_edit.dart';
import 'package:txgc_app/utils/dialog_media.dart';
import 'package:txgc_app/utils/global.dart';

class PanelItem extends StatelessWidget {
  final int tabIdx;
  final ReceiveIds item;

  PanelItem(this.item, this.tabIdx);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.h),
      width: 700.w,
      constraints: BoxConstraints(minHeight: 308.h),
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
          border: Border.all(width: 2.w, color: Color(0xFF009CFF)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.w)),
      child: Wrap(
        children: [_body(context)],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
        width: 640.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topTitle(),
            _contentBody(context),
          ],
        ));
  }

  Widget _topTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 300.w,
          child: Text(
            Global.formRecord['is_ay'] == 1 ? '匿名' : item.name,
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Container(
          width: 300.w,
          child: Text(
            "${item.time}提交",
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xFF999999),
            ),
          ),
        )
      ],
    );
  }

  Widget _contentBody(BuildContext context) {
    List<Widget> _widgetList = [
      Container(
        margin: EdgeInsets.only(top: 19.h),
        constraints: BoxConstraints(maxWidth: 640.w),
        child: Text(
          item.content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
          ),
        ),
      )
    ];

    if (item.file != null) {
      _widgetList.add(Wrap(
        children: item.file
            .map<Widget>((element) => Container(
                  margin: EdgeInsets.only(top: 20.h, right: 20.w),
                  child: InkWell(
                    onTap: () {
                      dialogMedia(context, networkMedia: element.url);
                    },
                    child: Image.network(
                      element.url,
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                ))
            .toList(),
      ));
    }

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
    ));
  }
}
