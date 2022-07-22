import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_algoriza/modules/board_screen.dart';
import 'package:todo_list_algoriza/shared/componands/componands.dart';
import 'package:todo_list_algoriza/shared/cubit/app_states.dart';

import '../shared/cubit/app_cubit.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        Key key1 = Key('Container1');
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Add Task',
              style: GoogleFonts.actor(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Title',
                  style: GoogleFonts.actor(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TFF(
                  hintText: 'Design Team Meeting',
                  controller: cubit.titleController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Task Title';
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'DeadLine',
                  style: GoogleFonts.actor(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TFF(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20.0,
                    end: 10.0,
                  ),
                  hintText: '2020-01-01',
                  controller: cubit.deadLineController,
                  keyboardType: TextInputType.datetime,
                  isIcon: true,
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter DeadLine';
                    }
                  },
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        cubit.deadLineController.text =
                            '${value.year}-${value.month}-${value.day}';
                        debugPrint(cubit.deadLineController.text);
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time',
                            style: GoogleFonts.actor(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TFF(
                              padding: const EdgeInsetsDirectional.only(
                                start: 10.0,
                              ),
                              hintText: '11:00 Am',
                              controller: cubit.startTimeController,
                              keyboardType: TextInputType.datetime,
                              isIcon: true,
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 18.0,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Start Time';
                                }
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    cubit.startTimeController.text =
                                        '${value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                    debugPrint(cubit.startTimeController.text);
                                  }
                                });
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Time',
                            style: GoogleFonts.actor(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TFF(
                            padding: const EdgeInsetsDirectional.only(
                              start: 10.0,
                            ),
                            hintText: '04:00 Pm',
                            controller: cubit.endTimeController,
                            keyboardType: TextInputType.datetime,
                            isIcon: true,
                            icon: const Icon(Icons.access_time,
                                color: Colors.grey, size: 18.0),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Start Time';
                              }
                            },
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  cubit.endTimeController.text =
                                      '${value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                  debugPrint(cubit.endTimeController.text);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Remind',
                  style: GoogleFonts.actor(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TFF(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 10.0),
                  hintText: '10 Minutes early',
                  controller: cubit.remindController,
                  keyboardType: TextInputType.phone,
                  isIcon: true,
                  icon: const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ///TODO: Add a color picker
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       width: 50,
                //       height: 50,
                //       decoration: BoxDecoration(
                //         color: Colors.red,
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //       ///[TODO] if state is true then show red else show grey
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.check,
                //           color: Colors.white,
                //         ),
                //         onPressed: () {
                //           // cubit.addRemind();
                //         },
                //       ),
                //     ),
                //     Container(
                //       width: 50,
                //       height: 50,
                //       decoration: BoxDecoration(
                //         color: Colors.red,
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //       ///[TODO] if state is true then show red else show grey
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.check,
                //           color: Colors.white,
                //         ),
                //         onPressed: () {
                //           // cubit.addRemind();
                //         },
                //       ),
                //     ),
                //     Container(
                //       width: 50,
                //       height: 50,
                //       decoration: BoxDecoration(
                //         color: Colors.red,
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //       ///[TODO] if state is true then show red else show grey
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.check,
                //           color: Colors.white,
                //         ),
                //         onPressed: () {
                //           // cubit.addRemind();
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // const Spacer(),
                mainButton(
                  context: context,
                  text: 'Create A Task',
                  onClick: () {
                    cubit.createTask();
                    NavigateTo(context, const BoardScreen());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
