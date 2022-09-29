import 'dart:io';
import 'package:booking_app/core/network/end_points.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/features/home/data/models/booking_hotel_model.dart';
import 'package:booking_app/features/home/data/models/get_booking_model.dart';
import 'package:booking_app/features/home/data/models/update_profile_model.dart';
import 'package:booking_app/features/home/domain/use_cases/booking_hotel_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/get_booking_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/usecases/usecase.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/features/home/data/models/profile_model.dart';
import 'package:booking_app/features/home/domain/entities/hotels_entity.dart';
import 'package:booking_app/features/home/domain/use_cases/get_profile_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app/features/home/domain/use_cases/get_home_data_usecase.dart';
import 'package:location/location.dart';
import '../../../../core/component/toast.dart';
import '../../../../core/local/cache_helper.dart';
import '../../../../core/routes/routes_manager.dart';
import '../../data/models/update_book_model.dart';
import '../screens/exploreScreen/exploreScreen.dart';
import '../screens/profileScreen/profileScreen.dart';
import '../screens/trips/presentation/screens/trips_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase homeDataUseCase;
  final GetProfileDataUseCase profileDataUseCase;
  final UpdateProfileDataUseCase updateProfileDataUseCase;
  final BookingHotelUseCase bookingHotelUseCase;
  final GetBookingUseCase bookingUseCase;

  HomeCubit({
    required this.homeDataUseCase,
    required this.profileDataUseCase,
    required this.updateProfileDataUseCase,
    required this.bookingHotelUseCase,
    required this.bookingUseCase,
  }) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const ExploreScreen(),
    const TripsScreen(),
    const ProfileScreen(),
  ];

  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<Widget> bottomItems = [
    const Icon(Icons.search),
    const Icon(Icons.favorite),
    const Icon(Icons.person),
  ];

  String _mapFailureToMsg({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case EmptyCacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }

  HotelsEntity? hotelsEntity;
  List<DataHotelEntity> list = [];
  int lastPage = 1;
  int total = 0;
  int currentPage = 1;

  void getHomeData({
    bool isForce = false,
  }) {
    // if (isForce) {
    //   list = [];
    //   currentPage = 1;
    // }
    emit(GetHomeDataLoadingState());
    homeDataUseCase.call(params: NoParams(), page: currentPage).then((value) {
      value.fold((failure) {
        return emit(
            GetHomeDataErrorState(error: _mapFailureToMsg(failure: failure)));
      }, (hotelEntity) {
        hotelsEntity = hotelEntity;
        // list.addAll(hotelEntity.homeEntity.data);
        // currentPage++;
        //
        // if (lastPage == 1) {
        //   lastPage = hotelEntity.homeEntity.lastPage;
        // }

        isEnd = false;
        return emit(GetHomeDataSuccessState());
      });
    });
  }

  bool isEnd = false;

  void toggleIsEnd() {
    isEnd = !isEnd;
    emit(ToggleIsEndState());
  }

  dynamic signOut(context) async {
    await CacheHelper.clearData('token').then((value) {
      if (value) {
        Navigator.pushReplacementNamed(
          context,
          Routes.loginRoute,
        );
      }
    });
  }

  ProfileModel? profileModel;

  void getProfileData() {
    var token = CacheHelper.getData(key: AppStrings.token);
    emit(GetProfileDataLoadingState());
    profileDataUseCase.call(NoParams()).then((value) {
      value.fold((failure) {
        return emit(GetProfileDataErrorState(
            error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        profileModel = model;
        return emit(GetProfileDataSuccessState());
      });
    });
  }

  File? userImage;
  final ImagePicker picker = ImagePicker();

  Future<void> addProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      emit(SuccessGetUserImageState());
    } else {
      debugPrint('No Image Selected');
      emit(ErrorGetUserImageState());
    }
  }

  UpdateProfileModel? updateProfileModel;

  void updateProfileData({required UpdateImageEntity updateImageEntity}) {
    emit(UpdateProfileDataLoadingState());
    updateProfileDataUseCase
        .call(UpdateImageEntity(updateImageEntity.name, updateImageEntity.email,
            updateImageEntity.image))
        .then((value) {
      value.fold((failure) {
        return emit(UpdateProfileDataErrorState(
            error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        updateProfileModel = model;
        getProfileData();
        return emit(UpdateProfileDataSuccessState());
      });
    });
  }

  GetBookingModel? upComingModel;
  GetBookingModel? cancelledModel;
  GetBookingModel? completedModel;

  void getUpcomingBooking() {
    emit(GetBookingDataLoadingState());
    bookingUseCase.call(type: 'upcomming').then((value) {
      value.fold((failure) {
        return emit(GetBookingDataErrorState(
            error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        upComingModel = model;
        return emit(GetBookingDataSuccessState());
      });
    });
  }

  void getCancelledBooking() {
    emit(GetCancelBookingDataLoadingState());
    bookingUseCase.call(type: 'cancelled').then((value) {
      value.fold((failure) {
        return emit(GetCancelBookingDataErrorState(
            error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        cancelledModel = model;
        return emit(GetCancelBookingDataSuccessState());
      });
    });
  }

  void getCompletedBooking() {
    emit(GetCompletedBookingDataLoadingState());
    bookingUseCase.call(type: 'completed').then((value) {
      value.fold((failure) {
        return emit(GetCompletedBookingDataErrorState(
            error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        completedModel = model;
        return emit(GetCompletedBookingDataSuccessState());
      });
    });
  }

  BookingHotelModel? bookingHotelModel;

  void bookAHotel({required String hotelId}) {
    emit(BookingHotelLoadingState());
    bookingHotelUseCase.call(hotelId: hotelId).then((value) {
      value.fold((failure) {
        return emit(
            BookingHotelErrorState(error: _mapFailureToMsg(failure: failure)));
      }, (model) {
        bookingHotelModel = model;
        return emit(BookingHotelSuccessState(bookingHotelModel!.en));
      });
    });
  }

  UpdateBookModel? updateBookModel;

  void updateBooking({required int hotelId, required String type}) {
    emit(UpdateBookingLoadingState());
    DioHelper.postData(url: updateBookingEndPoint, data: {
      "booking_id": hotelId,
      "type": type,
    }).then((value) {
      updateBookModel = UpdateBookModel.fromJson(value.data);
      showToast(text: updateBookModel!.en, state: ToastStates.success);
      emit(UpdateBookingSuccessState());
    }).catchError((error) {
      emit(UpdateBookingErrorState(error: error.toString()));
    });
  }

  Future<void> getCurrentPosition() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
  }
}
