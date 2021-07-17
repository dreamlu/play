import 'package:flutter/material.dart';
import 'package:txgc_app/services/index.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';

class PdfProvider with ChangeNotifier {
  double scale = 0.5; // 默认缩放比例
  bool isCert = false; // 是否开启签名
  int sumPage = 1; // pdf总页数
  int clientPage = 1; // pdf当前页
  Map result = {};

  handleScale(double scale) {
    this.scale = scale;
    notifyListeners();
  }

  handleisCert(bool isCert) {
    this.isCert = isCert;
    notifyListeners();
  }

  handleResult(Map result) {
    this.result = result;
    notifyListeners();
  }

  handleSumPage(int sumPage) {
    this.sumPage = sumPage;
    notifyListeners();
  }

  handleCliPage(
    int flag,
  ) {
    clientPage = clientPage + flag;

    if (clientPage <= 1) {
      clientPage = 1;
    } else if (clientPage >= sumPage) {
      clientPage = sumPage;
    }
    notifyListeners();
  }

  Future<bool> handleSign() async {
    BaseResp res = await pdfSign({
      "path": Global.formRecord['path'],
      "pdf_page": sumPage,
      "sign_page": clientPage,
      "pdf_w": result['width'],
      "pdf_h": result['height'],
      "img_path": Global.userCache.user.sign,
      "img_w": result['signatureWidth'],
      "img_h": result['signatureHeight'],
      "x": result['x'],
      "y": result['y']
    });

    if (res.status == '200') {
      return true;
    }
    return false;
  }
}
