import 'package:contact_app_project_bloc/pages/home_page.dart';
import 'package:contact_app_project_bloc/pagess/form/form_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('shopping_box');
  await Hive.openBox('contact');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:   const FormPage().page,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [];

  final _shoppingBox = Hive.box('contact');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    final data = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key);
      return {"key": key, "name": value["name"], "number": value['number']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _shoppingBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> _readItem(int key) {
    final item = _shoppingBox.get(key);
    return item;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _shoppingBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _shoppingBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An contact has been deleted')));
  }

  // TextFields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
      _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _numberController.text = existingItem['number'];
    }

    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
              top: 15,
              left: 15,
              right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () async {
                    // Save new item
                    if (itemKey == null) {
                      _createItem({
                        "name": _nameController.text,
                        "number": _numberController.text
                      });
                    }

                    // update an existing item
                    if (itemKey != null) {
                      _updateItem(itemKey, {
                        'name': _nameController.text.trim(),
                        'number': _numberController.text.trim()
                      });
                    }

                    // Clear the text fields
                    _nameController.text = '';
                    _numberController.text = '';

                  // Close the bottom sheet
                  },
                  child: Center(child: Text(itemKey == null ? 'Create New' : 'Update',style: TextStyle(color: Colors.black),),),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Number'),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 120,
                child: ElevatedButton(

                  onPressed: () async {
                    // Save new item
                    if (itemKey == null) {
                      _createItem({
                        "name": _nameController.text,
                        "number": _numberController.text
                      });
                    }

                    // update an existing item
                    if (itemKey != null) {
                      _updateItem(itemKey, {
                        'name': _nameController.text.trim(),
                        'number': _numberController.text.trim()
                      });
                    }

                    // Clear the text fields
                    _nameController.text = '';
                    _numberController.text = '';

                    Navigator.of(context).pop(); // Close the bottom sheet
                  },

                  child: Center(child: Text("Save")),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),centerTitle: true,
      ),
      body: _items.isEmpty
          ? const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 30),
        ),
      )
          : ListView.builder(
        // the list of items
          itemCount: _items.length,
          itemBuilder: (_, index) {
            final currentItem = _items[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                  title: Text(currentItem['name']),
                  subtitle: Text(currentItem['number'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showForm(context, currentItem['key'])),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(currentItem['key']),
                      ),
                    ],
                  )),
            );
          }),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
