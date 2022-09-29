part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchHotelLoadingState extends SearchState {}

class SearchHotelSuccessState extends SearchState {}

class SearchHotelErrorState extends SearchState {
  final String error;

  SearchHotelErrorState({required this.error});
}
