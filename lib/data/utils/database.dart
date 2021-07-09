
import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
class DatabaseCovid {
  static const String tableFavorite = "FAVORITE";
  static const String id = "ID";
  static const String userName = "USER_NAME";
  static const String flag = "FLAG";
  static const String countryFavoriteName = "COUNTRY_NAME";
  Database? _database;
  ///neu[_database] rong thi khoi tao database,va tao bang[TABLE_FAVORITE]
  Future openDb() async {
    _database ??= await openDatabase(
          join(await getDatabasesPath(), "databaseCovid.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $tableFavorite($id INTEGER PRIMARY KEY autoincrement,$userName TEXT,"
              "$flag TEXT,$countryFavoriteName TEXT)",
        );
      });
  }
  ///Dong [_database] neu [_database] dang mo
  Future closeDb() async {
    if (_database!.isOpen) {
      _database!.close();
    }
  }
///nhan vao mot [FavoriteCountry] sau do them vao [TABLE_FAVORITE]
  Future<int> insertFavorite(FavoriteCountry favoriteCountry) async {
    await openDb();
    return await _database!.insert(tableFavorite, favoriteCountry.toMap());
  }
  ///Nhan vao name va countryName sau do xoa no trong [TABLE_FAVORITE]
  Future<int> deleteFavoriteByNameAndCountry(String name,String countryName) async {
    await openDb();
    var result =await _database!.delete(
      tableFavorite,
      where: "$userName =? and $countryFavoriteName =?", whereArgs: [name,countryName],
    );
    return result;
  }
  ///nhan vao [USER_NAME] tra ve tat ca [FavoriteCountry] cua mot nguoi dung
  Future<List<FavoriteCountry>> getFavoriteByUsername(String name) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query(tableFavorite,where: "$userName=?",whereArgs: [name]);
    return List.generate(maps.length, (i) {
      return FavoriteCountry(
        userName : maps[i][userName]as String,
        flag: maps[i][flag]as String,
        countryName: maps[i][countryFavoriteName]as String,
      );
    });
  }
  /// nhan vao  [USER_NAME] va [COUNTRY_NAME]
  /// tra ve [FavoriteCountry] co [FavoriteCountry.userName] = [USER_NAME] va[FavoriteCountry.countryName] = [COUNTRY_NAME]
  Future<List<FavoriteCountry>> getFavoriteByUsernameAndCountry(String name,String coutry) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!
        .query(tableFavorite,where: "$userName=? and $countryFavoriteName=?",whereArgs: [name,coutry]);
    return List.generate(maps.length, (i) {
      return FavoriteCountry(
        userName : maps[i][userName]as String,
        flag: maps[i][flag]as String,
        countryName: maps[i][countryFavoriteName]as String,
      );
    });
  }
  ///  Xoa tat ca du lieu cua bang [TABLE_FAVORITE]
  Future<void> deleteAll() async {
    await openDb();
    await _database!.delete(
        tableFavorite
    );
  }
   }