import 'package:flutter/material.dart';
import '../../../../core/utilis/constants/colors.dart';

class BuildProfileItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;

  const BuildProfileItem(
      {Key? key,
      required this.text,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Icon(
                  icon,
                  color: AppColors.grey,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            height: 0.5,
            color: AppColors.softGrey,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
