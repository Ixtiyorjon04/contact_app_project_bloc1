import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class InputPage extends StatefulWidget {
  final Function(String name, String phone)? callback;

  const InputPage({Key? key, this.callback}) : super(key: key);

  Widget get page => this;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InputPage")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  WidgetTextField(
                    controller: nameController,
                    hintText: "Ism",
                  ),
                  const SizedBox(height: 12),
                  WidgetTextField(
                    controller: phoneController,
                    hintText: "+9989...",
                  ),
                ],
              ),
            ),
          ),
          WidgetButton(
            text: "Saqlash",
            onTap: () {
              widget.callback?.call(nameController.text, phoneController.text);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
