import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuoteDatabase {
  static const String dbName = "quote.sqlite";

  static Future<Database> getDb() async {
    String dbPath = join(await getDatabasesPath(), dbName);

    if (!(await databaseExists(dbPath))) {
      ByteData data = await rootBundle.load("database/$dbName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(dbPath);
  }
}
