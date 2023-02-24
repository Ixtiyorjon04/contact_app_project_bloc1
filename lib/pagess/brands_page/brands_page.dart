import 'package:flutter/material.dart';

import '../../core/api/form_api.dart';
import '../../core/models/brand_model.dart';

class BrandsPage extends StatefulWidget {
  final Function(BrandsModel brands)? callback;

  const BrandsPage({Key? key, this.callback}) : super(key: key);

  Widget get page => this;

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  final api = FormApi();
  var brands = <BrandsModel>[];
  var loading = false;

  @override
  void initState() {
    loadbrands();
    super.initState();
  }

  Future<void> loadbrands() async {
    loading = true;
    setState(() {});

      brands = await api.brands();
      loading = false;
      setState(() {});

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brands")),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: brands.length,
            separatorBuilder: (_, i) => const Divider(thickness: 2),
            itemBuilder: (_, i) {
              final model = brands[i];
              return GestureDetector(
                onTap: () {
                  print("${brands.length}");
                  widget.callback?.call(model);
                  Navigator.pop(context);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(model.name),
                      leading: Text(model.value),
                      trailing: Text("${model.popular}"),
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
