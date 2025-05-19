// import 'package:mazzad/Models/home.dart';
//
// import 'package:sqflite/sqflite.dart';
//
// import '../../Database/SQL/db_controller.dart';
// import '../../Database/SQL/db_operations.dart';
//
//
// class AlarmDbController implements DbOperations<homeModel> {
//   final Database _database = DbController().database;
//
//
//
//
//
//   @override
//   Future<int> create(homeModel object) async {
//     return await _database.insert('home', object.toMap());
//   }
//
//   @override
//   Future<bool> delete(int id) async {
//
//     int numberOfDeletedRows =
//         await _database.delete('home', where: 'id = ?', whereArgs: [id]);
//     return numberOfDeletedRows > 0;
//   }
//
//   @override
//   Future<List<homeModel>> read() async{
//     List<Map<String, dynamic>> rows = await _database.query('home');
//     return rows.map((rowMap) => homeModel.fromMap(rowMap)).toList();
//   }
//
//   @override
//   Future<homeModel?> show(int id)async {
//     List<Map<String, dynamic>> rows =await _database.query('home',where: 'id = ?',whereArgs: [id]);
//     return rows.isNotEmpty ? homeModel.fromMap(rows.first) : null;
//   }
//
//   @override
//   Future<bool> update(homeModel object) async {
//     int numberOfUpdatedRows = await _database.update('home', object.toMap(),
//         where: 'id = ?', whereArgs: [object.id]);
//     return numberOfUpdatedRows > 0;
//   }
//
//
// }
