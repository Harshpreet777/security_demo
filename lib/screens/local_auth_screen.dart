import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalScreen extends StatefulWidget {
  const LocalScreen({super.key});

  @override
  State<LocalScreen> createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  final auth = LocalAuthentication();
  

  Future<bool> checkBioAuth() async {
    final isAvailable = await auth.canCheckBiometrics;
   final isSupported = await auth.isDeviceSupported();
    return isAvailable&& isSupported;
  }

  Future<bool> bioAuth() async {
    final isAuthAvailable = await checkBioAuth();
    if (isAuthAvailable == false) {
      return false;
    }
    try {
      return await auth.authenticate(
          localizedReason: 'Touch your finger on the sensor to login');
    } catch (e) {
      log('error is $e');
      return false;
    }
  }

  Future<void> getBio() async {
    List<BiometricType> availableBio = await auth.getAvailableBiometrics();
    log('Available Biometrics are $availableBio');
  }

  @override
  void initState() {
    
    bioAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ElevatedButton(onPressed: getBio, child: const Text('Biometrics'))
          ],
        ),
      ),
    );
  }
}
