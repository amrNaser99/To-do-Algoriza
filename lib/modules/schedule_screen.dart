import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_algoriza/shared/componands/componands.dart';
import 'package:todo_list_algoriza/shared/cubit/app_cubit.dart';
import 'package:todo_list_algoriza/shared/cubit/app_states.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Schedule',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CalendarTimeline(
                  initialDate: DateTime(2020, 4, 20),
                  firstDate: DateTime(2019, 1, 15),
                  lastDate: DateTime(2020, 11, 20),
                  onDateSelected: (date) => print(date),
                  leftMargin: 20,
                  monthColor: Colors.blueGrey,
                  dotsColor: Colors.teal[200],
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: Colors.green,
                  dayColor: const Color(0xFF333A47),
                  selectableDayPredicate: (date) => date.day != 23,
                  // locale: 'en_ISO',

                )
              ],
            ),
          ),
        );
      },
    );
  }
}
