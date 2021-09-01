import 'package:booktree/databaseHandler.dart';
import 'package:booktree/detailBook.dart';
import 'package:flutter/material.dart';

import 'bookInfo.dart';

class ListBook extends StatefulWidget {
  const ListBook({Key? key}) : super(key: key);

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  late DatabaseHandler handler;
  List bookList = ['오늘의 독후감1', '오늘의 독후감2', '오늘의 독후감3'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler();
    // handler.initializeDB().whenComplete(() async {
    //   await addBookInfo();
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 기록'),
      ),
      body: FutureBuilder(
          future: handler.queryBookInfo(),
          builder:
              (BuildContext context, AsyncSnapshot<List<BookInfo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(
                            Icons.delete_forever,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                        key: ValueKey<int>(snapshot.data![index].bookId!),
                        onDismissed: (DismissDirection direction) async {
                          await handler
                              .deleteBookInfo(snapshot.data![index].bookId!);
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: GestureDetector(
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Image :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data![index].bookImage)
                                      //Text('Image')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Title :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data![index].bookTitle)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Authors :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data![index].bookAuthors)
                                      //Text('Book Authors')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Publisher :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(snapshot.data![index].bookPublisher)
                                      //Text('Publisher')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return UpdateStudents(
                            //       rcode: snapshot.data![index].code,
                            //       rname: snapshot.data![index].name,
                            //       rdept: snapshot.data![index].dept,
                            //       rphone: snapshot.data![index].phone);
                            // })).then((value) => reloadData());
                            //상세화면 -- id 정보 가져가야함! 변경!

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailBook(
                                  rBookId: snapshot.data![index].bookId!,
                                  rBookTitle: snapshot.data![index].bookTitle,
                                  rBookImage: snapshot.data![index].bookImage,
                                  rBookAuthors:
                                      snapshot.data![index].bookAuthors,
                                  rBookPublisher:
                                      snapshot.data![index].bookPublisher,
                                  rwriteDate: snapshot.data![index].writeDate,
                                  rBookReview:
                                      snapshot.data![index].bookReview);
                            })).then((value) => reloadData());
                          },
                        ));
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<int> addBookInfo() async {
    BookInfo firstBookInfo = BookInfo(
        bookImage: 'image1',
        bookTitle: '오늘의 독후감 hek',
        bookPublisher: 'HappyHe',
        bookAuthors: 'HEK',
        writeDate: '어제',
        bookReview: '행복함');
    BookInfo secondBookInfo = BookInfo(
        bookImage: 'image2',
        bookTitle: '오늘의 독후감 jyp',
        bookPublisher: 'Colorful',
        bookAuthors: 'JYP',
        writeDate: '오늘',
        bookReview: '즐거움');

    List<BookInfo> listOfBookInfo = [firstBookInfo, secondBookInfo];
    return await handler.insertBookInfo(listOfBookInfo);
  }

  void reloadData() {
    setState(() {
      print('Reload BookList Data');
      handler.queryBookInfo();
    });
  }
}//<<<<<<<<
