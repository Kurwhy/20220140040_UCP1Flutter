import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucp_1/presentation/detail_barang_page.dart';

class DataBarangPage extends StatefulWidget {
  const DataBarangPage({super.key});

  @override
  State<DataBarangPage> createState() => _DataBarangPageState();
}

class _DataBarangPageState extends State<DataBarangPage> {
  final formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  String? selectedJenisTransaksi;
  String? selectedJenisBarang;
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  final List<String> jenisTransaksiList = ['Masuk', 'Keluar'];
  final List<String> jenisBarangList = [
    'Susu UHT',
    'Susu Pasteurisasi',
    'Yogurt Squeeze',
    'Stick Yogurt',
    'Cookies n Cream Pie',
  ];

  final Map<String, int> hargaBarang = {
    'Susu UHT': 10000,
    'Susu Pasteurisasi': 12000,
    'Yogurt Squeeze': 8000,
    'Stick Yogurt': 6000,
    'Cookies n Cream Pie': 15000,
  };
  void _submitData() {
    if (formKey.currentState!.validate() && selectedDate != null) {
      int jumlahBarang = int.tryParse(jumlahController.text) ?? 0;
      int hargaSatuan = int.tryParse(hargaController.text) ?? 0;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => DetailBarangPage(
                tanggal: selectedDate!,
                jenisTransaksi: selectedJenisTransaksi!,
                jenisBarang: selectedJenisBarang!,
                jumlahBarang: jumlahBarang,
                hargaSatuan: hargaSatuan,
              ),
        ),
      );
    } else {
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tanggal transaksi harus diisi')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    jumlahController.addListener(_updateTotalHarga);
  }

  void _updateTotalHarga() {
    if (selectedJenisBarang != null &&
        hargaBarang.containsKey(selectedJenisBarang)) {
      int jumlah = int.tryParse(jumlahController.text) ?? 0;
      int hargaSatuan = hargaBarang[selectedJenisBarang] ?? 0;
      int totalHarga = jumlah * hargaSatuan;
      hargaController.text = totalHarga.toString();
    }
  }

  @override
  void dispose() {
    jumlahController.removeListener(_updateTotalHarga);
    jumlahController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF343A7C),
        centerTitle: true,
        title: const Text(
          'Pendataan Barang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanggal Transaksi'),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selectedDate == null
                                ? Color(0xFF343A7C)
                                : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.grey),
                        const SizedBox(width: 12),
                        Text(
                          selectedDate != null
                              ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                              : 'Tanggal Transaksi',
                          style: TextStyle(
                            color:
                                selectedDate == null
                                    ? Color(0xFF343A7C)
                                    : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Jenis Transaksi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      jenisTransaksiList
                          .map(
                            (jenis) => DropdownMenuItem(
                              value: jenis,
                              child: Text(jenis),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJenisTransaksi = value;
                    });
                  },
                  validator:
                      (value) => value == null ? 'Pilih jenis transaksi' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Jenis Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      jenisBarangList
                          .map(
                            (barang) => DropdownMenuItem(
                              value: barang,
                              child: Text(barang),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedJenisBarang = value;
                      if (value != null && hargaBarang.containsKey(value)) {
                        hargaController.text = hargaBarang[value]!.toString();
                      } else {
                        hargaController.clear();
                      }
                    });
                  },
                  validator:
                      (value) => value == null ? 'Pilih jenis barang' : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
