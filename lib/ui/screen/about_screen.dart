import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void showAboutScreen(BuildContext context, PackageInfo packageInfo) =>
    showAboutPage(
      context: context,
      values: {
        'year': DateTime.now().year.toString(),
      },
      title: Text(packageInfo.appName),
      applicationName: packageInfo.appName,
      applicationVersion: packageInfo.version,
      applicationLegalese: 'Copyright © Kirill Mokretsov, {{ year }}',
      applicationDescription: const Center(
        child: Text('Unofficial app for Orioks'),
      ),
      children: <Widget>[
        const MarkdownPageListTile(
          icon: Icon(Icons.menu_book_outlined),
          title: Text("View README"),
          filename: "README.md",
        ),
        // TODO: add changelog
        const MarkdownPageListTile(
          icon: Icon(Icons.description),
          title: Text("View license"),
          filename: "LICENSE",
        ),
        // TODO: add contributing
        // TODO: add code of conduct
        const LicensesPageListTile(
          icon: Icon(Icons.favorite),
          title: Text("Open source licenses"),
        ),
      ],
    );
