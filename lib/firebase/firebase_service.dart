import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'expenses';

  // Create or add new expense
  Future<void> addExpense(
      String title, double amount, String category, String date) async {
    try {
      await _firestore.collection(collection).add({
        'title': title,
        'amount': amount,
        'category': category,
        'date': date,
      });
    } catch (e) {
      print("Error adding expense: $e");
    }
  }

  // Read all expenses
  Stream<List<Map<String, dynamic>>> getExpenses() {
    return _firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }

  // Update an expense
  Future<void> updateExpense(String id, String title, double amount,
      String category, String date) async {
    try {
      await _firestore.collection(collection).doc(id).update({
        'title': title,
        'amount': amount,
        'category': category,
        'date': date,
      });
    } catch (e) {
      print("Error updating expense: $e");
    }
  }

  // Delete an expense
  Future<void> deleteExpense(String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      print("Error deleting expense: $e");
    }
  }
}
