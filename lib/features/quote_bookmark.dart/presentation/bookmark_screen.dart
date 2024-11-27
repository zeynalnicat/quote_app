import 'package:flutter/material.dart';
import 'package:quote_app/common/constants/strings.dart';
import 'package:quote_app/data/database/quote_dao.dart';
import 'package:quote_app/domain/models/Quote.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late QuoteDao qDao;

  @override
  void initState() {
    super.initState();
    qDao = QuoteDao();
  }

  Future<List<QuoteEntity>> _fetchBookmarks() async {
    return await qDao.fetchQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tFavorite),
      ),
      body: FutureBuilder<List<QuoteEntity>>(
        future: _fetchBookmarks(),
        builder:
            (BuildContext context, AsyncSnapshot<List<QuoteEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('${AppStrings.tError}: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(AppStrings.tNoBookMarks));
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text(AppStrings.tUnstableInternet),
            );
          } else {
            final bookmarks = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final quote = bookmarks[index];
                  return Card.filled(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            quote.quote,
                            style: const TextStyle(
                                fontFamily: "IBM",
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(AppStrings.tCategory,
                                      style: TextStyle(
                                          fontFamily: "IBM",
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    quote.category.toUpperCase(),
                                    style: const TextStyle(
                                        fontFamily: "IBM",
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  )
                                ],
                              ),
                              Text(quote.author,
                                  style: const TextStyle(
                                      fontFamily: "IBM",
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
