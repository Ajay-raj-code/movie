import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  static Database? _database;

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }
  Future<Database> _initDb() async{
    final path = join(await getDatabasesPath(), "movies.db");

    return await openDatabase(path,
        version: 1,
        onCreate:(db, version) async {
          await db.execute('''
          CREATE TABLE favorites(
            imdbId TEXT PRIMARY KEY,
            title TEXT,
            year TEXT,
            type TEXT,
            poster TEXT
          )
        ''');
        }
    );
  }

  Future<void> addFavorite(Map<String, dynamic> movie) async{
    final database = await AppDatabase().database;

    await database.insert('favorites', movie, conflictAlgorithm: ConflictAlgorithm.replace);


  }
}

