import 'package:flutter/material.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  DateTime _selectedDate = DateTime.now();
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amount = double.tryParse(value ?? "0.0") ?? 0.0;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: ["Food", "Rent", "Shopping", "Transport"]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: "Category"),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
              ListTile(
                title: Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Notes"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: AppColors.richBlack,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // For now, simply print the values.
                    print(
                        "Amount: $_amount, Category: $_category, Date: $_selectedDate");
                  }
                },
                child: Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
