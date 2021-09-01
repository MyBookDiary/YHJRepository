class BookInfo {
  final int? bookId;
  final String bookImage;
  final String bookTitle;
  final String bookPublisher;
  final String bookAuthors;
  final String writeDate;
  final String bookReview;


  BookInfo(
      {this.bookId,
      required this.bookImage,
      required this.bookTitle,
      required this.bookPublisher,
      required this.bookAuthors,
      required this.writeDate,
      required this.bookReview});

  BookInfo.fromMap(Map<String, dynamic> res)
      : bookId = res['bookId'],
        bookImage = res['bookImage'],
        bookTitle = res['bookTitle'],
        bookPublisher = res['bookPublisher'],
        bookAuthors = res['bookAuthors'],
        writeDate = res['writeDate'],
        bookReview = res['bookReview'];

  Map<String, Object?> toMap() {
    return {'bookId': bookId, 'bookImage': bookImage, 'bookTitle': bookTitle, 'bookPublisher': bookPublisher, 'bookAuthors': bookAuthors, 'writeDate': writeDate, 'bookReview': bookReview};
  }
}
