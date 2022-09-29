import 'dart:io';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/home/data/models/update_profile_model.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileDataUseCase {
  final BaseHomeDataRepository homeDataRepository;

  UpdateProfileDataUseCase({required this.homeDataRepository});

  Future<Either<Failure, UpdateProfileModel>> call(
      UpdateImageEntity updateImageEntity) async {
    return await homeDataRepository.updateProfileData(
        updateImageEntity: updateImageEntity);
  }
}

class UpdateImageEntity extends Equatable {
  final String name;
  final String email;
  final File? image;

  const UpdateImageEntity(this.name, this.email, this.image);

  @override
  List<Object> get props => [name, email, image!];
}
