import 'package:booking_app/core/app_localization/app_localization.dart';
import 'package:booking_app/core/component/others.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/core/utilis/constants/constats_manager.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/routes/routes_manager.dart';
import '../../../../../core/utilis/constants/assets_manager.dart';
import '../../../../../core/utilis/constants/colors.dart';
import '../../../../../core/utilis/constants/values_manger.dart';
import '../../../../../core/component/my_button.dart';
import '../../../../../core/component/my_text.dart';
import '../../../../../core/component/my_text_form_field.dart';
import '../../../../search/presentation/screens/filterSearch/filterSearch.dart';
import '../../widgets/hotelCardItem.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late ScrollController _scrollController;
  bool _appBarCollapsed = true;
  final _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getHomeData();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 200) {
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

  final _controller = TextEditingController();

  final List<String> _images = [
    ImageAssets.hotel6,
    ImageAssets.hotel2,
    ImageAssets.hotel,
  ];
  final List<String> _popularDestination = [
    ImageAssets.egypt,
    ImageAssets.paris,
    ImageAssets.london,
    ImageAssets.spain,
  ];
  final List<String> _popularDestinationNames = [
    "Egypt",
    "French",
    "England",
    "Germany",
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: AppColors.kPrimaryColor,
                expandedHeight: AppSize.s500,
                collapsedHeight: AppSize.s172,
                actionsIconTheme: const IconThemeData(opacity: AppSize.s0),
                flexibleSpace: Stack(
                  children: <Widget>[
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: _images.length,
                      options: CarouselOptions(
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        height: double.infinity,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(
                            seconds: AppConstants.autoPlayInterval),
                        autoPlayAnimationDuration: const Duration(
                            milliseconds: AppConstants.sliderAnimationTime),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Image(
                          image: AssetImage(_images[index]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppSize.s30,
                          right: AppSize.s20,
                          left: AppSize.s20,
                          bottom: AppSize.s20),
                      child: Column(
                        children: [
                          Container(
                            height: AppSize.s50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s30),
                              color: AppColors.darkGrey,
                            ),
                            child: MyTextForm(
                              enableBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: AppColors.transparent)),
                              readOnly: true,
                              onTap: () {
                                Navigator.pushNamed(context, Routes.search);
                              },
                              isDense: true,
                              controller: _controller,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.teal,
                                ),
                              ),
                              hintText: AppStrings.whereAreYouGoing.tr(context),
                              radius: AppSize.s30,
                            ),
                          ),
                          const Spacer(),
                          if (_appBarCollapsed == true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyText(
                                  text: AppStrings.capTown,
                                  fontSize: AppSize.s35,
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                const MyText(
                                    text: AppStrings.extraordinary,
                                    fontSize: AppSize.s20),
                                const SizedBox(
                                  height: AppSize.s15,
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: MyButton(
                                          label:
                                              AppStrings.viewHotel.tr(context),
                                          radius: AppSize.s100,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          onPressed: () {
                                            navigateTo(
                                                context: context,
                                                widget: FilterPage());
                                          }),
                                    ),
                                    const Spacer(),
                                    AnimatedSmoothIndicator(
                                      activeIndex: _current,
                                      count: _images.length,
                                      effect: const ExpandingDotsEffect(
                                          activeDotColor: AppColors.teal,
                                          dotWidth: 8,
                                          dotHeight: 8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          if (_appBarCollapsed == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedSmoothIndicator(
                                  activeIndex: _current,
                                  count: _images.length,
                                  effect: const ExpandingDotsEffect(
                                      activeDotColor: AppColors.teal,
                                      dotWidth: 8,
                                      dotHeight: 8),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      text: AppStrings.popularDestination.tr(context),
                      fontSize: AppSize.s20,
                      colors: AppColors.white),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  SizedBox(
                    height: AppSize.s140,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p5),
                      child: ListView.separated(
                        itemCount: _popularDestination.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: AppSize.s100,
                            width: AppSize.s300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Image.asset(
                                  _popularDestination[index],
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppPadding.p20,
                                        top: AppPadding.p10),
                                    child: MyText(
                                      text: _popularDestinationNames[index],
                                      fontSize: AppSize.s25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: AppSize.s15,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: AppStrings.bestDeals.tr(context),
                        fontSize: AppSize.s20,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: MyText(
                          text: AppStrings.viewAll.tr(context),
                          fontSize: AppSize.s16,
                          colors: AppColors.teal,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.teal,
                      ),
                    ],
                  ),
                  const CardOfHotel(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
