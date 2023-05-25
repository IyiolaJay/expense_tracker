import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 6,
            child: Row(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.purple)),
                padding: const EdgeInsets.all(15),
                // width: 80,
                // height: 60,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions[index].title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(DateFormat.yMMMd().format(transactions[index].date),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 8,
                          fontWeight: FontWeight.bold))
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
