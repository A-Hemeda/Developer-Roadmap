import 'package:booking_app/core/component/custom_text.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/build_book_cancel_item.dart';


class ViewHotelDetails extends StatelessWidget {
  const ViewHotelDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        elevation: 0,
        title: const CustomText(
          text: 'Grand Royal Hotel',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        actions: const [
          Icon(Icons.favorite_border_rounded,color: AppColors.white,),
          SizedBox(width: 15,),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>  BuildBooKingOrCancelItem(
            roomName: 'Deluxe Room',
            image: 'https://images.ctfassets.net/hrltx12pl8hq/a2hkMAaruSQ8haQZ4rBL9/8ff4a6f289b9ca3f4e6474f29793a74a/nature-image-for-website.jpg?fit=fill&w=1024&h=683&fm=webp',
            isBooking: index%2==0?false:true,
            price: 180,
            people: 2,
            children: 2,),
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
