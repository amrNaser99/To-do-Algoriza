abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBootomNavBarState extends AppStates {}
class AppSetCheckedSuccess extends AppStates {
  final bool value;

  AppSetCheckedSuccess(this.value);
}
class AppCreateDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppGetDatabaseSuccessfulState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppChangeBootomCheetState extends AppStates {}
