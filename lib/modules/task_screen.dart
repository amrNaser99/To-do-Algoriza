import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_algoriza/modules/board_screen.dart';
import 'package:todo_list_algoriza/shared/componands/componands.dart';
import 'package:todo_list_algoriza/shared/cubit/app_states.dart';

import '../shared/cubit/app_cubit.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppInsertDatabaseSuccessfulState) {
          BlocProvider.of<AppCubit>(context).titleController.clear();
          BlocProvider.of<AppCubit>(context).startTimeController.clear();
          BlocProvider.of<AppCubit>(context).endTimeController.clear();
          BlocProvider.of<AppCubit>(context).deadLineController.clear();
          BlocProvider.of<AppCubit>(context).remindController.clear();
          NavigateAndFinish(context, const BoardScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
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
                                      '${value.hour > 12 ? value.hour - 12 : value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
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
                // DropdownButton<String>(
                //   items:  <String>['10 min before','30 min before', '1 hour before', '1 day before'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   // const [
                //   //   DropdownMenuItem<String>(
                //   //       value: '10 min before', child: Text('10 min before')),
                //   //   DropdownMenuItem<String>(
                //   //     value: '30 min before',
                //   //     child: Text('30 min before'),
                //   //   ),
                //   //   DropdownMenuItem<String>(
                //   //     value: '1 hour before',
                //   //     child: Text('1 hour before'),
                //   //   ),
                //   //   DropdownMenuItem<String>(
                //   //     value: '1 day before',
                //   //     child: Text('1 day before'),
                //   //   ),
                //   // ],
                //   onChanged: (value) {
                //     // value == '10 min before'
                //     //     ? cubit.remindController.text = '10'
                //     //     : value == '30 min before'
                //     //         ? cubit.remindController.text = '30'
                //     //         : value == '1 hour before'
                //     //             ? cubit.remindController.text = '60'
                //     //             : cubit.remindController.text = '1440';
                //     // // cubit.remindController.text = value;
                //     setState(() {
                //       cubit.remindController.text = value!;
                //     });
                //   },
                //   value: cubit.remindController.text,
                // ),
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
                    //   title: cubit.titleController.text,
                    // cubit.insert(
                    //   title: cubit.titleController.text,
                    //   startTime: cubit.startTimeController.text,
                    //   endTime: cubit.endTimeController.text,
                    //   deadline: cubit.deadLineController.text,
                    //   remind: cubit.remindController.text,
                    //   color: 'Colors.red',
                    //   status: 'completed',
                    // );
                    cubit.insertToDatabase(
                      context: context,
                      title: cubit.titleController.text,
                      startTime: cubit.startTimeController.text,
                      endTime: cubit.endTimeController.text,
                      deadline: cubit.deadLineController.text,
                      remind: cubit.remindController.text,
                      color: 'Colors.red',
                      status: 'completed',
                      isFav: false,
                    );

                    debugPrint(
                      "${cubit.titleController.text}, ${cubit.startTimeController.text}, ${cubit.endTimeController.text}, ${cubit.deadLineController.text}, ${cubit.remindController.text}",
                    );

                    // cubit.insertToDatabase(
                    //   context: context,
                    //   title: cubit.titleController.text,
                    //   time: cubit.startTimeController.text,
                    //   date: cubit.deadLineController.text,
                    // );
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
