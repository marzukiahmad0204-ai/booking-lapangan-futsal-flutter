import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/booking.dart';
import '../models/lapangan.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'futsal_booking.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE,
        nama TEXT,
        noHp TEXT,
        password TEXT,
        fotoProfil TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE lapangan (
        id TEXT PRIMARY KEY,
        nama TEXT,
        alamat TEXT,
        kota TEXT,
        hargaPerJam REAL,
        fotoCover TEXT,
        kapasitas INTEGER,
        rating REAL,
        jumlahReview INTEGER,
        fasilitas TEXT,
        deskripsi TEXT,
        tersedia INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE booking (
        id TEXT PRIMARY KEY,
        userId TEXT,
        lapanganId TEXT,
        lapanganNama TEXT,
        tanggalBooking TEXT,
        jamMulai TEXT,
        jamSelesai TEXT,
        totalHarga REAL,
        status TEXT,
        createdAt TEXT,
        catatan TEXT,
        FOREIGN KEY(userId) REFERENCES users(id),
        FOREIGN KEY(lapanganId) REFERENCES lapangan(id)
      )
    ''');
  }

  // User Operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // Lapangan Operations
  Future<int> insertLapangan(Map<String, dynamic> lapangan) async {
    Database db = await database;
    return await db.insert('lapangan', lapangan);
  }

  Future<List<Lapangan>> getAllLapangan() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('lapangan');
    return result.map((map) => Lapangan.fromMap(map)).toList();
  }

  Future<Lapangan?> getLapangan(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'lapangan',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Lapangan.fromMap(result.first) : null;
  }

  // Booking Operations
  Future<int> insertBooking(Booking booking) async {
    Database db = await database;
    return await db.insert('booking', booking.toMap());
  }

  Future<List<Booking>> getUserBooking(String userId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'booking',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return result.map((map) => Booking.fromMap(map)).toList();
  }

  Future<List<Booking>> getBookingByStatus(String userId, String status) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'booking',
      where: 'userId = ? AND status = ?',
      whereArgs: [userId, status],
      orderBy: 'tanggalBooking DESC',
    );
    return result.map((map) => Booking.fromMap(map)).toList();
  }

  Future<int> updateBooking(Booking booking) async {
    Database db = await database;
    return await db.update(
      'booking',
      booking.toMap(),
      where: 'id = ?',
      whereArgs: [booking.id],
    );
  }

  Future<int> deleteBooking(String bookingId) async {
    Database db = await database;
    return await db.delete(
      'booking',
      where: 'id = ?',
      whereArgs: [bookingId],
    );
  }
}
