import 'package:booking_app/core/component/others.dart';
import 'package:booking_app/core/network/end_points.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:booking_app/features/home/presentation/screens/trips/presentation/screens/view_hotel_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utilis/constants/assets_manager.dart';
import 'build_finished_item.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({Key? key}) : super(key: key);

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  @override
  void initState() {
    HomeCubit.get(context).getCompletedBooking();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var upcomingItem = HomeCubit.get(context);
        if (state is GetCompletedBookingDataSuccessState) {
          if (upcomingItem.completedModel!.bookingData.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      navigateTo(context: context, widget: const ViewHotelDetails());
                    },
                    child: BuildFinishedItem(
                      urlImage: imageBaseUrl+ upcomingItem.completedModel!.bookingData[index].hotel!.images[0].image,
                      startDate: '25 Sep',
                      endDate: '29 Sep',
                      roomsNumber: index + 1,
                      peopleNumber: (index + 1) * 2,
                      hotelName: upcomingItem
                          .completedModel!.bookingData[index].hotel!.name
                          .toString(),
                      city: upcomingItem
                          .completedModel!.bookingData[index].hotel!.address
                          .toString(),
                      day: 'Sunday',
                      location: '$index.0km to you city',
                      price: upcomingItem.completedModel!.bookingData[index].hotel!.price
                          .toString(),
                      initialRating: double.parse(upcomingItem
                          .completedModel!.bookingData[index].hotel!.rate!) / 2,
                    ),
                  );
                },
                itemCount: upcomingItem.completedModel!.bookingData.length,
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/empty.png',
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  const Text(
                    'No Booking Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CupertinoActivityIndicator(color: AppColors.white,));
        }
      },
    );
  }
}
