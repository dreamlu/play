import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/project_list.dart';
import 'form_radius.dart';

class TreeView extends StatefulWidget {
// class TreeView extends StatelessWidget {
  final List<ProjectList> treeData;
  final void Function(List<ProjectList> data) onChange;
  TreeView(this.treeData, {this.onChange}) : assert(treeData != null);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  void handleChange(List<ProjectList> data) {
    widget.onChange(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> nodes = handleTreeData(
      widget.treeData,
      0,
    );

    return Container(
      child: ListView(
        children: nodes,
      ),
    );
  }

  /// 递归生成数据
  List<Widget> handleTreeData(List<ProjectList> data, int leftMargin) {
    List<Widget> res = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].child != null && data[i].child.length > 0) {
        res.add(Node(
            name: data[i].name,
            id: data[i].id,
            level: data[i].level,
            leftMargin: leftMargin,
            onChange: handleChange,
            data: widget.treeData,
            // vn: vn,
            children: handleTreeData(
              data[i].child,
              70,
            )));

        continue;
      }
      res.add(Node(
          name: data[i].name,
          id: data[i].id,
          level: data[i].level,
          data: widget.treeData,
          onChange: handleChange,
          // vn: vn,
          leftMargin: leftMargin));
    }
    return res;
  }
}

class Node extends StatelessWidget {
  final String name;
  final int id;
  final String level;
  final int leftMargin;
  final List<ProjectList> data;
  final void Function(List<ProjectList> data) onChange;
  final List<Widget> children;
  Node(
      {this.name,
      this.id,
      this.level,
      this.children = const [],
      this.leftMargin = 0,
      // this.vn,
      this.onChange,
      this.data = const []});

  void handleTap({
    bool isExpand = false,
    bool isSelected = false,
  }) {
    final List<ProjectList> newData = handleSetClientTreeData(
        data,
        new ProjectList(
            id: id, level: level, isExpand: isExpand, isSelected: isSelected));
    onChange(newData);
  }

  @override
  Widget build(BuildContext context) {
    final ProjectList clientNodeType =
        handleClientTreeData(data, new ProjectList(id: id, level: level));
    final List<Widget> childrenMerge = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              handleTap(
                  isExpand: clientNodeType.isExpand,
                  isSelected: !clientNodeType.isSelected);
            },
            child: FormRadius(
              isCheck: clientNodeType.isSelected,
            ),
          ),
          Expanded(
            child: _label(clientNodeType),
          ),
        ],
      )
    ];

    if (children != null && children.length > 0 && clientNodeType.isExpand) {
      childrenMerge.addAll(children);
    }

    return Container(
      margin: EdgeInsets.only(left: leftMargin.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: childrenMerge,
      ),
    );
  }

  Widget _arrow(ProjectList clientNodeType) {
    return InkWell(
      onTap: () {
        handleTap(
            isExpand: !clientNodeType.isExpand,
            isSelected: clientNodeType.isSelected);
      },
      child: Container(
        padding:
            EdgeInsets.only(right: 17.w, left: 39.w, top: 15.h, bottom: 15.h),
        child: RotatedBox(
          quarterTurns: clientNodeType.isExpand ? 1 : 3,
          child: Image.asset('images/right-tri.png'),
        ),
      ),
    );
  }

  Widget _label(ProjectList clientNodeType) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 42.h),
      margin: EdgeInsets.only(left: 36.w),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.w, color: Color(0xFFE6E6E6)))),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                handleTap(
                    isExpand: clientNodeType.isExpand,
                    isSelected: !clientNodeType.isSelected);
              },
              child: Container(
                child: Text(
                  '$name',
                  style: TextStyle(color: Color(0xFF010101), fontSize: 30.sp),
                ),
              ),
            ),
          ),
          children.length > 0 ? _arrow(clientNodeType) : Container()
        ],
      ),
    );
  }

  /// 查找数据中符合当前的NodeType
  ProjectList handleClientTreeData(List<ProjectList> data, ProjectList target) {
    ProjectList res = new ProjectList();
    for (int i = 0; i < data.length; i++) {
      if (data[i].id == target.id && data[i].level == target.level) {
        return data[i];
      } else if (data[i].child != null && data[i].child.length > 0) {
        res = handleClientTreeData(data[i].child, target);
        if (res.id == target.id && res.level == target.level) {
          return res;
        }
      }
    }
    return res;
  }

  /// 设置数据中符合当前的NodeType
  List<ProjectList> handleSetClientTreeData(
    List<ProjectList> data,
    ProjectList target, {
    bool isSelectedAll = false, // 是否选择子级操作
    bool isSelectedOff = false, // 子级操作是否为选中
  }) {
    for (int i = 0; i < data.length; i++) {
      if (data[i].id == target.id && data[i].level == target.level) {
        data[i].isExpand = target.isExpand;
        data[i].isSelected = target.isSelected;
        if (data[i].child != null && data[i].child.length > 0) {
          handleSetClientTreeData(
            data[i].child,
            target,
            isSelectedAll: true,
            isSelectedOff: data[i].isSelected,
          );
        }
      } else if (isSelectedAll) {
        data[i].isSelected = isSelectedOff;
        if (data[i].child != null && data[i].child.length > 0) {
          handleSetClientTreeData(
            data[i].child,
            target,
            isSelectedAll: true,
            isSelectedOff: isSelectedOff,
          );
        }
      } else {
        if (data[i].child != null && data[i].child.length > 0) {
          handleSetClientTreeData(data[i].child, target);
        }
      }
    }
    return data;
  }
}
