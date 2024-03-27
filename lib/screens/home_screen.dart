import 'package:flutter/material.dart';
import 'package:security_demo/screens/secure_storage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: 'Enter Something to Store',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  SecureStorage().writeSecureData('name', controller.text);
                  controller.clear();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: const Text(
                  'Store Message',
                  style: TextStyle(color: Colors.white),
                )),
                ElevatedButton(
                onPressed: () {
                  SecureStorage().readSecureData('name');

                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: const Text(
                  'Read Message',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
