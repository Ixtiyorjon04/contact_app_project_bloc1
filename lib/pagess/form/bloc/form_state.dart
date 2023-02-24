part of 'form_bloc.dart';

@immutable
class FormjonState {
  final Status status;
  final RegionModel region;
  final DistrictModel district;
  final BrandsModel brands;
  final ModelModel model;

  const FormjonState({
    this.status = Status.initial,
    required this.region,
    required this.district,
    required this.brands,
    required this.model
  });

  FormjonState copyWith({
    Status? status,
    RegionModel? region,
    DistrictModel? district,
    BrandsModel? brands,
    ModelModel? model,
  }) {
    return FormjonState(
      status: status ?? this.status,
      region: region ?? this.region,
      district: district ?? this.district,
      brands: brands ?? this.brands,
      model: model ?? this.model,
    );
  }
}

enum Status { initial, loading, success, fail }
