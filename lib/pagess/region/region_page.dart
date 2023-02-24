
import 'package:contact_app_project_bloc/core/api/form_api.dart';
import 'package:contact_app_project_bloc/core/models/region_model.dart';
import 'package:flutter/material.dart';




class RegionPage extends StatefulWidget {
  final Function(RegionModel region)? callback;

  const RegionPage({Key? key, this.callback}) : super(key: key);

  Widget get page => this;

  @override
  State<RegionPage> createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  final api = FormApi();
  var regions = <RegionModel>[];
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
      regions = await api.regions();
      loading = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Regions")),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: regions.length,
            separatorBuilder: (_, i) => const Divider(thickness: 2),
            itemBuilder: (_, i) {
              final model = regions[i];
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
