import 'package:booking_app/core/component/others.dart';
import 'package:booking_app/core/network/end_points.dart';
import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/view_hotel_details.dart';
import 'build_upcoming_item.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({Key? key}) : super(key: key);

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  @override
  void initState() {
    HomeCubit.get(context).getUpcomingBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var upcomingItem = HomeCubit.get(context);
        if (state is GetBookingDataLoadingState) {
          return const Center(child: CupertinoActivityIndicator(color: AppColors.white,));
        }
        else  if (state is GetBookingDataErrorState || upcomingItem.upComingModel!.bookingData.isEmpty)
          {
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

          {return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      navigateTo(context: context, widget: const ViewHotelDetails());
                    },
                    child: BuildUpcomingItem(
                      id: upcomingItem.upComingModel!.bookingData[index].id,
                      urlImage: imageBaseUrl+ upcomingItem.upComingModel!.bookingData[index].hotel!.images[0].image,
                      startDate: '25 Sep',
                      endDate: '29 Sep',
                      roomsNumber: index + 1,
                      peopleNumber: (index + 1) * 2,
                      isFavorite: index % 2 == 0 ? false : true,
                      hotelName: upcomingItem.upComingModel!.bookingData[index].hotel!.name.toString(),
                      city: upcomingItem.upComingModel!.bookingData[index].hotel!.address.toString(),
                      day: 'Sunday',
                      location: '$index.0km to ${upcomingItem.upComingModel!.bookingData[index].hotel!.name}',
                      price: upcomingItem.upComingModel!.bookingData[index].hotel!.price.toString(),
                      initialRating: double.parse(upcomingItem.upComingModel!.bookingData[index].hotel!.rate!) / 2,
                    ),
                  );
                },
                itemCount: upcomingItem.upComingModel!.bookingData.length,
              ),
            );
          }
        }
    );
  }
}