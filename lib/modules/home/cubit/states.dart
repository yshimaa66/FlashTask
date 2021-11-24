abstract class HomeStates {}

class Initial extends HomeStates {}

class IsLoading extends HomeStates {}

class HomeError extends HomeStates {
  final String error;
  HomeError(this.error);
}

class SelectCategory extends HomeStates {}

class DatePicked extends HomeStates {}

class ClearDate extends HomeStates {}