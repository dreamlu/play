import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/utils/dialog_media.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import 'package:txgc_app/utils/verify.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaListType {
  String type;
  String src;
  String name;
  String thumbnailPath;

  MediaListType({
    this.type,
    this.src,
    this.name,
    this.thumbnailPath,
  });
}

/// 表单
class FormItem extends StatefulWidget {
  final String label; // 表单标题
  final String layout; // 表单布局方式
  final double formItemHeight; // 表单字段高度
  final double formMinItemHeight; // 表单字段最低高度
  final double formItemWidth; // 表单字段宽度
  final bool isBorder; // 表单字段底部边框
  final InputBorder custBorder; // 表单字段自定义边框
  final bool isMedia; // 媒体资源上传
  final bool obscureText; // 是否为密码
  final List mediaType; // 媒体资源类型
  final bool isCustPicker; // picker上传
  final int minLines; // 输入框几行
  final EdgeInsetsGeometry formItemMargin; // 表单字段外边距
  final EdgeInsetsGeometry formItemPadding; // 表单字段内边距
  final Color formItemColor; // 表单字段背景
  final Color formItemBorderColor; // 表单字段边框
  final EdgeInsetsGeometry formLabelMargin; // 表单标题外边距
  final int formLabelFontSize; // 表单标题字体大小
  final String name; // 表单提交字段
  final String placeholder; // 表单字段描述
  final TextInputType keyboardType; // 表单类型
  final String hintText; // 表单提示文字
  final String value; // 表单赋值
  final TextAlign textAlign; // 表单提示文字
  final void Function(TextEditingController controller) onTap; // 表单点击触发函数
  final void Function() onPicker; // 表单picker点击触发函数
  final bool enabled; // 是否启用
  final bool isAutoWrap; // 是否自动适配换行
  final bool isClear; // 是否显示清除icon
  final bool isCode; // 是否显示验证码
  final bool isCodeBoxStyle; // 是否使用按钮式验证码样式
  final bool isIconLabel; // 是否使用图标作为表单标题
  final Widget suffix; // 表单前缀修饰
  final Widget prefix; // 表单后缀修饰

  final GestureTapCallback onVerifyCodeTap; // 验证码回掉

  FormItem(this.name, this.label, this.placeholder,
      {this.keyboardType,
      this.hintText,
      this.onTap,
      this.onPicker,
      this.isCode = false,
      this.suffix,
      this.prefix,
      this.value,
      this.enabled = true,
      this.obscureText = false,
      this.isClear = true,
      this.isAutoWrap = false,
      this.textAlign = TextAlign.start,
      this.isCodeBoxStyle = true,
      this.onVerifyCodeTap,
      this.formItemHeight,
      this.formMinItemHeight,
      this.formItemMargin,
      this.formItemPadding,
      this.custBorder,
      this.minLines = 1,
      this.formLabelMargin,
      this.formItemWidth = 695,
      this.formLabelFontSize = 32,
      this.formItemColor = Colors.white,
      this.formItemBorderColor = Colors.white,
      this.isMedia = false,
      this.mediaType = const ['camera'],
      this.isBorder = true,
      this.isCustPicker = false,
      this.isIconLabel = false,
      this.layout = 'vertical'});

  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  // 控制属性
  TextEditingController controller;
  OverlayEntry overlayEntry;

  FocusNode focusNode;
  bool isShowDelete; // 是否显示删除小图标
  bool isError; // 是否触发表单校验文字为红
  bool isObscureText; // 是否显示安全键盘
  String prevPwd; // 上一次密码
  List<MediaListType> mediaList = []; // 媒体资源列表

  String msg; // 获取验证码
  final mediaPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    msg = '获取验证码';
    controller = new TextEditingController();
    focusNode = new FocusNode();

    if (widget.enabled) {
      mediaList = [new MediaListType(type: 'asset', src: 'images/upload.png')];
    }

    /// 获取初始化值
    if (widget.isMedia) {
      handleMediaListAdapter();
    } else {
      controller.text = Global.formRecord[widget.name]?.toString();
    }

    isShowDelete = false;
    isError = false;

