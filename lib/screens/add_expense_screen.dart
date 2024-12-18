import 'package:expense_app/firebase/firebase_service.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final String? expenseId;
  final String? title;
  final String? amount;
  final String? category;
  final String? date;

  AddExpenseScreen({
    this.expenseId,
    this.title,
    this.amount,
    this.category,
    this.date,
  });

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // List of categories for the dropdown
  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Utilities',
    'Other'
  ];
  String? selectedCategory;

  DateTime? selectedDate;

  // Function to select date using the calendar
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateController.text =
            "${selectedDate?.toLocal()}".split(' ')[0]; // Format date
      });
  }

  @override
  void initState() {
    super.initState();
    if (widget.expenseId != null) {
      // Populate the fields with existing data if editing
      _titleController.text = widget.title ?? '';
      _amountController.text = widget.amount ?? '';
      _categoryController.text = widget.category ?? '';
      _dateController.text = widget.date ?? '';
      selectedCategory = widget.category;
    }
  }

  // Function to add or update expense
  void _saveExpense() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    final category = selectedCategory ??
        'Other'; // Default to 'Other' if no category selected
    final date = _dateController.text;

    if (widget.expenseId == null) {
      // Add new expense
      _firebaseService.addExpense(title, amount, category, date).then((_) {
        Navigator.pop(context); // Go back to the previous screen
      });
    } else {
      // Update existing expense
      _firebaseService
          .updateExpense(widget.expenseId!, title, amount, category, date)
          .then((_) {
        Navigator.pop(context); // Go back to the previous screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Update Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title TextField
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            // Amount TextField
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            // Category Dropdown
            DropdownButton<String>(
              value: selectedCategory,
              hint: Text('Select Category'),
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Date TextField with Date Picker
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true, // Prevent typing in the date field
            ),
            SizedBox(height: 20),
            // Save Expense Button
            ElevatedButton(
              onPressed: _saveExpense,
              child: const Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
