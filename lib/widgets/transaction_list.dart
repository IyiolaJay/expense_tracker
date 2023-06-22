import '../models/transactions.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import './Transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text('No transactions yet',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(transactions: transactions[index], deleteTx: deleteTx);
                // Card(
                //   elevation: 6,
                //   child: Row(children: <Widget>[
                //     Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(width: 1, color: Colors.purple)),
                //       padding: const EdgeInsets.all(15),
                // width: 80,
                // height: 60,
                //       margin: const EdgeInsets.symmetric(
                //           vertical: 10, horizontal: 15),
                //       child: Text(
                //         '\$${transactions[index].amount.toStringAsFixed(2)}',
                //         textAlign: TextAlign.center,
                //         style:
                //             const TextStyle(fontSize: 16, color: Colors.purple),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           transactions[index].title,
                //           textAlign: TextAlign.left,
                //           style: Theme.of(context).textTheme.titleMedium,
                //         ),
                //         Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             textAlign: TextAlign.left,
                //             style: const TextStyle(
                //                 color: Colors.grey,
                //                 fontSize: 8,
                //                 fontWeight: FontWeight.bold))
                //       ],
                //     )
                //   ]),
                // );
              },
            ),
    );
  }
}


