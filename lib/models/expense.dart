import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

/// Expense Categories
enum Category {
  food,
  leisure,
  travel,
  work,
}

/// Modern Material 3 Icons
const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.restaurant_rounded,
  Category.leisure: Icons.sports_esports_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.work: Icons.work_rounded,
};

/// Category Accent Colors (used in UI)
const Map<Category, Color> categoryColors = {
  Category.food: Colors.orange,
  Category.leisure: Colors.purple,
  Category.travel: Colors.blue,
  Category.work: Colors.green,
};

/// Expense Model (DATA ONLY)
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  /// Formatted date getter
  String get formattedDate => formatter.format(date);
}

/// Groups expenses by category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /// Helper constructor (VERY useful for charts)
  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
