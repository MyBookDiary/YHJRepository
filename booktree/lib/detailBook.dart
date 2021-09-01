import 'package:booktree/bookInfo.dart';
import 'package:booktree/databaseHandler.dart';
import 'package:flutter/material.dart';

class DetailBook extends StatefulWidget {
  final int rBookId;
  final String rBookImage;
  final String rBookTitle;
  final String rBookPublisher;
  final String rBookAuthors;
  final String rwriteDate;
  final String rBookReview;

  const DetailBook(
      {Key? key,
      required this.rBookId,
      required this.rBookImage,
      required this.rBookTitle,
      required this.rBookPublisher,
      required this.rBookAuthors,
      required this.rwriteDate,
      required this.rBookReview})
      : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState(rBookId, rBookImage,
      rBookTitle, rBookPublisher, rBookAuthors, rwriteDate, rBookReview);
}

class _DetailBookState extends State<DetailBook> {
  // Create Controuctor
  _DetailBookState(
      int rBookId,
      String rBookImage,
      String rBookTitle,
      String rBookPublisher,
      String rBookAuthors,
      String rwriteDate,
      String rBookReview) {
    this.rBookId = rBookId;
    this.bookImage = rBookImage;
    this.bookTitle = rBookTitle;
    this.bookPublisher = rBookPublisher;
    this.bookAuthors = rBookAuthors;
    this.writeDate = rwriteDate;
    this.bookReview = rBookReview;
  }

  // DataHandler
  late DatabaseHandler handler;
  // List Key 값
  late int rBookId;
  // 내용
  late String bookTitle;
  late String bookImage;
  late String bookAuthors;
  late String bookPublisher;
  late String writeDate;
  late String bookReview;

  // 오늘날짜 가져오기
  DateTime today = DateTime.now();
  // 가져오는 데이터
  late TextEditingController titleController;
  late TextEditingController publisherController;
  late TextEditingController authorController;
  // 직접입력
  late TextEditingController writeDateController;
  late TextEditingController reviewController;
  // 상태변수
  bool _readOnly = true;
  bool _modifyStatus = true;
  String modifyText = "수정하기";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler();

    titleController = TextEditingController();
    publisherController = TextEditingController();
    authorController = TextEditingController();
    writeDateController = TextEditingController();
    reviewController = TextEditingController();
    // 값가져오기
    titleController.text = bookTitle;
    publisherController.text = bookPublisher;
    authorController.text = bookAuthors;
    writeDateController.text = writeDate;
    reviewController.text = bookReview;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Detail (Temp)'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Image.asset(
                              'images/logo.png',
                              width: 100,
                              height: 150,
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      hintText: '책 제목 입력',
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.text,
                                  readOnly: _readOnly,
                                ),
                                TextField(
                                  controller: authorController,
                                  decoration: InputDecoration(
                                      hintText: '저자', border: InputBorder.none),
                                  keyboardType: TextInputType.text,
                                  readOnly: _readOnly,
                                ),
                              ],
                            ),
                            width: 230,
                            height: 150,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: TextField(
                                controller: publisherController,
                                decoration: InputDecoration(
                                    hintText: '출판사', border: InputBorder.none),
                                keyboardType: TextInputType.text,
                                readOnly: _readOnly,
                              ),
                              width: 150,
                            ),
                            Container(
                              child: TextField(
                                controller: writeDateController,
                                decoration: InputDecoration(
                                    hintText: '수정날짜', border: InputBorder.none),
                                keyboardType: TextInputType.text,
                                readOnly: _readOnly,
                              ),
                              width: 150,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: TextField(
                          controller: reviewController,
                          decoration: InputDecoration(hintText: '내용을 입력하세요'),
                          keyboardType: TextInputType.multiline,
                          readOnly: _readOnly,
                          maxLines: 15,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_modifyStatus == true) {
                            modifyText = "수정완료";
                            _readOnly = false;
                            _modifyStatus = false;
                          } else {
                            bookTitle = titleController.text.toString();
                            bookPublisher = publisherController.text.toString();
                            bookAuthors = authorController.text.toString();
                            bookReview = reviewController.text.toString();
                            writeDate = today.toString().substring(0, 10);
                            bookReview = reviewController.text.toString();

                            BookInfo bookInfo = BookInfo(
                                bookId: rBookId,
                                bookImage: bookImage,
                                bookTitle: bookTitle,
                                bookPublisher: bookPublisher,
                                bookAuthors: bookAuthors,
                                writeDate: writeDate,
                                bookReview: bookReview);

                            List<BookInfo> listofBook = [bookInfo];
                            await handler.updateBookInfo(listofBook);
                            _showDialog(context);
                            modifyText = "수정하기";
                            _readOnly = true;
                            _modifyStatus = true;
                          }
                        },
                        child: Text(modifyText),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[400])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("수정 결과"),
            content: Text("수정이 완료 되었습니다."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Main화면으로 이동
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
