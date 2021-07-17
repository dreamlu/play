import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/utils/global.dart';

class ScanPage extends StatefulWidget {
  final Map<String, dynamic> params;
  ScanPage(
    this.params,
  );
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      showToast('扫描成功');
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          NavBack(),
          Positioned(
              bottom: (100 + Global.areaHeight).h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      }),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFF009CFF),
          borderRadius: 10.w,
          borderWidth: 4.w,
          cutOutBottomOffset: 100.h,
          cutOutSize: 500.w),
    );
  }
}
