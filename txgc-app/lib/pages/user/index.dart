import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/routers/application.dart';
import 'components/user_box.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      FutureBuilder(
        future: getData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Client clientDetail = context.read<UserProvider>().clientDetail;
          return UserBox(clientDetail);
        },
      ),
      '',
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 42.w),
          child: InkWell(
            child: Icon(Icons.settings),
            onTap: () {
              Application.router.navigateTo(context, '/about',
                  transition: TransitionType.native);
            },
          ),
        )
      ],
    );
  }

  Future<String> getData(BuildContext context) async {
    await context.read<UserProvider>().getData(context, id: 1775);
    return '';
  }
}
