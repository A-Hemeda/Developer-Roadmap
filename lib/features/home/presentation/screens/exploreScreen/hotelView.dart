import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/component/my_button.dart';
import '../../../../../core/component/my_text.dart';
import '../../../../../core/component/toast.dart';
import '../../../../../core/services/maps.dart';
import '../../../../../core/utilis/constants/assets_manager.dart';
import '../../../../../core/utilis/constants/colors.dart';
import '../../../../../core/utilis/constants/values_manger.dart';

class HotelView extends StatefulWidget {
  final String hotelName;
  final String locationName;
  final String rate;
  final String price;
  final String image;
  final String lat;
  final String long;
  final int id;

  const HotelView(
      {Key? key,
      required this.hotelName,
      required this.locationName,
      required this.rate,
      required this.price,
      required this.image,
      required this.id,
      required this.lat,
      required this.long})
      : super(key: key);

  @override
  State<HotelView> createState() => _HotelViewState();
}

class _HotelViewState extends State<HotelView> {
  late ScrollController _scrollController;
  bool _appBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 480) {
        setState(() {
          _appBarCollapsed = false;
        });
      } else {
        setState(() {
          _appBarCollapsed = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<String> _hotelPhoto = [
    ImageAssets.hotelPhoto,
    ImageAssets.hotelPhoto1,
    ImageAssets.hotelPhoto2,
    ImageAssets.hotelPhoto3,
    ImageAssets.hotelPhoto4,
    ImageAssets.hotelPhoto5,
    ImageAssets.swimmingpool,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          body: DefaultTabController(
            length: 1,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leadingWidth: 50,
                    pinned: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        HomeCubit.get(context).getHomeData();
                      },
                      icon: const CircleAvatar(
                        backgroundColor: AppColors.cardColors,
                        child: Icon(
                          Icons.arrow_back,
                          size: AppSize.s20,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: AppColors.black,
                          child: Icon(
                            Icons.favorite_border,
                            size: AppSize.s20,
                            color: AppColors.teal,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: AppColors.transparent,
                        statusBarIconBrightness: Brightness.dark),
                    expandedHeight: AppSize.s711,
                    collapsedHeight: AppSize.s70,
                    actionsIconTheme: const IconThemeData(opacity: AppSize.s0),
                    flexibleSpace: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 3,
                            height: double.infinity,
                          ),
                        ),
                        if (_appBarCollapsed == false)
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: AppColors.cardColors,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(AppPadding.p20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            text: widget.hotelName,
                                            fontSize: AppSize.s20,
                                          ),
                                          const SizedBox(
                                            height: AppSize.s5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: MyText(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: widget.locationName,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900,
                                                  colors: AppColors.white74,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.location_on,
                                                color: AppColors.teal,
                                                size: 11,
                                              ),
                                              const MyText(
                                                  text: "2.0 Km to City",
                                                  fontSize: 14,
                                                  colors: AppColors.white74),
                                              const Spacer(),
                                              MyText(
                                                text: "\$${widget.price}",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                itemSize: 18,
                                                initialRating:
                                                    double.parse(widget.rate) /
                                                        2,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: AppColors.teal,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                              const SizedBox(
                                                width: AppSize.s5,
                                              ),
                                              const MyText(
                                                text: "80 Reviews",
                                                fontSize: 16,
                                                colors: AppColors.white74,
                                              ),
                                              const Spacer(),
                                              const MyText(
                                                text: "/per night",
                                                fontSize: 16,
                                                colors: AppColors.white74,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: AppSize.s10,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: AppSize.s50,
                                              child: BlocConsumer<HomeCubit,
                                                  HomeState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is BookingHotelSuccessState) {
                                                    showToast(
                                                        text: state.message,
                                                        state: ToastStates
                                                            .success);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  var cubit =
                                                      HomeCubit.get(context);

                                                  return MyButton(
                                                    onPressed: () {
                                                      cubit.bookAHotel(
                                                          hotelId: widget.id
                                                              .toString());
                                                      HomeCubit.get(context)
                                                          .getHomeData();
                                                    },
                                                    label: AppStrings.bookNow,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: AppSize.s18,
                                                    radius: AppPadding.p10,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: AppSize.s145,
                                    height: AppSize.s40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppPadding.p100),
                                      color: AppColors.cardColors,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        jumpTo();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            AppStrings.moreDetails,
                                            style: TextStyle(
                                              color: AppColors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            color: AppColors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_appBarCollapsed == true) Container(),
                      ],
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: widget.hotelName,
                              fontSize: AppSize.s20,
                            ),
                          ),
                          const Spacer(),
                          MyText(
                            text: "\$${widget.price}",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          const MyText(
                            text: " /per night",
                            colors: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      MyText(
                        overflow: TextOverflow.ellipsis,
                        text: widget.locationName,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        colors: AppColors.white74,
                      ),
                      const SizedBox(
                        height: AppSize.s5,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: AppColors.teal,
                            size: 11,
                          ),
                          MyText(
                              text: "2.0 Km to City",
                              fontSize: 14,
                              colors: AppColors.white74),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      const Divider(
                        height: 0.5,
                        color: AppColors.grey,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      const MyText(text: 'Summary', fontSize: 20),
                      const SizedBox(
                        height: AppSize.s5,
                      ),
                      const MyText(
                        text:
                            'Featuring a fitness center, Grand Royale Park Hotel is Located in Sweden 4.7 km frome National Museum a fitness center,',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        colors: AppColors.grey,
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      SizedBox(
                        height: 145,
                        width: double.infinity,
                        child: Card(
                          color: AppColors.darkGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      text: widget.rate,
                                      fontSize: 30,
                                      colors: AppColors.teal,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const MyText(
                                      text: 'Overall rating',
                                      fontSize: 13,
                                      colors: AppColors.grey,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const MyText(
                                      text: 'Room',
                                      fontSize: 15,
                                      colors: AppColors.grey,
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 200,
                                      color: AppColors.teal,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const MyText(
                                      text: 'services',
                                      fontSize: 15,
                                      colors: AppColors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 170,
                                      color: AppColors.teal,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const MyText(
                                      text: 'Location',
                                      fontSize: 15,
                                      colors: AppColors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 100,
                                      color: AppColors.teal,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const MyText(
                                      text: 'Price',
                                      fontSize: 15,
                                      colors: AppColors.grey,
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 180,
                                      color: AppColors.teal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Row(
                        children: const [
                          MyText(
                            text: "Photo",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            colors: AppColors.white,
                          ),
                          Spacer(),
                          MyText(
                            text: AppStrings.viewAll,
                            colors: AppColors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s140,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p5),
                          child: ListView.separated(
                            itemCount: _hotelPhoto.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                width: 100,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppPadding.p100)),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Image.asset(
                                        _hotelPhoto[index],
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: AppSize.s15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Row(
                        children: const [
                          MyText(
                            text: "Reviews",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            colors: AppColors.white,
                          ),
                          Spacer(),
                          MyText(
                            text: AppStrings.viewAll,
                            colors: AppColors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 60,
                                    width: 60,
                                    child: const Image(
                                        image:
                                            AssetImage(ImageAssets.profile))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    MyText(
                                      text: 'Alexia Jane',
                                      fontSize: 15,
                                    ),
                                    MyText(
                                      text: 'last Update 27 Sep 2022',
                                      fontSize: 10,
                                      colors: AppColors.grey,
                                    ),
                                    MyText(
                                      text: '(8.0)',
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "This is located in a great Spot close to the shops and bars, very quiet locations.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 60,
                                    width: 60,
                                    child: const Image(
                                        image:
                                            AssetImage(ImageAssets.profile))),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    MyText(
                                      text: 'Jacky Dep',
                                      fontSize: 15,
                                    ),
                                    MyText(
                                      text: 'last Update 29 Sep 2022',
                                      fontSize: 10,
                                      colors: AppColors.grey,
                                    ),
                                    MyText(
                                      text: '(10.0)',
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Good staff, very comfortable bed, very quiet location, place could do with an update.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Maps(
                            lat: widget.lat,
                            long: widget.long,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: AppSize.s50,
                          child: BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {
                              if (state is BookingHotelSuccessState) {
                                showToast(
                                    text: state.message,
                                    state: ToastStates.success);
                              }
                            },
                            builder: (context, state) {
                              var cubit = HomeCubit.get(context);

                              return MyButton(
                                onPressed: () {
                                  cubit.bookAHotel(
                                      hotelId: widget.id.toString());
                                  HomeCubit.get(context).getHomeData();
                                },
                                label: AppStrings.bookNow,
                                fontWeight: FontWeight.normal,
                                fontSize: AppSize.s18,
                                radius: AppPadding.p10,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void jumpTo() {
    final _maxExtent = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      _maxExtent * 0.85, // scrolls to 85% of maxScrollExtent
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
