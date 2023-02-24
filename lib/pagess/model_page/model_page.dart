import 'package:contact_app_project_bloc/core/models/brand_model.dart';
import 'package:contact_app_project_bloc/core/models/model_model.dart';

import 'package:flutter/material.dart';

import '../../core/api/form_api.dart';

class ModelPage extends StatefulWidget {
  final Function(ModelModel model)? callback;
  String id;

  ModelPage({Key? key, this.callback,required this.id}) : super(key: key);

  Widget get page => this;

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final api = FormApi();
  var district = <ModelModel>[];
  late BrandsModel regionModel;
  var loading = false;

  @override
  void initState() {
    loadRegions();
    super.initState();
  }

  Future<void> loadRegions() async {
    loading = true;
    setState(() {});
    try {
      district = await api.models(widget.id);
      loading = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Model")),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: district.length,
            separatorBuilder: (_, i) => const Divider(thickness: 2),
            itemBuilder: (_, i) {
              final model = district[i];
              return GestureDetector(
                onTap: () {
                  widget.callback?.call(model);
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.name,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
