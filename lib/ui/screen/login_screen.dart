import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:orioks/logic/cubit/login_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: AppLocalizations.of(context)!.title,
      logo: const AssetImage('assets/icon/app.png'),
      onLogin: (LoginData data) {
        BlocProvider.of<LoginCubit>(context)
            .writeToken(data.name, data.password);
        return null;
      },
      onRecoverPassword: (_) => null,
      hideForgotPasswordButton: true,
      headerWidget: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ElevatedButton(
            onPressed: () => BlocProvider.of<LoginCubit>(context).enableDemo(),
            child: const Text(AppLocalizations.of(context)!.demo)),
      ),
    );
  }
}
