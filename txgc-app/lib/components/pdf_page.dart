import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/provides/pdf.dart';

class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int sum = context.watch<PdfProvider>().sumPage;
    int client = context.watch<PdfProvider>().clientPage;
    return Container(
      margin: EdgeInsets.all(35.w),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _pageBtn(context, '上一页', onTab: () {
            context.read<PdfProvider>().handleCliPage(-1);
          }),
          _pageBtn(context, '$client/$sum'),
          _pageBtn(context, '下一页', onTab: () {
            context.read<PdfProvider>().handleCliPage(1);
          }),
        ],
      ),
    );
  }

  Widget _pageBtn(BuildContext context, String title,
      {GestureTapCallback onTab}) {
    return InkWell(
      onTap: onTab,
      child: Container(
        width: 145.w,
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(27.w))),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
