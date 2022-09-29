import 'package:booking_app/core/local/cache_helper.dart';
import 'package:booking_app/core/network/info.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/features/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:booking_app/features/auth/login/data/repositories/login_repository_impl.dart';
import 'package:booking_app/features/auth/login/domain/repositories/base_login_repository.dart';
import 'package:booking_app/features/auth/login/domain/use_cases/login_email_usecase.dart';
import 'package:booking_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booking_app/features/auth/register/data/data_sources/register_remote_data_source.dart';
import 'package:booking_app/features/auth/register/data/repositories/register_repository_impl.dart';
import 'package:booking_app/features/auth/register/domain/repositories/base_register_repository.dart';
import 'package:booking_app/features/auth/register/domain/use_cases/register_email_usecase.dart';
import 'package:booking_app/features/auth/register/presentation/cubit/user_register_cubit.dart';
import 'package:booking_app/features/home/data/data_sources/home_local_data_source.dart';
import 'package:booking_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:booking_app/features/home/data/repositories/home_data_repo_impl.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:booking_app/features/home/domain/use_cases/booking_hotel_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/get_booking_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/get_home_data_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/get_profile_data_usecase.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';
import 'package:booking_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:booking_app/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:booking_app/features/search/data/repositories/search_repo_impl.dart';
import 'package:booking_app/features/search/domain/repositories/search_hotel_repo.dart';
import 'package:booking_app/features/search/domain/use_cases/search_hotel_usecase.dart';
import 'package:booking_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  DioHelper();
  CacheHelper.init();

  sl.registerFactory(() => UserRegisterCubit(registerWithEmailUseCase: sl()));
  sl.registerFactory(() => HomeCubit(
        homeDataUseCase: sl(),
        profileDataUseCase: sl(),
        updateProfileDataUseCase: sl(),
        bookingUseCase: sl(),
        bookingHotelUseCase: sl(),
      ));
  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => SearchCubit(searchHotelUseCase: sl()));

  sl.registerLazySingleton(
      () => RegisterWithEmailUseCase(registerRepository: sl()));
  sl.registerLazySingleton(() => GetHomeDataUseCase(homeDataRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(
      () => SearchHotelUseCase(searchHotelRepository: sl()));
  sl.registerLazySingleton(
      () => GetProfileDataUseCase(homeDataRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateProfileDataUseCase(homeDataRepository: sl()));

  sl.registerLazySingleton(() => GetBookingUseCase(homeDataRepository: sl()));
  sl.registerLazySingleton(() => BookingHotelUseCase(homeDataRepository: sl()));

  sl.registerLazySingleton<BaseRegisterRepository>(
      () => RegisterRepositoryImpl(registerRemoteDataSource: sl()));
  sl.registerLazySingleton<BaseHomeDataRepository>(() => HomeDataRepositoryImpl(
        homeDataLocalDataSource: sl(),
        homeDataRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<BaseLoginRepository>(
      () => LoginRepositoryImpl(loginRemoteDataSource: sl()));
  sl.registerLazySingleton<BaseSearchHotelRepository>(() =>
      SearchHotelRepositoryImpl(
          searchRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<BaseRegisterRemoteDataSource>(
      () => RegisterRemoteDataSource());

  sl.registerLazySingleton<BaseHomeDataRemoteDataSource>(
      () => HomeDataRemoteDataSource());

  sl.registerLazySingleton<BaseHomeDataLocalDataSource>(
      () => HomeDataLocalDataSourceImpl());

  sl.registerLazySingleton<BaseLoginRemoteDataSource>(
      () => LoginRemoteDataSource());

  sl.registerLazySingleton<BaseSearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl());

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
