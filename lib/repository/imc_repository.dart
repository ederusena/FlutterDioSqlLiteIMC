// ignore_for_file: depend_on_referenced_packages

import 'package:dio_imc_flutter/models/imc.dart';
import 'package:dio_imc_flutter/repository/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ImcRepository {
  Future<Database> _getDatabase() async {
    final String path = join(await getDatabasesPath(), 'imc_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE TBL_IMC(id INTEGER PRIMARY KEY, peso REAL, altura REAL, imc REAL, status TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> salvar(Imc imc) async {
    var db = await _getDatabase();
    await db.rawInsert(
        'INSERT INTO TBL_IMC (peso, altura, imc, status) values(?,?,?,?)',
        [imc.height, imc.weight, imc.imc, imc.status]);
  }

  Future<List<Imc>> getAll() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('TBL_IMC');
    return List.generate(maps.length, (i) {
      return Imc(maps[i]['id'], maps[i]['peso'], maps[i]['altura'],
          maps[i]['imc'], maps[i]['status']);
    });
  }

  Future<double> calculateImc(double weight, double height) async {
    await Future.delayed(const Duration(microseconds: 100));
    return weight / (height * height);
  }

  Future<String> getImcStatus(double imc) async {
    await Future.delayed(const Duration(microseconds: 100));
    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc >= 18.5 && imc < 25) {
      return "Peso normal";
    } else if (imc >= 25 && imc < 30) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      return "Obesidade grau 1";
    } else if (imc >= 35 && imc < 40) {
      return "Obesidade grau 2";
    } else {
      return "Obesidade grau 3";
    }
  }
}
