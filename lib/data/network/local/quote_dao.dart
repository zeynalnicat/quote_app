import 'package:quote_app/data/network/local/quote_db.dart';
import 'package:quote_app/domain/entities/Quote.dart';

class QuoteDao {
  Future<void> addQuote(String quote, String author, String category) async {
    var db = await QuoteDatabase.getDb();
    var quoteModel = <String, dynamic>{};
    quoteModel["quote"] = quote;
    quoteModel["author"] = author;
    quoteModel["category"] = category;

    await db.insert("quote", quoteModel);
  }

  Future<List<QuoteEntity>> fetchQuotes() async {
    var db = await QuoteDatabase.getDb();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM quote");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return QuoteEntity(
          row["id"], row["quote"], row["author"], row["category"]);
    });
  }

  Future<bool> check(String quote, String category) async {
    var db = await QuoteDatabase.getDb();
    List<Map<String, dynamic>> maps = await db.rawQuery(
      "SELECT COUNT(*) AS count FROM quote WHERE quote = ? AND category = ?",
      [quote, category],
    );

    int count = maps.isNotEmpty ? maps.first['count'] as int : 0;

    return count > 0;
  }
}