    /// 监听输入改变
    controller.addListener(() {
      if (mounted) {
        setState(() {
          isShowDelete = controller.text.isNotEmpty;
        });
      } else {
        setState(() {
          isShowDelete = false;
        });
      }
    });

    focusNode.addListener(() {
      /// 失效焦点隐藏清除按钮
      if (!focusNode.hasFocus) {
        Timer(Duration(microseconds: 300), () {
          setState(() {
            isShowDelete = false;
          });
        });
      }
      if (Platform.isIOS) {
        // 修复ios多行文本 数字键盘 手机号码键盘没有关闭键盘bug
        if ([TextInputType.multiline, TextInputType.number, TextInputType.phone]
                .indexOf(widget.keyboardType) !=
            -1) if (focusNode.hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      }
    });
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  handleMediaListAdapter() async {
    if (Global.formRecord[widget.name] is List<MediaListType>) {
      List<MediaListType> formMediaList = Global.formRecord[widget.name];

      await Future.wait(formMediaList.map((element) async {
        if (!isImage(element.src) && element.type == 'network') {
          element.thumbnailPath = await handleVideoThumbnail(element.src);
        }
      }));

      mediaList.insertAll(0, formMediaList);

      setState(() {
        mediaList = mediaList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget formWidget;
    if (widget.isMedia) {
      if (mediaList.length == 0 && widget.enabled == false) {
        formWidget = Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Text(
            '未上传内容',
            style: TextStyle(
              color: isError ? Colors.red : Color(0xFFB2B2B2),
              fontSize: 28.sp,
            ),
          ),
        );
      } else {
        formWidget = _mediaList(context);
      }
    } else if (widget.isCustPicker) {
      formWidget = _custPicker(context);
    } else {
      formWidget = _formInput(context, widget.placeholder,
          keyboardType: widget.keyboardType, hintText: widget.hintText);
    }

    return Container(
      margin: widget.formItemMargin,
      padding: widget.formItemPadding,
      // height: widget.formItemHeight,
      // constraints: BoxConstraints(minHeight: widget.formMinItemHeight),
      decoration: BoxDecoration(
          border: widget.isBorder
              ? Border(bottom: BorderSide(width: 2.w, color: Color(0xFFF2F2F2)))
              : null),
      child: widget.layout == 'vertical'
          ? Row(
              children: [
                widget.isIconLabel
                    ? _formIcon(widget.label)
                    : _formLabel(widget.label),
                _formInput(context, widget.placeholder,
                    keyboardType: widget.keyboardType,
                    hintText: widget.hintText),
                widget.isCode ? _verifyCode() : Container(),
                widget.isClear == false ? Container() : _suffixIcon(),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isIconLabel
                    ? _formIcon(widget.label)
                    : _formLabel(widget.label),
                Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        formWidget,
                        widget.isCode ? _verifyCode() : Container(),
                        widget.isClear == false ? Container() : _suffixIcon(),
                      ],
                    ))
              ],
            ),
    );
  }

