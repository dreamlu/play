import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_radius.dart';
import 'package:txgc_app/model/person.dart';
import 'package:txgc_app/provides/person.dart';

class ProjectItem extends StatelessWidget {
  final int index;
  final Person item;
  ProjectItem(this.item, {this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 115.h),
        child: InkWell(
          onTap: () {
            context
                .read<PersonProvider>()
                .handleSelected(index, isMultiple: true);
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 40.w),
                child: _formCheck(context),
              ),
              _userInfo()
            ],
          ),
        ));
  }

  Widget _formCheck(BuildContext context) {
    List<Person> listData = context.watch<PersonProvider>().listData;
    return FormRadius(
      isCheck: listData[index].isCheck,
    );
  }

  Widget _userInfo() {
    return Expanded(
        child: Container(
      constraints: BoxConstraints(minHeight: 115.h),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 2.w))),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 40.w),
            child: Text(
              item.name,
              style: TextStyle(color: Color(0xFF010101), fontSize: 30.sp),
            ),
          ),
          Text(
            item.phone,
            style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
          )
        ],
      ),
    ));
  }
}
