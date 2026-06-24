import 'package:flutter/material.dart';

class Lapangan {
  final String id;
  final String nama;
  final String alamat;
  final String kota;
  final double hargaPerJam;
  final String fotoCover;
  final int kapasitas;
  final double rating;
  final int jumlahReview;
  final List<String> fasilitas;
  final String deskripsi;
  final bool tersedia;

  Lapangan({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.kota,
    required this.hargaPerJam,
    required this.fotoCover,
    required this.kapasitas,
    required this.rating,
    required this.jumlahReview,
    required this.fasilitas,
    required this.deskripsi,
    this.tersedia = true,
  });

  factory Lapangan.fromMap(Map<String, dynamic> map) {
    return Lapangan(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      alamat: map['alamat'] ?? '',
      kota: map['kota'] ?? '',
      hargaPerJam: (map['hargaPerJam'] ?? 0).toDouble(),
      fotoCover: map['fotoCover'] ?? '',
      kapasitas: map['kapasitas'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      jumlahReview: map['jumlahReview'] ?? 0,
      fasilitas: List<String>.from(map['fasilitas'] ?? []),
      deskripsi: map['deskripsi'] ?? '',
      tersedia: map['tersedia'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'kota': kota,
      'hargaPerJam': hargaPerJam,
      'fotoCover': fotoCover,
      'kapasitas': kapasitas,
      'rating': rating,
      'jumlahReview': jumlahReview,
      'fasilitas': fasilitas,
      'deskripsi': deskripsi,
      'tersedia': tersedia,
    };
  }
}
