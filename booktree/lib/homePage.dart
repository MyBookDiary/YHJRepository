import 'package:booktree/addBook.dart';
import 'package:booktree/detailBook.dart';
import 'package:booktree/listBook.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[200],
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Container(
                child: Text('올해 읽은 책',
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              '10',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListBook();
                })).then((value) => reloadData());
              },
              child: Image.asset(
                'images/sprout.png',
                width: 400,
                height: 400,
                alignment: Alignment.bottomCenter,
              ),
            ),
            height: 500,
            width: 500,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 10),
            child: Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddBook(
                          rBookImage: "",
                          rBookTitle: "",
                          rBookPublisher: "",
                          rBookAuthors: "",
                        );
                      })).then((value) => reloadData());
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('물주기'),
                ],
              ),
            ),
          )
        ]));
  }

  void reloadData() {}
}
