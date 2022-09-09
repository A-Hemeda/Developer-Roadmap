import '../../../pages/search/search_azkar.dart';
import '../../../util/navigate_between_pages/fade_route.dart';
import '../../../util/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AnimationController animationController;
  final String title;
  final Function onTap;

  const CustomAppBar({Key key,
    this.title,
    this.onTap,
    this.animationController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height); //50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: blue[50],
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.all(4.0),
          child: IconButton(
              color: blue[50],
              highlightColor: blue[700],
              splashColor: blue[700],
              padding: const EdgeInsets.all(0.0),
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, FadeRoute(page: const SearchForZekr()));
              }),
        ),
        if (animationController != null) _buildMenuButton(),
      ],
    );
  }

  Widget _buildMenuButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: IconButton(
        highlightColor: blue[700],
        splashColor: blue[700],
        onPressed: onTap,
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: animationController,
          color: blue[50],
        ),
      ),
    );
  }
}
