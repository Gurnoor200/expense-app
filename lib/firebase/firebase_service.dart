import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch expenses from Firebase
  Stream<List<Map<String, dynamic>>> getExpenses() {
    return _firestore.collection('expenses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': data['title'] ?? 'No Title',
          'amount': data['amount'] ?? 0.0,
          'category': data['category'] ?? 'No Category',
          'date': data['date'] ?? 'No Date',
        };
      }).toList();
    });
  }

  // Add an expense to Firebase
  Future<void> addExpense(
      String title, double amount, String category, String date) {
    return _firestore.collection('expenses').add({
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    });
  }

  // Update an existing expense in Firebase
  Future<void> updateExpense(
      String id, String title, double amount, String category, String date) {
    return _firestore.collection('expenses').doc(id).update({
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    });
  }

  // Delete an expense from Firebase
  Future<void> deleteExpense(String id) {
    return _firestore.collection('expenses').doc(id).delete();
  }
}
