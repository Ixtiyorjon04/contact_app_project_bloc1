
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../brands_page/brands_page.dart';
import '../districts_page/districts_page.dart';
import '../model_page/model_page.dart';
import '../region/region_page.dart';
import 'bloc/form_bloc.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  Widget get page {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormBloc>();
    return BlocBuilder<FormBloc, FormjonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("FormPage")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RegionPage(
                          callback: (region) {
                            bloc.add(FormChangedEvent(region: region));
                          },
                        ).page;
                      },
                    ));
                  },
                  decoration: InputDecoration(
                    hintText:
                        state.region.id == 0 ? "Regions" : state.region.title,
                    hintStyle: TextStyle(
                      color: state.region.id == 0 ? Colors.grey : Colors.black,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DistrictsPage(
                          callback: (district) {
                            bloc.add(FormChangedEvent(district: district));
                          }, id: state.region.id,
                        ).page;
                      },
                    ));
                  },
                  decoration: InputDecoration(
                    hintText:
                    state.district.id == 0 ? "District" : state.district.title,
                    hintStyle: TextStyle(
                      color: state.district.id == 0 ? Colors.grey : Colors.black,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BrandsPage(
                          callback: (brands) {
                            bloc.add(FormChangedEvent(brands: brands));
                          },
                        ).page;
                      },
                    ));
                  },
                  decoration: InputDecoration(
                    hintText:
                    state.brands.id == "" ? "Brands" : state.brands.name,
                    hintStyle: TextStyle(
                      color: state.brands.id == "" ? Colors.grey : Colors.black,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ModelPage(
                          callback: (model) {
                            bloc.add(FormChangedEvent(model: model));
                          }, id: state.brands.id,
                        ).page;
                      },
                    ));
                  },
                  decoration: InputDecoration(
                    hintText:
                    state.model.id == "" ? "Model" : state.model.name,
                    hintStyle: TextStyle(
                      color: state.model.id == "" ? Colors.grey : Colors.black,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
