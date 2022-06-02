import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  GlobalKey<ScaffoldState> scaffoldkey;
  BuildContext pageContext;
  String title;
  bool hideSearch;
  bool showBack;

  CustomAppBar({Key? key, 
    required this.scaffoldkey,
    required this.pageContext,
    this.title =  '',
    this.hideSearch = false,
    this.showBack = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void searchAction() {
      Navigator.pushReplacementNamed(pageContext, '/search');
    }

    IconButton drawerIcon = IconButton(
      icon: const Icon(Icons.menu, color: Colors.black, size: 30),
      onPressed: () {
        scaffoldkey.currentState?.openDrawer();
      });

    IconButton backIcon = IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
      onPressed: () {
        Navigator.pop(pageContext);
      });

    IconButton leadingButton = drawerIcon;

    if (showBack) {
      leadingButton = backIcon;
    }

    return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Helvitica Neue'),
    ),
    leading: leadingButton,
    actions: <Widget>[
      !hideSearch
          ? IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 30),
              onPressed: searchAction)
          : Container()
    ], systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);

}