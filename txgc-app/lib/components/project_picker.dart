import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectPicker extends StatelessWidget {
  final List<String> projectData;
  final String placeholder;
  final void Function(String val) onChange;
  ProjectPicker(this.projectData, this.placeholder, {@required this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 750.w,
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xFFEEEEEE))),
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProjectItem(
            projectData,
            placeholder,
            onChange: onChange,
          ),
          Image.asset('images/right-tri.png'),
        ],
      ),
    );
  }
}

class ProjectItem extends StatefulWidget {
  final List<String> projectData;
  final String placeholder;
  final void Function(String val) onChange;
  ProjectItem(this.projectData, this.placeholder, {this.onChange});
  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  String data;

  @override
  void initState() {
    super.initState();
    data = widget.placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Picker(
            adapter: PickerDataAdapter<String>(pickerdata: widget.projectData),
            selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            onConfirm: (Picker picker, List value) {
              setState(() {
                data = widget.projectData[value[0]];
                widget.onChange(data);
              });
            }).showModal(this.context);
      },
      child: Container(
        width: 657.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/project-md.png'),
            Container(
              margin: EdgeInsets.only(left: 12.w),
              child: Text(
                '$data',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
