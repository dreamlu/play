import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/utils/global.dart';

class NavFilter extends StatelessWidget {
  final List data;
  NavFilter(
      {this.data = const [
        {
          "信号第一项目部": [
            {
              "第一杭绍台工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
            {
              "第二杭绍台工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
            {
              "第三杭绍台工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
          ]
        },
        {
          "信号第二项目部": [
            {
              "第一江干工程": ['江干施工项目部一', '江干施工项目部二', '江干施工项目部三', '江干施工项目部四']
            },
            {
              "第二江干工程": ['江干施工项目部一', '江干施工项目部二', '江干施工项目部三', '江干施工项目部四']
            },
            {
              "第三江干工程": ['江干施工项目部一', '江干施工项目部二', '江干施工项目部三', '江干施工项目部四']
            },
          ]
        },
        {
          "信号第三项目部": [
            {
              "第一工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
            {
              "第二工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
            {
              "第三工程": ['施工项目部一', '施工项目部二', '施工项目部三', '施工项目部四']
            },
          ]
        },
      ]});

  void handleShowPickerArray(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        changeToFirst: true,
        hideHeader: false,
        selectedTextStyle: TextStyle(color: Color(0xFF009CFF)),
        onConfirm: (picker, value) {
          print(value.toString());
          print(picker.adapter.text);
        }).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: Global.statusBarHeight.h,
        right: 21.w,
        child: InkWell(
          onTap: () {
            handleShowPickerArray(context);
          },
          child: Container(
            width: 100.w,
            height: 100.h,
            alignment: Alignment.topRight,
            child: Icon(
              Icons.filter_alt_rounded,
              color: Colors.white,
            ),
          ),
        ));
  }
}
