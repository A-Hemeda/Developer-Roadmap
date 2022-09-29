import 'package:booking_app/core/component/custom_text.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildSettingItem extends StatelessWidget {
  final Widget widget;
  final String label;
  final VoidCallback onTap;

  const BuildSettingItem(
      {Key? key,
      required this.widget,
      required this.label,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: CustomText(
        text: label,
        fontSize: 18,
        color: AppColors.white,
      ),
      trailing: widget,
    );
  }
}
