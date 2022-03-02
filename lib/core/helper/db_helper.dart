import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHepler {
  static const String dbName = "stackoverflow.sqlite";

  static Future<Database> databaseAccess() async {
    String dbPath = join(await getDatabasesPath(), dbName);

    if (await databaseExists(dbPath)) {
      print("The database already exists. No need to copy.");
    } else {
      //assetten veritabanının alınması
      ByteData data = await rootBundle.load("db/$dbName");
      //Veritabanının kopyalama için byte dönüşümü
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //Veritabanının kopyalanması.
      await File(dbPath).writeAsBytes(bytes, flush: true);
      print("database copied");
    }
    //Veritabanını açıyoruz.
    return openDatabase(dbPath);
  }
}
