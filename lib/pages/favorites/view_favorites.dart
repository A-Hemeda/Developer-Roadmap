import 'package:azkark/util/helpers.dart';
import 'view_favorite_prayer.dart';
import 'view_favorite_sebha.dart';
import 'view_favorite_categories.dart';
import '../../util/colors.dart';
import '../../util/background.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      const Background(),
      Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            translate(context, 'favorite_bar'),
            style: TextStyle(
              color: blue[50],
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _buildItemsCard(
                  'assets/images/sections/8_128px.png', 'الأذكار', size),
              _buildItemsCard('assets/images/icons/prayer/prayer_256px.png',
                  'الأدعية', size),
              _buildItemsCard('assets/images/icons/sebha/sebha_256px.png',
                  'المسبحة الإلكترونية', size),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildItemsCard(String pathIcon, String text, Size size) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: blue[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        highlightColor: blue[400],
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (text == 'الأذكار') {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const ViewFavoriteCategories();
              }),
            );
          } else if (text == 'الأدعية') {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const ViewFavoritePrayer();
              }),
            );
          }
          if (text == 'المسبحة الإلكترونية') {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const ViewFavoriteSebha();
              }),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.08,
                child: Image.asset(
                  pathIcon,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blue,
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
