
import 'package:flutter/material.dart';

customAppBar(String title, BuildContext context,
    {bool? automaticallyImplyLeading, Widget? leading, List<Widget>? actions}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return AppBar(
    // iconTheme: const IconThemeData(color: Colors.white),
    iconTheme: Theme.of(context).appBarTheme.iconTheme,
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    leading: leading,
   // backgroundColor: Colors.blue,
    elevation: 3.0,
    centerTitle: true,
    toolbarHeight: 64,
    actions: actions,
    title: Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          title,
          
          style: textTheme.headline5,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
      ],
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
  );
}