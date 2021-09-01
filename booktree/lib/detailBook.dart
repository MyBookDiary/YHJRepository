import 'package:flutter/material.dart';

class DetailBook extends StatefulWidget {
  const DetailBook({Key? key}) : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  // 가져오는 데이터
  late TextEditingController titleController;
  late TextEditingController publisherController;
  late TextEditingController authorController;
  // 직접입력
  late TextEditingController writeDateController;
  late TextEditingController reviewController;
  bool _readOnly = true;
  bool _modifyStatus = true;
  String modifyText = "수정하기";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    publisherController = TextEditingController();
    authorController = TextEditingController();
    writeDateController = TextEditingController();
    reviewController = TextEditingController();
    // 값가져오기
    titleController.text = '데미안';
    publisherController.text = '민음사';
    authorController.text = '헤르만 헤세';
    writeDateController.text = "now";
    reviewController.text = "It was fucking awsome Fantastic";
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
                          keyboardType: TextInputType.text,
                          maxLines: 15,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_modifyStatus == true) {
                              modifyText = "수정완료";
                              _readOnly = false;
                              _modifyStatus = false;
                            } else {
                              modifyText = "수정하기";
                              _readOnly = true;
                              _modifyStatus = true;
                            }
                          });
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
}
