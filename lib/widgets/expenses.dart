import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (_) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    final width = MediaQuery.of(context).size.width;

    final Widget mainContent = _registeredExpenses.isEmpty
        ? const Center(
            child: Text('No expenses found. Start adding some!'),
          )
        : ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),

      body: width<600 ?  SafeArea(
        child: Column(
          children: [
            // Chart
            Chart(expenses: _registeredExpenses),

            //  Expense List
            Expanded(child: mainContent),
          ],
        ),
      ): SafeArea(
        child: Row(
          children: [
            // Chart
            Expanded(
              child: Chart(expenses: _registeredExpenses),
              ),
            //  Expense List
            Expanded(child: mainContent),
          ],
        ),
      ),

      //  Single Add Button (best UX)
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
