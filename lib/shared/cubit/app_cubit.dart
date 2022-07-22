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

  late TabController tabController;

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

  List tasks = [];
  late Database database;

  void createTask() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, start time TEXT, deadline TEXT, status TEXT)')
            .then((value) {
          debugPrint('DataBase Execute Successfully');
        });
      },
    ).then((value) {
      debugPrint('DataBase open Successfully');
    }).catchError((error) {
      debugPrint('Error is $error');
    });
    emit(AppCreateDatabaseState());
  }

  insertToDatabase({
    required BuildContext context,
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date,start time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value is inserting successfully');
        emit(AppInsertDatabaseState());
        Navigator.pop(context);
        getDataFromDataBase(database);
      }).catchError((error) {
        print('Error when Insert new raw Record ${error.toString()}');
      });
    });
  }

  List newTasks = [];
  List doneTasks = [];
  List archivedTasks = [];

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'favourite') {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseSuccessfulState());
    });
  }

  // Update some record
  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseState());
    }).catchError((error) {
      debugPrint('Error in UpdateData fun : $error');
    });
  }

  void deleteData({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseState());
    }).catchError((error) {
      debugPrint('Error in DeleteData fun : $error');
    });
  }

  void setChecked({required bool value}) {
    value = !value;
    emit(AppSetCheckedSuccess(value));
  }
}
