import 'package:flutter/material.dart';

void main() {
  runApp(AgeDifferenceApp());
}

class AgeDifferenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Difference Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AgeDifferenceCalculator(),
    );
  }
}

class AgeDifferenceCalculator extends StatefulWidget {
  @override
  _AgeDifferenceCalculatorState createState() =>
      _AgeDifferenceCalculatorState();
}

class _AgeDifferenceCalculatorState extends State<AgeDifferenceCalculator> {
  DateTime? _firstDate;
  DateTime? _secondDate;
  String? _result;

  // Method to pick a date
  Future<void> _selectDate(BuildContext context, bool isFirstDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isFirstDate) {
          _firstDate = pickedDate;
        } else {
          _secondDate = pickedDate;
        }
      });
    }
  }

  // Method to calculate the difference between two dates
  void _calculateDifference() {
    if (_firstDate == null || _secondDate == null) {
      setState(() {
        _result = "Please select both dates.";
      });
      return;
    }

    final Duration difference = _firstDate!.difference(_secondDate!).abs();
    int totalDays = difference.inDays;
    int years = (totalDays / 365).floor();
    int months = ((totalDays % 365) / 30).floor();
    int days = (totalDays % 365) % 30;

    setState(() {
      _result = "$years years, $months months, and $days days";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Difference Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Date Picker
              ElevatedButton(
                onPressed: () => _selectDate(context, true),
                child: Text(
                  _firstDate == null
                      ? "Select First Date"
                      : "First Date: ${_firstDate!.year}-${_firstDate!.month.toString().padLeft(2, '0')}-${_firstDate!.day.toString().padLeft(2, '0')}",
                ),
              ),
              SizedBox(height: 20),

              // Second Date Picker
              ElevatedButton(
                onPressed: () => _selectDate(context, false),
                child: Text(
                  _secondDate == null
                      ? "Select Second Date"
                      : "Second Date: ${_secondDate!.year}-${_secondDate!.month.toString().padLeft(2, '0')}-${_secondDate!.day.toString().padLeft(2, '0')}",
                ),
              ),
              SizedBox(height: 30),

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateDifference,
                child: Text("Calculate Difference"),
              ),
              SizedBox(height: 30),

              // Result
              if (_result != null)
                Text(
                  _result!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
