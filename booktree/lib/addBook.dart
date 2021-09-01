import 'package:booktree/bookInfo.dart';
import 'package:booktree/databaseHandler.dart';
import 'package:booktree/searchBook.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  final String rBookImage;
  final String rBookTitle;
  final String rBookPublisher;
  final String rBookAuthors;

  const AddBook({
    Key? key,
    required this.rBookImage,
    required this.rBookTitle,
    required this.rBookPublisher,
    required this.rBookAuthors,
  }) : super(key: key);

  @override
  _AddBookState createState() =>
      _AddBookState(rBookImage, rBookTitle, rBookPublisher, rBookAuthors);
}

class _AddBookState extends State<AddBook> {
  // DataBaseHandler
  late DatabaseHandler handler;
  final BookTitle = TextEditingController();
  final BookPublisher = TextEditingController();
  final BookAuthors = TextEditingController();
  final WriteDate = TextEditingController();
  final BookReview = TextEditingController();

  String BookImagestr = '';
  String BookTitlestr = '';
  String BookPublisherStr = '';
  String BookAuthorStr = '';

  //constructor
  _AddBookState(String rBookImage, String rBookTitle, String rBookPublisher,
      String rBookAuthor) {
    this.BookImagestr = rBookImage;
    this.BookTitlestr = rBookTitle;
    this.BookPublisherStr = rBookPublisher;
    this.BookAuthorStr = rBookAuthor;
  }

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    DateTime nowTime = new DateTime.now();
    WriteDate.text = nowTime.toString().substring(0, 10);

    BookTitle.text = BookTitlestr;
    BookPublisher.text = BookPublisherStr;
    BookAuthors.text = BookAuthorStr;
    print("받은 이미지 주소 : $BookImagestr ");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("독후감 쓰기"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   backgroundImage: AssetImage("images/bookimage.png"),
                  //   radius: 70.0,
                  // ),
                  SizedBox(width: 30),
                  Container(
                    child: ExtendedImage.network(
                      BookImagestr,
                      height: 150,
                      width: 130,
                      fit: BoxFit.fill,
                      cache: true,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: BookTitle,
                      decoration: InputDecoration(labelText: "책 제목을 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 150,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          if (BookTitle.text.isEmpty ||
                              BookTitle.text.trim() == "") {
                            errorSnackBar(context);
                          } else {
                            Navigator.of(context).pop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchBook(rbooktitle: BookTitle.text);
                            }));
                          }
                        },
                        child: Icon(Icons.search)),
                    padding: const EdgeInsets.all(10.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookPublisher,
                      decoration: InputDecoration(labelText: "출판사를 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookAuthors,
                      decoration: InputDecoration(labelText: "저자를 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: WriteDate,
                      decoration: InputDecoration(labelText: "작성 날짜"),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookReview,
                      decoration: InputDecoration(labelText: "내용을 입력 하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() async {
                  if (BookTitle.text.isEmpty ||
                      BookPublisher.text.isEmpty ||
                      BookAuthors.text.isEmpty ||
                      WriteDate.text.isEmpty ||
                      BookReview.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "빈 칸 없이 채워주세요!",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    BookInfo bookinfo = BookInfo(
                        bookImage: BookImagestr,
                        bookTitle: BookTitle.text,
                        bookPublisher: BookPublisher.text,
                        bookAuthors: BookAuthors.text,
                        writeDate: WriteDate.text,
                        bookReview: BookReview.text);
                    print("Error");
                    List<BookInfo> listOfBooks = [bookinfo];
                    await handler.insertBookInfo(listOfBooks);
                    _showDialog(context);
                  }
                });
              },
              child: Text("등록 하기"),
            ),
          ],
        ),
      ),
    );
  }
}

void errorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '책 제목을 입력해 주세요!',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.amber,
    ),
  );
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("입력 결과"),
          content: Text("입력이 완료 되었습니다."),
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
