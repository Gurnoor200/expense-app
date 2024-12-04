import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header for Analytics Section
            const Text(
              'Expense Categories Analytics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Bar Chart for Expense Categories
            Expanded(
              child: charts.BarChart(
                _createDummyExpenseData(),
                animate: true,
                barGroupingType: charts.BarGroupingType.stacked,
              ),
            ),
            const SizedBox(height: 20),
            // Dummy Statistics
            _buildStatistics(),
          ],
        ),
      ),
    );
  }

  // Dummy Expense Data for the chart
  List<charts.Series<ExpenseCategory, String>> _createDummyExpenseData() {
    final data = [
      ExpenseCategory('Food', 300),
      ExpenseCategory('Transport', 150),
      ExpenseCategory('Entertainment', 120),
      ExpenseCategory('Utilities', 200),
      ExpenseCategory('Miscellaneous', 80),
    ];

    return [
      charts.Series<ExpenseCategory, String>(
        id: 'Expenses',
        domainFn: (ExpenseCategory expense, _) => expense.category,
        measureFn: (ExpenseCategory expense, _) => expense.amount,
        data: data,
        labelAccessorFn: (ExpenseCategory expense, _) =>
            '\$${expense.amount.toString()}',
      ),
    ];
  }

  // Dummy Statistics Widget
  Widget _buildStatistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Expenses: \$850', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text('Average Expense: \$170', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text('Highest Expense Category: Food (\$300)',
            style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

// Dummy model class for ExpenseCategory
class ExpenseCategory {
  final String category;
  final double amount;

  ExpenseCategory(this.category, this.amount);
}
