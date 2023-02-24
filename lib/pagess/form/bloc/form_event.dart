part of 'form_bloc.dart';

@immutable
abstract class FormEvent {}

class FormChangedEvent extends FormEvent {
  final RegionModel? region;
  final DistrictModel? district;
  final BrandsModel? brands;
  final ModelModel? model;


  FormChangedEvent({this.region, this.district,this.brands,this.model});
}

// class FormDistrictsEvent extends FormEvent {
//   final int regionId;
//
//   FormDistrictsEvent(this.regionId);
// }
//
// class FormBrandsEvent extends FormEvent {}
//
// class FormModelsEvent extends FormEvent {
//   final int brandId;
//
//   FormModelsEvent(this.brandId);
// }
