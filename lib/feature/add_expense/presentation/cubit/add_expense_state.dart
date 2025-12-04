abstract class AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {}

class AddExpenseError extends AddExpenseState {
  final String message;
  AddExpenseError(this.message);
}
