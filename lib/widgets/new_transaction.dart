import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction({super.key, required this.addTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty || amountText <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(titleText, amountText, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                left: 5,
                top: 5,
                right: 5,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  onSubmitted: (_) => submitData(),
                ),
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        _selectedDate == null
                            ? 'No Date Picked'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      )),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text(
                            'Choose Date',
                          ))
                    ]),
                ElevatedButton(
                    onPressed: submitData,
                    child: const Text(
                      'Add Expense',
                      // style: TextStyle(color: Colors.purple),
                    )),
              ],
            ),
          )),
    );
  }
}
