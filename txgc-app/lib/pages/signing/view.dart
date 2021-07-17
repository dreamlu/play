import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/pdf_certificate.dart';
import 'package:txgc_app/components/pdf_page.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/provides/pdf.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/bottom_operation.dart';

class SigningViewPage extends StatelessWidget {
  final Map<String, dynamic> params;
  SigningViewPage(this.params);

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        ChangeNotifierProvider(
            create: (_) => PdfProvider(),
            builder: (BuildContext context, child) => Stack(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minHeight:
                                (Global.fullHeight - 130 - Global.areaHeight)
                                    .h),
                        child: _pdfList(context)),
                    BottomOperation(),
                  ],
                )),
        '查看签认内容');
  }

  Widget _pdfList(BuildContext context) {
    final String path = Global.formRecord['path'];
    final int ts = Global.formRecord['timestamp'];
    return Wrap(
      children: [
        PdfCertificate('$MEDIA_PREFIX$path?v=$ts',
            '$MEDIA_PREFIX${Global.userCache.user.sign}'),
        PdfPage(),
        Container(
          height: (130 + Global.areaHeight).h,
        )
      ],
    );
  }
}
