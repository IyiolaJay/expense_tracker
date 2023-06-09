import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          ? Column(
              children: [
                Text('No transactions yet',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            ) 
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
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
                              '\$ ${transactions[index].amount}',
                            ),
                          ),
                        )),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          deleteTx(transactions[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                        )),
                  ),
                );
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
