class Booking {
  final String id;
  final String userId;
  final String lapanganId;
  final String lapanganNama;
  final DateTime tanggalBooking;
  final String jamMulai;
  final String jamSelesai;
  final double totalHarga;
  final String status; // pending, confirmed, completed, cancelled
  final DateTime createdAt;
  final String? catatan;

  Booking({
    required this.id,
    required this.userId,
    required this.lapanganId,
    required this.lapanganNama,
    required this.tanggalBooking,
    required this.jamMulai,
    required this.jamSelesai,
    required this.totalHarga,
    required this.status,
    required this.createdAt,
    this.catatan,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      lapanganId: map['lapanganId'] ?? '',
      lapanganNama: map['lapanganNama'] ?? '',
      tanggalBooking: DateTime.parse(map['tanggalBooking'] ?? DateTime.now().toString()),
      jamMulai: map['jamMulai'] ?? '',
      jamSelesai: map['jamSelesai'] ?? '',
      totalHarga: (map['totalHarga'] ?? 0).toDouble(),
      status: map['status'] ?? 'pending',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toString()),
      catatan: map['catatan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'lapanganId': lapanganId,
      'lapanganNama': lapanganNama,
      'tanggalBooking': tanggalBooking.toString(),
      'jamMulai': jamMulai,
      'jamSelesai': jamSelesai,
      'totalHarga': totalHarga,
      'status': status,
      'createdAt': createdAt.toString(),
      'catatan': catatan,
    };
  }
}
