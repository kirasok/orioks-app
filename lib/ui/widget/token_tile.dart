import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/token.dart';
import 'package:orioks/logic/cubit/tokens_cubit.dart';

class TokenTile extends StatelessWidget {
  final Token token;
  const TokenTile({super.key, required this.token});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: const Icon(Icons.key_outlined),
        title: Text("*" * token.token.length),
        subtitle: token.lastUsed != null
            ? Text(token.lastUsed!.toLocal().toString())
            : null,
        trailing: IconButton(
          onPressed: () =>
              BlocProvider.of<TokensCubit>(context).deleteToken(token),
          icon: const Icon(Icons.delete),
        ),
      );
}
