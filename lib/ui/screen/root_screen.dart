import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/groups_cubit.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';
import 'package:orioks/logic/cubit/login_cubit.dart';
import 'package:orioks/logic/cubit/navigation_cubit.dart';
import 'package:orioks/logic/cubit/schedule_cubit.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';
import 'package:orioks/logic/cubit/subjects_cubit.dart';
import 'package:orioks/logic/cubit/tokens_cubit.dart';
import 'package:orioks/ui/screen/about_screen.dart';
import 'package:orioks/ui/screen/login_screen.dart';
import 'package:orioks/ui/screen/schedule_screen.dart';
import 'package:orioks/ui/screen/student_screen.dart';
import 'package:orioks/ui/screen/subjects_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(
            create: (context) => InternetCubit(connectivity: Connectivity())),
        BlocProvider(
            create: (context) => StudentCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
        BlocProvider(
            create: (context) => SubjectsCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
        BlocProvider(
            create: (context) => GroupsCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
        BlocProvider(
            create: (context) => ScheduleCubit(
                  internetCubit: BlocProvider.of<InternetCubit>(context),
                  studentCubit: BlocProvider.of<StudentCubit>(context),
                  groupsCubit: BlocProvider.of<GroupsCubit>(context),
                )),
        BlocProvider(
            create: (context) => LoginCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
        BlocProvider(
            create: (context) => TokensCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccessful) {
            var localizations = AppLocalizations.of(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(localizations!.title),
                actions: [
                  IconButton(
                    onPressed: () async => showAboutScreen(
                        context, await PackageInfo.fromPlatform()),
                    icon: const Icon(Icons.info_outline),
                  )
                ],
              ),
              bottomNavigationBar:
                  BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) => NavigationBar(
                  selectedIndex: state.index,
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.schedule_outlined),
                      selectedIcon: const Icon(Icons.schedule),
                      label: localizations.schedule,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.subject_outlined),
                      selectedIcon: const Icon(Icons.subject),
                      label: localizations.disciplines,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.person_outlined),
                      selectedIcon: const Icon(Icons.person),
                      label: localizations.student,
                    ),
                  ],
                  onDestinationSelected: (index) {
                    switch (index) {
                      case 0:
                        BlocProvider.of<NavigationCubit>(context)
                            .getNavBarItem(NavBarItem.schedule);
                        break;
                      case 1:
                        BlocProvider.of<NavigationCubit>(context)
                            .getNavBarItem(NavBarItem.subjects);
                        break;
                      case 2:
                        BlocProvider.of<NavigationCubit>(context)
                            .getNavBarItem(NavBarItem.student);
                        break;
                      default:
                        throw Exception("Unknown index: $index");
                    }
                  },
                ),
              ),
              body: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  switch (state.navBarItem) {
                    case NavBarItem.schedule:
                      return const ScheduleScreen();
                    case NavBarItem.subjects:
                      return const SubjectsScreen();
                    case NavBarItem.student:
                      return const StudentScreen();
                    default:
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                  }
                },
              ),
            );
          } else if (state is LoginProgress) {
            return const LoginScreen();
          } else if (state is LoginFailed) {
            return Text(state.e.toString());
          } else {
            return const Text("Failed to fetch token");
          }
        },
      ),
    );
  }
}
