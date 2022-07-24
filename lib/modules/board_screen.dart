import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_algoriza/modules/screens/active_tasks.dart';
import 'package:todo_list_algoriza/modules/screens/all_tasks.dart';
import 'package:todo_list_algoriza/modules/screens/completed_tasks.dart';
import 'package:todo_list_algoriza/modules/screens/favourite_tasks.dart';
import 'package:todo_list_algoriza/modules/task_screen.dart';
import 'package:todo_list_algoriza/shared/componands/componands.dart';
import 'package:todo_list_algoriza/shared/cubit/app_cubit.dart';
import 'package:todo_list_algoriza/shared/cubit/app_states.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Board',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              elevation: 1,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // NavigateTo(context, const ScheduleScreen());
                    cubit.getDataFromDataBase(cubit.database);

                  },
                ),
              ],
              bottom: TabBar(
                tabs: cubit.tabs,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                indicatorWeight: 3.0,
                physics: const NeverScrollableScrollPhysics(),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: cubit.tabController,
                      children: const [
                        AllTasksScreen(),
                        ActiveTasksScreen(),
                        CompletedTasksScreen(),
                        FavouriteTaskScreen(),
                      ],
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     // Checkbox(value: itemValue, onChanged: (value){},checkColor: color,)
                  //     Checkbox(
                  //       value: false,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(6.0),
                  //       ),
                  //       onChanged: (value) {
                  //         cubit.setChecked(value: value!);
                  //       },
                  //       checkColor: Colors.black,
                  //     ),
                  //     const SizedBox(width: 10.0),
                  //     Expanded(
                  //       child: Text(
                  //         'Done all tasks ? ',
                  //         style: GoogleFonts.lato(
                  //           textStyle: const TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 20.0,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const Spacer(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  mainButton(
                    context: context,
                    onClick: () {
                      NavigateTo(
                        context,
                        const TaskScreen(),
                      );

                    },
                    text: 'Add a task',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
