
import 'package:flutter/material.dart';

import '../../core/api/form_api.dart';
import '../../core/models/distict_model.dart';
import '../../core/models/region_model.dart';

class DistrictsPage extends StatefulWidget {
  final Function(DistrictModel districts)? callback;
  int id;

   DistrictsPage({Key? key, this.callback,required this.id}) : super(key: key);

  Widget get page => this;

  @override
  State<DistrictsPage> createState() => _DistrictsPageState();
}

class _DistrictsPageState extends State<DistrictsPage> {
  final api = FormApi();
  var district = <DistrictModel>[];
  late RegionModel regionModel;
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
      district = await api.districts(widget.id);
      loading = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("District")),
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
                    model.title,
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
