import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

const _disclamer = '''免責事項
本アプリケーションを使用したことによって生じた
いかなる損害についても、開発者は一切の責任を負いません。
''';

class LicenseInfoButton extends StatelessWidget {
  const LicenseInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final info = await PackageInfo.fromPlatform();
          if (context.mounted) {
            showLicensePage(
              context: context,
              applicationName: info.appName,
              applicationVersion: info.version,
              applicationLegalese: _disclamer,
            );
          }
        },
        icon: const Icon(Icons.info));
  }
}
