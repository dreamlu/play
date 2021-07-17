import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/provides/pdf.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/image_util.dart';

final _cache = <String, Uint8List>{};

Future<Uint8List> _download(String url) async {
  if (!_cache.containsKey(url)) {
    print('Downloading $url');
    final response = await http.get(Uri.parse(url));
    final data = response.bodyBytes;
    _cache[url] = Uint8List.fromList(data);
  }

  return _cache[url];
}

Future<Uint8List> _downloadPdf(String url) async {
  final data = await _download(url);
  return data.buffer.asUint8List();
}

Future<List> _convertPdf2Png(Uint8List document) async {
  final _cachePng = [];
  await for (var page in Printing.raster(document, pages: [0, 1], dpi: 72)) {
    _cachePng.add(await page.toImage());
  }
  return _cachePng;
}

Future<List> generateCertificate(String url) async {
  final libreBaskerville = await _convertPdf2Png(await _downloadPdf(url));
  return libreBaskerville;
}

class PdfCertificate extends StatelessWidget {
  final String pdfUrl;
  final String certUrl;

  PdfCertificate(this.pdfUrl, this.certUrl);

  Future<List> getData(BuildContext context) async {
    List imageList = await generateCertificate(pdfUrl);
    int sumPage = context.read<PdfProvider>().sumPage;
    if (sumPage != imageList.length) {
      context.read<PdfProvider>().handleSumPage(imageList.length);
    }
    ui.Image image = imageList[0];
    return [image, imageList];
  }

  /// pdf预览
  Widget _pdfViewer(BuildContext context, snapshot) {
    double canvasScale =
        snapshot.data[0].width / ScreenUtil().setWidth(snapshot.data[0].width);
    // double canvasScale = 2;
    return Positioned(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Color(0x45999999)),
      ),
      width: snapshot.data[0].width / canvasScale,
      height: snapshot.data[0].height / canvasScale,
      child: _pdfImage(context, snapshot),
    ));
  }

  Widget _pdfImage(BuildContext context, snapshot) {
    int clientPage = context.watch<PdfProvider>().clientPage - 1;
    List imageList = snapshot.data[1];
    ui.Image image = imageList[clientPage];

    Future<List> getData(BuildContext context) async {
      final ByteData bytes =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List list = bytes.buffer.asUint8List();
      return list;
    }

    return FutureBuilder(
        future: getData(context),
        builder: (BuildContext context, AsyncSnapshot data) {
          if (data.hasData) {
            return Image.memory(
              data.data,
              fit: BoxFit.cover,
            );
          } else {
            return Center(
              child: Text('渲染中...'),
            );
          }
        });
  }

  /// 缩小小图片图标
  Widget _certScaleIn(BuildContext context) {
    return Positioned(
        top: 32.0,
        right: 0,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              double scale = context.read<PdfProvider>().scale;

              if (scale == 0.8) {
                return;
              }
              scale *= 1.2;
              if (scale > 0.8) {
                scale = 0.8;
              }
              context.read<PdfProvider>().handleScale(scale);
            },
            child: Icon(
              Icons.zoom_in_sharp,
              color: Color(0xFF009CFF),
              size: 60,
            )));
  }

  /// 放大小图片图标
  Widget _certScaleOut(BuildContext context) {
    return Positioned(
        top: 80.0,
        right: 0,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              double scale = context.read<PdfProvider>().scale;
              if (scale == 0.15) {
                return;
              }
              scale /= 1.2;
              if (scale < 0.15) {
                scale = 0.15;
              }
              context.read<PdfProvider>().handleScale(scale);
            },
            child: Icon(
              Icons.zoom_out,
              color: Color(0xFF009CFF),
              size: 60,
            )));
  }

  /// 占位部件
  Widget _place() {
    return Positioned(
      top: 0,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isCert = context.watch<PdfProvider>().isCert;
    return FutureBuilder(
      future: getData(context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Stack(
              children: [
                _pdfViewer(context, snapshot),
                isCert
                    ? PdfDrag(certUrl,
                        width: snapshot.data[0].width.toDouble(),
                        height: snapshot.data[0].height.toDouble(),
                        canvasScale: snapshot.data[0].width /
                            ScreenUtil().setWidth(snapshot.data[0].width))
                    : _place(),
                isCert ? _certScaleIn(context) : _place(),
                isCert ? _certScaleOut(context) : _place(),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('加载中...'),
          );
        }
      },
    );
  }
}

class PdfDrag extends StatefulWidget {
  final String certUrl;
  final double width;
  final double height;
  final double canvasScale;

  PdfDrag(this.certUrl, {this.width, this.height, this.canvasScale});
  @override
  _PdfDragState createState() => _PdfDragState();
}

class _PdfDragState extends State<PdfDrag> {
  Offset offset = Offset(0, 0);
  double certWidth = 1;
  double certHeight = 1;

  @override
  void initState() {
    super.initState();
    _initImageWH();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Listener(
          behavior: HitTestBehavior.opaque,
          child: _dargImage(),
          onPointerMove: handlePointerMove,
        ));
  }

  /// 处理签名图片移动
  /// [event] PointerMoveEvent
  void handlePointerMove(
    PointerMoveEvent event,
  ) {
    double dxOffset = (750 - widget.width) / 2 / widget.canvasScale;

    /// x距离左边距离
    double scale = context.read<PdfProvider>().scale;
    double maxDx = ((widget.width - (certWidth * scale)) / widget.canvasScale);
    double dx = event.position.dx -
        dxOffset -
        certWidth * scale / 2 / widget.canvasScale;
    double maxDy = (widget.height - (certHeight * scale)) / widget.canvasScale;
    double dy = event.position.dy -
        (130 + Global.areaHeight + certHeight * scale / 2) / widget.canvasScale;
    if (dx < 0) {
      dx = 0;
    } else if (dx > maxDx) {
      dx = maxDx;
    }
    if (dy < 0) {
      dy = 0;
    } else if (dy > maxDy) {
      dy = maxDy;
    }
    if (this.offset.dx == dx && this.offset.dy == dy) {
      return;
    }
    setState(() => this.offset = Offset(dx, dy));
    context.read<PdfProvider>().handleResult({
      'width': widget.width,
      'height': widget.height,
      'signatureHeight': certHeight * scale,
      'signatureWidth': certWidth * scale,
      'x': dx * widget.canvasScale,
      'y': dy * widget.canvasScale
    });
    print(
        '${widget.width}, ${widget.height}, ${certWidth * scale} ,${certHeight * scale} , ${dx * widget.canvasScale} , ${dy * widget.canvasScale}');
  }

  /// 拖放小图片
  Widget _dargImage([color = 0x45999999]) {
    double scale = context.watch<PdfProvider>().scale;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Color(color))),
      child: Image.network(
        widget.certUrl,
        width: (certWidth * scale) / widget.canvasScale,
        height: (certHeight * scale) / widget.canvasScale,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 获取拖放图片原始宽高
  void _initImageWH() async {
    Rect rect = await new ImageUtil().getImageWH(url: widget.certUrl);

    setState(() {
      certWidth = rect.width;
      certHeight = rect.height;
    });
  }
}
