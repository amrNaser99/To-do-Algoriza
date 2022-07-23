import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_algoriza/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  List colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.blue,
  ];

  TabController? tabController;

  static AppCubit get(context) => BlocProvider.of(context);

  List<Tab> tabs = [
    const Tab(
      text: 'All',
    ),
    const Tab(
      text: 'Completed',
    ),
    const Tab(
      text: 'Uncompleted',
    ),
    const Tab(
      text: 'Favourites',
    ),
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController deadLineController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController repeatController = TextEditingController();

  Database? database;

  List<Map> tasks = [];
  List<Map> activeTasks = [];
  List<Map> completedTasks = [];
  List<Map> favouriteTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, start_time TEXT, end_time TEXT, deadline TEXT, remind TEXT, color TEXT, status TEXT, is_fav TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error is ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        getDataFromDataBase(database);
        print('data received From Database successfully');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseSuccess());
    });
  }

  insertToDatabase({
    required BuildContext context,
    required String title,
    required String startTime,
    required String endTime,
    required String deadline,
    required String remind,
    required String color,
    required String status,
    required bool isFav,
  }) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, start_time, end_time, deadline, remind, color, status, is_fav) VALUES("$title","$startTime","$endTime","$deadline","$remind","color.red","active","false")')
          .then((value) {
        print('$value is inserting successfully');
        emit(AppInsertDatabaseSuccessfulState());
        // Navigator.pop(context);
        getDataFromDataBase(database);
      }).catchError((error) {
        print('Error when Insert new raw Record ${error.toString()}');
      });
    });
  }

  void getDataFromDataBase(database) {
    tasks = [];
    activeTasks = [];
    completedTasks = [];
    favouriteTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery("SELECT * FROM Tasks").then((value) {
      tasks = value;
      print('tasks $tasks');
      value.forEach((element) {

        if (element['status'] == 'completed') {
          completedTasks.add(element);
        } else if (element['status'] == 'active') {
          activeTasks.add(element);
        } else if (element['status'] == 'true') {
          favouriteTasks.add(element);
        }
      });
      emit(AppGetDatabaseSuccessfulState());
    });
  }

  void setChecked({required bool value}) {
    value = !value;
    emit(AppSetCheckedSuccess(value));
  }

  void updateTaskStatus(model, String s) {
    emit(AppUpdateTaskStatusLoadingState());
    database
        ?.rawUpdate('UPDATE tasks SET status = "$s" WHERE id = "${model.id}"')
        .then((value) {
      print('${model.title} is updated successfully');
      emit(AppUpdateTaskStatusSuccessfulState());
      getDataFromDataBase(database);
    }).catchError((error) {
      print('Error when update ${model.title} ${error.toString()}');
      emit(AppUpdateTaskStatusErrorState(error));
    });
  }
}
