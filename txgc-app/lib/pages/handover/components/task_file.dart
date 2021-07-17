import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/media.dart';
import 'package:txgc_app/utils/index.dart';

class TaskFile extends StatelessWidget {
  final List<Media> files;
  final bool isView;
  final void Function(Media item) onTap;
  TaskFile(this.files, {this.isView = true, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      children: files
          .map((item) => Container(
                margin: EdgeInsets.only(bottom: 20.w),
                padding: EdgeInsets.only(left: 25.w, right: 30.w),
                height: 92.h,
                width: 700.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _taskFileBody(context, item),
                    _taskOperation(context, item)
                  ],
                ),
              ))
          .toList(),
    ));
  }

  Widget _taskFileBody(BuildContext context, Media item) {
    return Expanded(
        child: InkWell(
      onTap: () {
        mediaPreviewer(context, item.url, name: item.name);
      },
      child: Row(
        children: [
          Image.asset(
            'images/file.png',
            fit: BoxFit.cover,
          ),
          _taskFileName(item)
        ],
      ),
    ));
  }

  Widget _taskFileName(Media item) {
    return Container(
      width: 460.w,
      margin: EdgeInsets.only(left: 22.w),
      child: Text(
        '${item.name}',
        style: TextStyle(color: Colors.black, fontSize: 28.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _taskOperation(BuildContext context, Media item) {
    if (isView) {
      return InkWell(
        onTap: () {
          mediaPreviewer(context, item.url, name: item.name);
        },
        child: Icon(
          Icons.keyboard_arrow_right,
          color: Color(0xFF999999),
        ),
      );
    } else {
      return Container(
        child: InkWell(
          onTap: (){
            onTap(item);
          },
          child: Row(
            children: [
              Image.asset(
                'images/delete.png',
                fit: BoxFit.cover,
              ),
              Text(
                '  删除',
                style: TextStyle(color: Color(0xFF999999), fontSize: 28.sp),
              )
            ],
          ),
        ),
      );
    }
  }
}
