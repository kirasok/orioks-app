import 'package:flutter/material.dart';
import 'package:orioks/data/model/token.dart';

class TokenTile extends StatelessWidget {
  final Token token;
  const TokenTile({super.key, required this.token});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: const Icon(Icons.key_outlined),
        title: token.lastUsed != null
            ? Text(token.lastUsed!.toLocal().toString())
            : null,
        subtitle: token.userAgent != null ? Text(token.userAgent!) : null,
        trailing: IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text("Not impelemented"),
              content:
                  Text("Developers of API did not implemented this feature"),
            ),
          ),
          icon: const Icon(Icons.delete),
        ),
      );
}
