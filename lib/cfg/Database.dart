import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../model/PessoaModel.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    String sql =
        "CREATE TABLE pessoa(idpessoa INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        "nome TEXT, "
        "status TEXT,"
        "telefone TEXT, "
        "datanascimento TEXT)";

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dbTeens.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });
  }

  newPessoa(Pessoa pessoa) async {
    final db = await database;
    var res = await db.insert('Pessoa', pessoa.toMap());
    return res;
  }

  Future<List<Pessoa>> getPessoas() async {
    var sql = 'SELECT * FROM pessoa';
    final db = await database;
    var res = await db.rawQuery(sql);
    List<Pessoa> list =
        res.isNotEmpty ? res.map((p) => Pessoa.fromMap(p)).toList() : [];
    return list;
  }

  updatePessoa(Pessoa pessoa) async {
    final db = await database;
    var res = await db.update('Pessoa', pessoa.toMap(),
        where: ' idpessoa = ?', whereArgs: [pessoa.idpessoa]);
    return res;
  }

  deletePessoa(int idpessoa) async {
    final db = await database;
    var res =
        await db.delete('Pessoa', where: 'idpessoa= ?', whereArgs: [idpessoa]);
    return res;
  }
  deletePessoas() async {
    final db = await database;
    var res =
        await db.delete('Pessoa', where: '1=1');
    return res;
  }
}
