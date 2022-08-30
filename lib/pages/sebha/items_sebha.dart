import '../../util/helpers.dart';
import '../../widgets/sebha_widget/add_tasbih_dialog.dart';
import '../../widgets/sebha_widget/tasbih.dart';
import '../../providers/sebha_provider.dart';
import '../../util/background.dart';
import 'package:provider/provider.dart';
import '../../util/colors.dart';
import 'package:flutter/material.dart';

class ItemsSebha extends StatefulWidget {
  const ItemsSebha({Key key}) : super(key: key);

  @override
  _ItemsSebhaState createState() => _ItemsSebhaState();
}

class _ItemsSebhaState extends State<ItemsSebha> {
  @override
  Widget build(BuildContext context) {
    final sebhaProvider = Provider.of<SebhaProvider>(
      context,
    );
    debugPrint('ItemsSebha => build');
    return Stack(children: <Widget>[
      const Background(),
      Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            translate(context, 'sebha_bar'),
            style: TextStyle(
              color: blue[50],
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(8.0),
              child: IconButton(
                color: blue[50],
                highlightColor: blue[700],
                splashColor: blue[700],
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AddTasbih(
                      title: translate(context, 'sebha_add_dialog'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: sebhaProvider.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: index == 0
                  ? const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0)
                  : index == sebhaProvider.length - 1
                      ? const EdgeInsets.only(
                          bottom: 8.0, left: 8.0, right: 8.0)
                      : const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Tasbih(
                tasbih: sebhaProvider.getItemSebha(index),
                number: index + 1,
              ),
            );
          },
        ),
      ),
    ]);
  }
}
