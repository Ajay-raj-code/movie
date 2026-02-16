import 'package:movie/models/sort_movie_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// this is local database
/// it is storing the favourite list locally

class AppDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), "movies.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            imdbID TEXT PRIMARY KEY,
            Title TEXT,
            Year TEXT,
            Type TEXT,
            Poster TEXT
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(SortMovieModel movie) async {
    final database = await AppDatabase().database;
    final result = await database.query(
      'favorites',
      where: 'imdbID = ?',
      whereArgs: [movie.imdbId],
    );
    if (result.isNotEmpty) {
      await database.delete(
        'favorites',
        where: 'imdbID = ?',
        whereArgs: [movie.imdbId],
      );
    } else {
      await database.insert(
        'favorites',
        movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<SortMovieModel>> getFavorite() async {
    final database = await AppDatabase().database;

    final List<Map<String, dynamic>> result = await database.query("favorites");
    List<SortMovieModel> movie = result
        .map((e) => SortMovieModel.fromJson(json: e))
        .toList();
    return movie;
  }
}
