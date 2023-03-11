import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

void showAboutScreen(BuildContext context, PackageInfo packageInfo) {
  var localizations = AppLocalizations.of(context);
  showAboutPage(
    context: context,
    values: {
      'year': DateTime.now().year.toString(),
    },
    title: Text(packageInfo.appName),
    applicationName: packageInfo.appName,
    applicationVersion: packageInfo.version,
    applicationIcon: SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(
        'assets/icon/app.png',
        fit: BoxFit.scaleDown,
      ),
    ),
    applicationLegalese: 'Copyright © Kirill Mokretsov, {{ year }}',
    applicationDescription: Center(
      child: Text(localizations!.description),
    ),
    children: <Widget>[
      MarkdownPageListTile(
        icon: const Icon(Icons.menu_book_outlined),
        title: Text(localizations.viewReadme),
        filename: "README.md",
      ),
      // TODO: add changelog
      MarkdownPageListTile(
        icon: const Icon(Icons.description),
        title: Text(localizations.viewLicense),
        filename: "LICENSE",
      ),
      // TODO: add contributing
      // TODO: add code of conduct
      LicensesPageListTile(
        icon: const Icon(Icons.favorite),
        title: Text(localizations.viewLibLicenses),
      ),
    ],
  );
}
