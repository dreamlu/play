import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/provides/top_search.dart';

class TopSearch extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final void Function(String keywords) onEditingComplete;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final String hintText;
  TopSearch({this.hintText, this.padding, this.onEditingComplete});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: [_searchForm()],
      ),
    );
  }

  Widget _searchForm() {
    return Expanded(
        child: ChangeNotifierProvider(
      create: (_) => TopSearchProvider(),
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _inputForm(context),
        ],
      ),
    ));
  }

  Widget _inputForm(BuildContext context) {
    String _handleSearch(String key) {
      context.read<TopSearchProvider>().handleKey(key);
      return key;
    }

    return Expanded(
      child: Container(
        height: 39.0,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(15.w)),
        child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _handleSearch,
            onEditingComplete: () {
              String keywords = context.read<TopSearchProvider>().keywords;
              onEditingComplete(keywords);
              FocusScope.of(context).unfocus();
            },
            textAlign: TextAlign.left,
            minLines: 1,
            style: TextStyle(
              fontSize: 30.sp,
              // height: 35.h,
            ),
            // textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintText: hintText,
                // contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 30.sp),
                suffixIcon: _suffixIcon(context),
                prefixIcon: Image.asset(
                  'images/search.png',
                  width: 31.w,
                  height: 31.w,
                ))),
      ),
    );
  }

  Widget _suffixIcon(BuildContext context) {
    String keywords = context.watch<TopSearchProvider>().keywords; // 是否非空
    bool isNotEmpty = keywords != '' && keywords != null; // 是否非空
    return isNotEmpty
        ? IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _controller.clear();
              context.read<TopSearchProvider>().handleKey('');
            },
            icon: Icon(Icons.cancel, color: Color(0xFFB2B2B2)),
          )
        : null;
  }
}