  /// 媒体资源列表
  Widget _mediaList(BuildContext context) {
    return Container(
      width: 600.w,
      margin: EdgeInsets.only(top: 30.h),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 1.0, //显示区域宽高相等
              crossAxisSpacing: 21.w,
              mainAxisSpacing: 21.w),
          itemCount: mediaList.length,
          itemBuilder: (context, index) {
            return _mediaItem(context, mediaList[index]);
          }),
    );
  }

  /// 判断是不是图片
  bool isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType == null || mimeType.startsWith('image/');
  }

  /// 截取视频第一帧
  Future<String> handleVideoThumbnail(String path) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.JPEG,
      thumbnailPath: (await getTemporaryDirectory()).path,
      maxWidth: 220,
      quality: 50,
    );
    return thumbnailPath;
  }

  /// 单个媒体资源
  Widget _mediaItem(BuildContext context, MediaListType item) {
    Widget media;

    /// 媒体资源添加
    void handleShowPicker(BuildContext context) async {
      MediaListType res =
          await showMediaModal(context, mediaType: widget.mediaType);

      setState(() {
        if (res.src != null) {
          int index = mediaList.length - 1;
          index = index < 0 ? 0 : index;
          mediaList.insert(
              index,
              new MediaListType(
                  type: 'file',
                  src: res.src,
                  thumbnailPath: res.thumbnailPath));
          mediaList = mediaList;
          Global.formRecord[widget.name] = mediaList;
        }
      });
    }

    switch (item.type) {

      /// 本地文件预览
      case 'file':
        String src = isImage(item.src) ? item.src : item.thumbnailPath;
        media = InkWell(
            onTap: () {
              dialogMedia(context,
                  fileMedia: item.src, isVideo: !isImage(item.src));
            },
            child: Image.file(
              File(src),
              width: 220.w,
              height: 220.w,
              fit: BoxFit.cover,
            ));

        break;

      case 'asset':

        /// 本地文件上传
        media = InkWell(
          onTap: () {
            handleShowPicker(context);
          },
          child: Image.asset(
            item.src,
            width: 220.w,
            height: 220.w,
            fit: BoxFit.cover,
          ),
        );
        break;
      default:

        /// 网络文件预览
        media = isImage(item.src)
            ? InkWell(
                onTap: () {
                  dialogMedia(context,
                      networkMedia: '$MEDIA_PREFIX${item.src}');
                },
                child: Image.network(
                  '$MEDIA_PREFIX${item.src}',
                  width: 220.w,
                  height: 220.w,
                  fit: BoxFit.cover,
                ),
              )
            : InkWell(
                onTap: () {
                  dialogMedia(context,
                      networkMedia: '$MEDIA_PREFIX${item.src}', isVideo: true);
                },
                child: Image.file(
                  File(isImage(item.src)
                      ? '$MEDIA_PREFIX${item.src}'
                      : item.thumbnailPath),
                  width: 220.w,
                  height: 220.w,
                  fit: BoxFit.cover,
                ),
              );
    }

    /// 媒体资源删除
    void handleRemove() {
      setState(() {
        mediaList.remove(item);
        mediaList = mediaList;
      });
    }

    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: media,
          ),
          isImage(item.src)
              ? Container()
              : Center(
                  child: InkWell(
                  onTap: () {
                    item.type == 'file'
                        ? dialogMedia(context,
                            fileMedia: item.src, isVideo: true)
                        : dialogMedia(context,
                            networkMedia: item.src, isVideo: true);
                  },
                  child: Image.asset(
                    'images/play.png',
                    fit: BoxFit.cover,
                  ),
                )),
          item.type != 'asset'
              ? Positioned(
                  right: 9.w,
                  top: 8.h,
                  child: InkWell(
                    onTap: handleRemove,
                    child: Image.asset(
                      'images/circle-delete.png',
                      fit: BoxFit.cover,
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }

  /// 自定义picker点击
  Widget _custPicker(BuildContext context) {
    bool isNoInit = widget.value == '' || widget.value == null;
    bool isEmpty =
        isNoInit && (controller.text == null || controller.text == '');
    return Container(
      margin: EdgeInsets.only(top: 17.0),
      child: Row(
        children: [
          isEmpty
              ? InkWell(
                  onTap: widget.onPicker,
                  child: Text(
                    widget.placeholder,
                    style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 28.sp),
                  ),
                )
              : Container(
                  constraints: BoxConstraints(maxWidth: 495.w),
                  child: Text(
                    isNoInit ? controller.text : widget.value,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                ),
          isEmpty
              ? Container()
              : Container(
                  margin: EdgeInsets.only(left: 62.w),
                  child: InkWell(
                    onTap: widget.onPicker,
                    child: Text(
                      '重新选择 ›',
                      style:
                          TextStyle(color: Color(0xFF009CFF), fontSize: 28.sp),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  /// 发送验证码
  Widget _verifyCode() {
    return InkWell(
      onTap: () {
        if (Global.formRecord['phone'] == null) {
          showToast('请输入您的手机号');
          return;
        } else if (Verify.isChinaPhone(Global.formRecord['phone'], '手机号格式错误')) {
          if (msg == '获取验证码') {
            widget.onVerifyCodeTap();
            int count = 60;

            Timer.periodic(Duration(seconds: 1), (timer) {
              if (count <= 0) {
                timer.cancel();
                timer = null;
                setState(() {
                  msg = '获取验证码';
                });
                return;
              }
              count--;
              setState(() {
                msg = '$count秒';
              });
            });
          }
        }
      },
      child: Container(
        width: 199.w,
        height: 66.h,
        alignment:
            widget.isCodeBoxStyle ? Alignment.center : Alignment.centerRight,
        decoration: BoxDecoration(
            color: widget.isCodeBoxStyle ? Color(0xFFff9b5e) : Colors.white,
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          '$msg',
          style: TextStyle(
            color: widget.isCodeBoxStyle ? Colors.white : Color(0xFFff9b5e),
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }

  /// 清除小图标
  Widget _suffixIcon() {
    return isShowDelete
        ? InkWell(
            onTap: () {
              controller.clear();
            },
            child: Container(
              child: Icon(
                Icons.cancel,
                color: Color(0xFFB2B2B2),
              ),
            ),
          )
        : Container(
            // height: 30,
            );
  }

  /// 表单标题图标
  Widget _formIcon(
    String icon,
  ) {
    return Container(
        width: 90.w,
        padding: EdgeInsets.only(left: 20.w),
        child: Image.asset(
          icon,
        ));
  }

  /// 表单标题文字
  Widget _formLabel(
    String label,
  ) {
    return label != ''
        ? Container(
            width: widget.layout == 'vertical' ? 200.w : null,
            margin: widget.formLabelMargin,
            child: Text('$label',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: widget.formLabelFontSize.sp,
                    fontWeight: FontWeight.w500)))
        : Container();
  }

  Widget _formInput(BuildContext context, String placeholder,
      {TextInputType keyboardType, String hintText}) {
    int minLines = widget.minLines;
    if (widget.isAutoWrap) {
      if (Global.formRecord[widget.name] != null &&
          Global.formRecord[widget.name] != '') {
        int textLine = (Global.formRecord[widget.name].length / 10).round();
        if (textLine > minLines) {
          minLines = textLine;
        }
      }
    }

    Widget _textFormField() {
      return TextFormField(
          textAlign: widget.textAlign,
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? minLines : 1,
          focusNode: focusNode,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap(controller);
            }
          },
          onSaved: (String value) {
            if (widget.onTap == null) {
              Global.formRecord[widget.name] = value;
            }
          },
          onChanged: (String value) {
            if (widget.onTap == null) {
              Global.formRecord[widget.name] = value;
            }
          },
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          readOnly: widget.onTap == null ? false : true,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              isDense: true,
              border: widget.custBorder != null
                  ? widget.custBorder
                  : InputBorder.none,
              focusedBorder: widget.custBorder != null
                  ? new OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: Color(0xFF009CFF)))
                  : InputBorder.none,
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              hintText: hintText ?? placeholder,
              hintStyle: TextStyle(
                color: isError ? Colors.red : Color(0xFFB2B2B2),
                fontSize: 28.sp,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never),
          validator: (v) {
            if (v.trim().length <= 0) {
              setState(() {
                isError = true;
              });
            }
            return null;
          });
    }

    return Expanded(
      child: Container(
        width: widget.layout == 'vertical'
            ? 465.w
            : (widget.formItemWidth - (widget.isClear ? 100 : 0)).w,
        margin: EdgeInsets.only(
            top: widget.formItemColor != Colors.white ? 22.w : 0),
        padding: EdgeInsets.symmetric(
            horizontal: widget.formItemColor != Colors.white ? 22.w : 0),
        decoration: BoxDecoration(
            color: widget.formItemColor,
            borderRadius: BorderRadius.circular(10.w),
            border: Border.all(width: 1.w, color: widget.formItemBorderColor)),
        child: Platform.isAndroid
            ? Listener(
                /// Listener解决安卓自带安全键盘二次聚焦弹出键盘 参考https://github.com/flutter/flutter/issues/68571
                onPointerDown: (e) =>
                    FocusScope.of(context).requestFocus(focusNode),
                child: _textFormField(),
              )
            : _textFormField(),
      ),
    );
  }
}

class InputDoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      alignment: Alignment.topRight,
      child: CupertinoButton(
        padding: EdgeInsets.only(
          right: 24.w,
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Text("完成",
            style: TextStyle(
                color: Color(0xFF009CFF), fontWeight: FontWeight.bold)),
      ),
    );
  }
}
