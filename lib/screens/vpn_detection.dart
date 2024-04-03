
import 'dart:io';

class CheckVpnConnection {

  static Future<bool> isVpnActive() async {
    bool isVpnActive;
    List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false, type: InternetAddressType.any);
    interfaces.isNotEmpty
        ? isVpnActive = interfaces.any((interface) =>
            interface.name.contains("tun") ||
            interface.name.contains("ppp") ||
            interface.name.contains("tap") ||
            interface.name.contains("l2tp") ||
            interface.name.contains("ipsec") ||
            interface.name.contains("vpn") ||
            interface.name.contains("wireguard") ||
            interface.name.contains("openvpn") ||
            interface.name.contains("softether") ||
            interface.name.contains("tun") ||
            interface.name.contains("pptp"))
        : isVpnActive = false;
    return isVpnActive;
  }
}