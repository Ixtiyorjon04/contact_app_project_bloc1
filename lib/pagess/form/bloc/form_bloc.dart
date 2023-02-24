import 'dart:async';

import 'package:bloc/bloc.dart';


import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/models/brand_model.dart';
import '../../../core/models/distict_model.dart';
import '../../../core/models/model_model.dart';
import '../../../core/models/region_model.dart';

part 'form_event.dart';

part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormjonState> {
  FormBloc()
      : super(FormjonState(
          region: RegionModel.empty(),
          district: DistrictModel.empty(),
          brands: BrandsModel.empty(),
          model: ModelModel.empty(),
        )) {
    on<FormChangedEvent>((event, emit) async {
      emit(state.copyWith(
        region: event.region,
        district: event.district,
        brands: event.brands,
        model: event.model,
      ));
      if (event.region != null && state.region.id != event.region?.id) {
        emit(state.copyWith(district: DistrictModel.empty()));
      }
      if (event.brands == "" && state.brands.id != event.brands?.id) {
        emit(state.copyWith(model: ModelModel.empty()));
      }
    });
  }
}
