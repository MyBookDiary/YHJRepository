import 'package:booktree/databaseHandler.dart';
import 'package:booktree/homepage.dart';
import 'package:booktree/information.dart';
import 'package:booktree/listBook.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Tree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: TabBarAction(),
    );
  }
}

class TabBarAction extends StatefulWidget {
  const TabBarAction({Key? key}) : super(key: key);

  @override
  _TabBarActionState createState() => _TabBarActionState();
}

class _TabBarActionState extends State<TabBarAction>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _currentIndex = 0;
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: TabBarView(
          children: [HomePage(), ListBook(), Information()],
          controller: controller),
      bottomNavigationBar: TabBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        labelColor: Colors.grey[500],
        tabs: [
          Tab(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.grey[700] : Colors.grey[400],
            ),
            text: 'Home',
          ),
          Tab(
            icon: Icon(
              Icons.book,
              color: _currentIndex == 1 ? Colors.grey[700] : Colors.grey[400],
            ),
            text: 'List',
          ),
          Tab(
            icon: Icon(
              Icons.account_balance,
              color: _currentIndex == 2 ? Colors.grey[700] : Colors.grey[400],
            ),
            text: 'Info',
          ),
        ],
        controller: controller,
      ),
    );
  }
}
