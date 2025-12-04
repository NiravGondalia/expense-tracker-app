import 'package:expense_tracker_app/feature/add_expense/domain/model/category.dart';
import 'package:expense_tracker_app/feature/add_expense/domain/model/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense_tracker.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date INTEGER NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT NOT NULL
      )
    ''');

    await _addCategories(db);
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          icon TEXT NOT NULL
        )
      ''');
      await _addCategories(db);
    }
  }

  Future<void> _addCategories(Database db) async {
    final List categories = [
      {'name': 'Food', 'icon': 'restaurant'},
      {'name': 'Transport', 'icon': 'directions_car'},
      {'name': 'Shopping', 'icon': 'shopping_bag'},
      {'name': 'Bills', 'icon': 'receipt_long'},
      {'name': 'Entertainment', 'icon': 'movie'},
      {'name': 'Other', 'icon': 'more_horiz'},
    ];

    for (final category in categories) {
      await db.insert('categories', category);
    }
  }

  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((map) => Expense.fromMap(map)).toList();
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final result = await db.query('categories');
    return result.map((map) => Category.fromMap(map)).toList();
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
