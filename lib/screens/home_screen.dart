import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:security_demo/screens/secure_storage_screen.dart';
import 'package:security_demo/screens/vpn_detection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isjailBroken = false;
  bool isRoot = false;
  bool isVpn = false;
  bool isScreenShotTaken = false;

  getRootDetails() async {
    isjailBroken = await FlutterJailbreakDetection.jailbroken;
    isRoot = await FlutterJailbreakDetection.developerMode;
  }

  getVpnDetails() async {
    bool value = await CheckVpnConnection.isVpnActive();
    setState(() {
      isVpn = value;
    });
  }

  preventLeakage() async {
    await ScreenProtector.protectDataLeakageOn();
  }

  disposeLeakage() async {
    await ScreenProtector.protectDataLeakageOff();
  }

  @override
  void initState() {
    preventLeakage();
    getVpnDetails();
    getRootDetails();
    super.initState();
  }

  @override
  void dispose() {
    disposeLeakage();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isScreenShotTaken == true
                ? const Text('ScreenShot taken')
                : const SizedBox(),
            isRoot == true
                ? const Text('Device Rooted')
                : const Text('Device Not Rooted'),
            isVpn == true
                ? const Text('VPN connection found')
                : const Text('VPN not connected'),
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
                  getVpnDetails();
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
