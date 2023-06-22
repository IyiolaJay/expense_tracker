import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple, accentColor: Colors.amber)
            .copyWith(secondary: Colors.amber),
        textTheme: ThemeData.light().textTheme.copyWith(
            titleSmall: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            bodyMedium: const TextStyle(
              fontSize: 16,
            ),
            labelLarge: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            titleMedium: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins')),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //     id: 't1',
    //     title: 'Miscellaneous',
    //     amount: 67.23,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'Food',
    //     amount: 34.66,
    //     date: DateTime.now(),
    //   ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String inputTitle, double inputAmount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: inputTitle,
        amount: inputAmount,
        date: selectedDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _openAddTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(addTx: _addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chat'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(recentTransactions: _recentTransactions))
          : txList
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(recentTransactions: _recentTransactions)),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => {_openAddTransactionForm(context)},
                )
              ],
            ))
        : AppBar(
            title: const Text('Expenses'),
            actions: [
              IconButton(
                  onPressed: () {
                    _openAddTransactionForm(context);
                  },
                  icon: const Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              AppBar().preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
          transactions: _userTransactions, deleteTx: _deleteTransaction),
    );

    //Body contents
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txListWidget)
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                _openAddTransactionForm(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              )),
    );
  }
}
