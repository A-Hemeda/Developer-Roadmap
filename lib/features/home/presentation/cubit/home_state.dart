part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ToggleIsEndState extends HomeState {}

class GetHomeDataSuccessState extends HomeState {}

class GetHomeDataLoadingState extends HomeState {}

class GetHomeDataErrorState extends HomeState {
  final String error;

  GetHomeDataErrorState({required this.error});
}

class ChangeBottomNavState extends HomeState {}

class GetProfileDataSuccessState extends HomeState {}

class GetProfileDataLoadingState extends HomeState {}

class GetProfileDataErrorState extends HomeState {
  final String error;

  GetProfileDataErrorState({required this.error});
}

class SuccessGetUserImageState extends HomeState {}

class ErrorGetUserImageState extends HomeState {}

class UpdateProfileDataErrorState extends HomeState {
  final String error;

  UpdateProfileDataErrorState({required this.error});
}

class UpdateProfileDataSuccessState extends HomeState {}

class UpdateProfileDataLoadingState extends HomeState {}

class GetBookingDataErrorState extends HomeState {
  final String error;

  GetBookingDataErrorState({required this.error});
}

class GetBookingDataSuccessState extends HomeState {}

class GetBookingDataLoadingState extends HomeState {}

class GetCancelBookingDataErrorState extends HomeState {
  final String error;

  GetCancelBookingDataErrorState({required this.error});
}

class GetCancelBookingDataSuccessState extends HomeState {}

class GetCancelBookingDataLoadingState extends HomeState {}

class GetCompletedBookingDataErrorState extends HomeState {
  final String error;

  GetCompletedBookingDataErrorState({required this.error});
}

class GetCompletedBookingDataSuccessState extends HomeState {}

class GetCompletedBookingDataLoadingState extends HomeState {}

class BookingHotelErrorState extends HomeState {
  final String error;

  BookingHotelErrorState({required this.error});
}

class BookingHotelSuccessState extends HomeState {
  final String message;

  BookingHotelSuccessState(this.message);
}

class UpdateBookingErrorState extends HomeState {
  final String error;

  UpdateBookingErrorState({required this.error});
}

class UpdateBookingSuccessState extends HomeState {}

class UpdateBookingLoadingState extends HomeState {}

class BookingHotelLoadingState extends HomeState {}
