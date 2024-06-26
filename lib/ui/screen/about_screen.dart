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
    applicationLegalese: 'Copyright © Kira Sokolova, {{ year }}',
    applicationDescription: Center(
      child: Text(localizations!.description),
    ),
    children: <Widget>[
      MarkdownPageListTile(
        icon: const Icon(Icons.menu_book_outlined),
        title: Text(localizations.viewReadme),
        filename: "README.md",
      ),
      MarkdownPageListTile(
        icon: const Icon(Icons.menu_book_outlined),
        title: Text(localizations.viewChangelog),
        filename: "CHANGELOG.md",
      ),
      MarkdownPageListTile(
        icon: const Icon(Icons.description),
        title: Text(localizations.viewLicense),
        filename: "LICENSE",
      ),
      LicensesPageListTile(
        icon: const Icon(Icons.favorite),
        title: Text(localizations.viewLibLicenses),
      ),
    ],
  );
}
