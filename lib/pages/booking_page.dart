import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/booking.dart';
import '../models/lapangan.dart';
import '../services/auth_service.dart';
import '../services/database_helper.dart';
import '../widgets/custom_button.dart';

class BookingPage extends StatefulWidget {
  final Lapangan lapangan;

  const BookingPage({Key? key, required this.lapangan}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();
  String _selectedJamMulai = '08:00';
  String _selectedJamSelesai = '09:00';
  String _catatan = '';
  bool _isLoading = false;

  final List<String> _jamOptions = [
    '08:00', '09:00', '10:00', '11:00', '12:00',
    '13:00', '14:00', '15:00', '16:00', '17:00',
    '18:00', '19:00', '20:00', '21:00', '22:00'
  ];

  double _calculateTotal() {
    int jamMulai = int.parse(_selectedJamMulai.split(':')[0]);
    int jamSelesai = int.parse(_selectedJamSelesai.split(':')[0]);
    int durasi = jamSelesai - jamMulai;
    if (durasi <= 0) durasi = 1;
    return widget.lapangan.hargaPerJam * durasi;
  }

  void _processBooking() async {
    if (_selectedJamSelesai == _selectedJamMulai) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jam yang berbeda')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      const uuid = Uuid();

      Booking booking = Booking(
        id: uuid.v4(),
        userId: authService.currentUser?['id'] ?? '',
        lapanganId: widget.lapangan.id,
        lapanganNama: widget.lapangan.nama,
        tanggalBooking: _selectedDate,
        jamMulai: _selectedJamMulai,
        jamSelesai: _selectedJamSelesai,
        totalHarga: _calculateTotal(),
        status: 'pending',
        createdAt: DateTime.now(),
        catatan: _catatan,
      );

      await _dbHelper.insertBooking(booking);

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking berhasil! Menunggu konfirmasi.')),
      );

      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Lapangan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lapangan Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lapangan.nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.lapangan.alamat,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp${widget.lapangan.hargaPerJam.toStringAsFixed(0)}/jam',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E88E5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Pilih Tanggal
              const Text(
                'Pilih Tanggal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                  );
                  if (pickedDate != null) {
                    setState(() => _selectedDate = pickedDate);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                            .format(_selectedDate),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Jam Mulai
              const Text(
                'Jam Mulai',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: _selectedJamMulai,
                isExpanded: true,
                items: _jamOptions
                    .map((jam) => DropdownMenuItem(
                          value: jam,
                          child: Text(jam),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedJamMulai = value!);
                },
              ),
              const SizedBox(height: 24),
              // Jam Selesai
              const Text(
                'Jam Selesai',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: _selectedJamSelesai,
                isExpanded: true,
                items: _jamOptions
                    .map((jam) => DropdownMenuItem(
                          value: jam,
                          child: Text(jam),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedJamSelesai = value!);
                },
              ),
              const SizedBox(height: 24),
              // Catatan
              const Text(
                'Catatan (Opsional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                maxLines: 3,
                onChanged: (value) => _catatan = value,
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan untuk lapangan...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Total Harga
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Durasi'),
                        Text(
                          '${int.parse(_selectedJamSelesai.split(":")[0]) - int.parse(_selectedJamMulai.split(":")[0])} jam',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Harga/Jam'),
                        Text(
                          'Rp${widget.lapangan.hargaPerJam.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Rp${_calculateTotal().toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E88E5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Pesan Button
              CustomButton(
                label: 'Konfirmasi Pemesanan',
                onPressed: _processBooking,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
