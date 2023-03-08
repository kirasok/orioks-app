import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/logic/cubit/internet_cubit.dart';
import 'package:orioks/logic/cubit/navigation_cubit.dart';
import 'package:orioks/logic/cubit/student_cubit.dart';
import 'package:orioks/logic/cubit/subjects_cubit.dart';
import 'package:orioks/ui/screen/schedule_screen.dart';
import 'package:orioks/ui/screen/student_screen.dart';
import 'package:orioks/ui/screen/subjects_screen.dart';

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
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orioks Unofficial"),
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) => BottomNavigationBar(
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subject),
                label: 'Subjects',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Student',
              ),
            ],
            onTap: (index) {
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
                return const Text("Loading");
            }
          },
        ),
      ),
    );
  }
}
