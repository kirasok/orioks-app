import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orioks/data/model/token.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TokenTile extends StatelessWidget {
  final Token token;
  const TokenTile({super.key, required this.token});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: const Icon(Icons.key_outlined),
        title: token.lastUsed != null
            ? Text(DateFormat().format(token.lastUsed!.toLocal()))
            : null,
        subtitle: token.userAgent != null ? Text(token.userAgent!) : null,
        trailing: IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) {
              var localizations = AppLocalizations.of(context)!;
              return AlertDialog(
                title: Text(localizations.notImpl),
                content: Text(localizations.notImplDesc),
              );
            },
          ),
          icon: const Icon(Icons.delete),
        ),
      );
}
