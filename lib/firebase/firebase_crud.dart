import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCrud {
  final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection('expenses');

  Future<void> createExpense(String title, double amount, String date) async {
    try {
      await expensesCollection.add({
        'title': title,
        'amount': amount,
        'date': date,
      });
      print("Expense added!");
    } catch (e) {
      print("Failed to add expense: $e");
    }
  }
}
