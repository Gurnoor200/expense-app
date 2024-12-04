import 'package:expense_app/firebase/firebase_service.dart';
import 'package:expense_app/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // Listening to the stream of expenses
        stream: _firebaseService.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final expenses = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: expenses?.length ?? 0,
                    itemBuilder: (context, index) {
                      final expense = expenses![index];

                      // Safely accessing fields and providing fallback for null values
                      final title = expense['title'] ?? 'No Title';
                      final category = expense['category'] ?? 'No Category';
                      final amount = expense['amount']?.toString() ?? '0.00';
                      final date = expense['date'] ?? 'No Date';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(title),
                          subtitle: Text('$category - \$${amount}'),
                          trailing: Text(date),
                          onTap: () {
                            // Navigate to the AddExpenseScreen with pre-filled data for update
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddExpenseScreen(
                                  expenseId: expense['id'],
                                  title: title,
                                  amount: amount,
                                  category: category,
                                  date: date,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            // Delete the expense on long press
                            _firebaseService.deleteExpense(expense['id']);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
