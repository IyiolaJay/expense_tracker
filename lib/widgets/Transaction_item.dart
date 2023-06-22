import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {


  const TransactionItem({
    super.key,
    required this.transactions,
    required this.deleteTx,
  });

  final Transaction transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: ListTile(
        leading: CircleAvatar(
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  '\$ ${transactions.amount}',
                ),
              ),
            )),
        title: Text(
          transactions.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transactions.date),
        ),
        trailing: MediaQuery.of(context).size.width > 426
            ? TextButton.icon(
                onPressed: () {
                  deleteTx(transactions.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'))
            : IconButton(
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  deleteTx(transactions.id);
                },
                icon: const Icon(
                  Icons.delete,
                )),
      ),
    );
  }
}