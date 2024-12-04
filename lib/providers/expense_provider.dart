import 'package:flutter/foundation.dart';
import '../models/expense_item.dart';

class ExpenseProvider with ChangeNotifier {
  final List<ExpenseItem> _expenses = [];

  List<ExpenseItem> get expenses => [..._expenses];

  void addExpense(ExpenseItem expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }
}
