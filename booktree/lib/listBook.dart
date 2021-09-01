import 'package:booktree/detailBook.dart';
import 'package:flutter/material.dart';

class ListBook extends StatefulWidget {
  const ListBook({Key? key}) : super(key: key);

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  List bookList = ['오늘의 독후감1', '오늘의 독후감2', '오늘의 독후감3'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Container(
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${bookList[0]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '2021-08-31',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${bookList[0]}',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '2021-08-31',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    color: Colors.blueGrey[50],
                  ),
                  width: 300,
                  height: 150,
                  //color: Colors.blueGrey[100],
                ),
                onTap: () {
                  //상세화면 -- id 정보 가져가야함! 변경!
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailBook();
                  })).then((value) => reloadData());
                },
                onLongPress: () {
                  //길게 누르면 삭제 가능
                },
              );
            }, //itemBuilder
            itemCount: 10,
          ),
        ),
      ),
    );
  }

  void reloadData() {
    setState(() {
      print('Reload BookList Data');
      //handler.queryStudents();
    });
  }
}//listBook.dart
