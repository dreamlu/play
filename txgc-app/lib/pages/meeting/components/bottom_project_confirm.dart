import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/model/person.dart';
import 'package:txgc_app/provides/person.dart';
import 'package:txgc_app/utils/global.dart';

class BottomProjectConfirm extends StatelessWidget {
  final int tabIdx;
  final String isMultiple;
  BottomProjectConfirm({this.tabIdx, this.isMultiple = '0'});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 750.w,
        height: (145 + Global.areaHeight).h,
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 35.h + Global.areaHeight.h,
        ),
        child: _btn(context, '确认选择', Color(0xFFFF6565)),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, String title, Color color) {
    return InkWell(
      onTap: () {
        int selectedIdx = context.read<PersonProvider>().selectedIdx;
        List<Person> listData = context.read<PersonProvider>().listData;

        if (selectedIdx == -1) {
          showToast('请选择人员');
        } else {
          if (isMultiple == '1') {
            Global.formRecord['join_ids'] =
                listData.where((item) => item.isCheck).toList();
          } else {
            Global.formRecord['record_id'] = listData[selectedIdx].id;
            Global.formRecord['record_name'] = listData[selectedIdx].name;
            Global.formRecord['record_phone'] = listData[selectedIdx].phone;
          }

          Navigator.pop(context);
        }
      },
      child: Container(
        width: 700.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                  color: Color(0x45005489),
                  offset: Offset(0, 2.w),
                  blurRadius: 5.w)
            ]),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
