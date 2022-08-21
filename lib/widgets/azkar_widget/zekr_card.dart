import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/zekr_model.dart';
import '../../providers/azkar_provider.dart';
import '../../providers/settings_provider.dart';
import '../../util/colors.dart';
import '../../util/helpers.dart';

class Zekr extends StatefulWidget {
  final ZekrModel zekr;
  final int numberZekr, counter;
  final bool isCounterOpen, isDiacriticsOpen, showSanad;
  final Function onTap, onRefresh, onSanad;
  final double fontSize;

  Zekr({
    this.zekr,
    this.numberZekr,
    this.isCounterOpen,
    this.isDiacriticsOpen,
    this.showSanad,
    this.counter,
    this.onTap,
    this.onRefresh,
    this.onSanad,
    this.fontSize,
  });

  @override
  _ZekrState createState() => _ZekrState();
}

class _ZekrState extends State<Zekr> {
  String _fontType;

  ScreenshotController _screenshotController = ScreenshotController();
  bool _isScreenShot = false;
  Uint8List img;

  @override
  void initState() {
    super.initState();
    _fontType = Provider.of<SettingsProvider>(context, listen: false)
        .getsettingField('font_family')
        .toString();
  }

  bool get isFinish => widget.counter == widget.zekr.counterNumber;

  String get text => widget.isDiacriticsOpen
      ? widget.zekr.textWithDiacritics +
      '\n***********\nالسند :\n' +
      widget.zekr.sanad
      : widget.zekr.textWithoutDiacritics +
      '\n***********\nالسند :\n' +
      widget.zekr.sanad;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: isFinish ? blue[200] : blue[300],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: blue[200],
        borderRadius: BorderRadius.circular(10),
        onTap: widget.isCounterOpen ? widget.onTap : null,
        onLongPress: () => copyText(context, text),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              _buildRefreshButton(size),
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    border: _isScreenShot == true
                        ? Border.all(color: Color(0xff030072), width: 3.4)
                        : Border.all(
                      width: 0,
                      color: isFinish ? blue[200] : blue[300],
                    ),
                    color: isFinish ? blue[200] : blue[300],
                  ),
                  child: Column(
                    children: [
                      _buildTextZekr(size),
                      if (_isScreenShot == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Image.asset(
                                  'assets/images/icons/favorites/9.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              Text(
                                'قلوب ذاكرة',
                                style: TextStyle(
                                  color: isFinish ? blue[400] : blue[900],
                                  fontFamily: _fontType,
                                  fontSize: widget.fontSize,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              _buildNumberRepetitions(size),
              _buildBottomWidget(size),
              if (widget.showSanad) _buildTextSanad(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton(Size size) {
    if (isFinish)
      return Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: widget.onRefresh,
          child: Icon(
            Icons.refresh,
            color: isFinish ? blue[400] : blue[600],
          ),
        ),
      );
    else
      return SizedBox(
        height: 24,
      );
  }

  Widget _buildTextZekr(Size size) {
    return Text(
      widget.isDiacriticsOpen
          ? widget.zekr.textWithDiacritics
          : widget.zekr.textWithoutDiacritics,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: isFinish ? blue[400] : blue[900],
        fontFamily: _fontType,
        fontSize: widget.fontSize,
      ),
    );
  }

  Widget _buildBottomWidget(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Align(alignment: Alignment.centerRight, child: _buildNumberOfAzkar()),
          if (widget.counter != 0)
            Align(alignment: Alignment.center, child: _buildCounter()),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildButton(
                    icon: Icons.share, onTap: () => _shareScreenShot()),
                _buildButton(
                  icon: Icons.content_copy,
                  onTap: () => copyText(context, text),
                ),
                _buildButton(
                  icon: widget.showSanad ? Icons.info : Icons.info_outline,
                  onTap: widget.onSanad,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({Function onTap, IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: isFinish ? blue[400] : blue[600],
        ),
      ),
    );
  }

  Widget _buildNumberOfAzkar() {
    return Text(
      'الذكر ${widget.numberZekr} من ${Provider.of<AzkarProvider>(context, listen: false).length}',
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: blue[400],
        fontFamily: _fontType,
        fontSize: 14,
      ),
    );
  }

  Widget _buildTextSanad(Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: isFinish ? blue[100] : blue[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        widget.zekr.sanad,
        style: new TextStyle(
          color: isFinish ? blue[400] : blue[600],
          fontFamily: _fontType,
          fontSize: widget.fontSize - 2,
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        color: isFinish ? blue[300] : blue[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '${widget.counter} / ${widget.zekr.counterNumber}',
        style: new TextStyle(
          color: isFinish ? blue[400] : blue[100],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildNumberRepetitions(Size size) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 5.0, left: 15.0, right: 15.0),
      child: Text(
        widget.zekr.counterText == null
            ? translate(context, 'zekr_repeated_once')
            : widget.zekr.counterText,
        style: new TextStyle(
          fontFamily: _fontType,
          color: isFinish ? blue[400] : blue[700],
          fontSize: 12,
        ),
      ),
    );
  }

  // Take And Save And Share Screen Shot
  void _shareScreenShot() {
    _takeScreenShot().then((Uint8List image) async {
      await _saveScreenShotInGallery(image);
      setState(() {
        _isScreenShot = false;
      });
      await _ShareScreenShot(image);
    }).catchError((onError) {
      debugPrint(onError);
    });
  }

  // Change Value IsScreenShot To Show Border And Logo And App Name
  Future<void> ChangeValueIsScreenShot() {
    setState(() {
      _isScreenShot = true;
    });
    return null;
  }

  // Take Screen Shot
  Future<Uint8List> _takeScreenShot() async {
    await ChangeValueIsScreenShot();
    return await _screenshotController.capture(
        pixelRatio: 3, delay: const Duration(milliseconds: 60));
  }

  // Save Screen Shot In Gallery
  Future<void> _saveScreenShotInGallery(Uint8List image) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await ImageGallerySaver.saveImage(Uint8List.fromList(image),
        quality: 80, name: name);
  }

  // Share Screen Shot
  Future<void> _ShareScreenShot(Uint8List image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(image);
    await Share.shareFiles([imagePath.path]);
  }
}
