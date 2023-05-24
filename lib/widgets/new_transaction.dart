import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;

  NewTransaction({super.key, required this.addTx});

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty || amountText <= 0) {
      return;
    }

    addTx(titleText, amountText);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5),
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
                onChanged: (_) => submitData,
              ),
              TextButton(
                  onPressed: () {
                    // ignore: avoid_print
                    addTx(titleController.text,
                        double.parse(amountController.text));
                  },
                  child: const Text(
                    'Add Expense',
                    style: TextStyle(color: Colors.purple),
                  )),
            ],
          ),
        ));
  }
}
