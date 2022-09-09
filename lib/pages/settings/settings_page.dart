import 'package:azkark/util/helpers.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../services/services_export.dart';
import '../../util/background.dart';
import '../../widgets/settings_widget/setting_font_size.dart';
import '../../widgets/settings_widget/setting_font_type.dart';
import '../../widgets/settings_widget/settings_item.dart';
import 'package:flutter/cupertino.dart';
import '../../util/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      const Background(),
      Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'الضبط',
            style: TextStyle(
              color: blue[50],
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              _buildPublicSettings(),
              _buildAzkarSettingsCard(context),
              _buildChoseAzan(context),
              // _buildCommunicate(size)
            ],
          ),
        ),
      ),
    ]);
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: blue[50],
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20)),
      border: Border.all(color: blue[600]),
    );
  }

  Widget _buildAzkarSettingsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: _buildTitle('إعدادات الأذكار'),
          ),
          Container(
            decoration: _decoration(),
            child: Column(
              children: <Widget>[
                SettingsItem(
                  activeTitle: translate(context, 'popup_menu_counter_true'),
                  inactiveTitle: translate(context, 'popup_menu_counter_false'),
                  nameField: 'counter',
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(20)),
                ),
                SettingsItem(
                  activeTitle: translate(context, 'popup_menu_diacritics_true'),
                  inactiveTitle:
                      translate(context, 'popup_menu_diacritics_false'),
                  nameField: 'diacritics',
                ),
                SettingsItem(
                  activeTitle: translate(context, 'popup_menu_sanad_true'),
                  inactiveTitle: translate(context, 'popup_menu_sanad_false'),
                  nameField: 'sanad',
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: _buildTitle('الإعدادات العامة'),
          ),
          Container(
            decoration: _decoration(),
            child: Column(
              children: const <Widget>[
                SettingFontType(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                ),
                SettingFontSize(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoseAzan(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: _buildTitle('اختيار صوت الاذان'),
          ),
          Container(
            decoration: _decoration(),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Radio(
                        activeColor: Colors.cyan,
                        value: 1,
                        groupValue:
                            Provider.of<SettingsProvider>(context, listen: true)
                                .value,
                        onChanged: (value) async{
                          await setAzanSound("a");
                          Provider.of<SettingsProvider>(context, listen: false)
                              .save_data(value.toString(), 1);
                        }),
                    Text(
                      "الحرم المكي",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    Radio(
                        value: 2,
                        activeColor: Colors.cyan,
                        groupValue:
                            Provider.of<SettingsProvider>(context, listen: true)
                                .value,
                        onChanged: (value) async{
                          await setAzanSound("b");
                          Provider.of<SettingsProvider>(context, listen: false)
                              .save_data(value.toString(), 2);
                        }),
                    Text(
                      "أذان القدس",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    Radio(
                        value: 3,
                        activeColor: Colors.cyan,
                        groupValue:
                            Provider.of<SettingsProvider>(context, listen: true)
                                .value,
                        onChanged: (value) async{
                          await setAzanSound("c");
                          Provider.of<SettingsProvider>(context, listen: false)
                              .save_data(value.toString(), 3);
                        }),
                    Text(
                      "العفاسي ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    Radio(
                        value: 4,
                        activeColor: Colors.cyan,
                        groupValue:
                            Provider.of<SettingsProvider>(context, listen: true)
                                .value,
                        onChanged: (value) async{
                          await setAzanSound("d");
                          Provider.of<SettingsProvider>(context, listen: false)
                              .save_data(value.toString(), 4);
                        }),
                    Text(
                      "مكه المكرمة ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Container(
      decoration: BoxDecoration(
        color: blue[600],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Text(
          text,
          style: TextStyle(
            color: blue[50],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
