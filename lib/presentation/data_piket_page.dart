import 'package:flutter/material.dart';
import 'package:ucp_1/presentation/detail_piket_page.dart';

class DataPiketPage extends StatefulWidget {
  final String nama;

  const DataPiketPage({super.key, required this.nama});

  @override
  State<DataPiketPage> createState() => _DataPiketPageState();
}

class _DataPiketPageState extends State<DataPiketPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tugasController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, String>> tugasPiketList = [];

  bool _namaError = false;
  bool _tanggalError = false;
  bool _tugasError = false;

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF343A7C),
        centerTitle: true,
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama Anggota'),
            const SizedBox(height: 8),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                hintText: 'Admin',
                errorText: _namaError ? 'Nama tidak boleh kosong' : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Pilih Tanggal'),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _tanggalError ? Color(0xFF343A7C) : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      _selectedDate == null
                          ? 'Pilih Tanggal'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: TextStyle(
                        color: _tanggalError ? Color(0xFF343A7C) : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_tanggalError)
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  'Tanggal harus dipilih',
                  style: TextStyle(color: Color(0xFF343A7C), fontSize: 12),
                ),
              ),
            const SizedBox(height: 16),
            const Text('Tugas Piket'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tugasController,
                    decoration: InputDecoration(
                      hintText: 'Tugas Piket',
                      errorText:
                          _tugasError ? 'Tugas tidak boleh kosong' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addTugas,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF343A7C),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 75,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Tambah',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Daftar Tugas Piket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            tugasPiketList.isEmpty
                ? const Center(
                  child: Text(
                    'Belum ada Data',
                    style: TextStyle(color: Color(0xFF343A7C)),
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tugasPiketList.length,
                  itemBuilder: (context, index) {
                    final tugas = tugasPiketList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailPiketPage(
                                  nama: tugas['nama'] ?? '',
                                  tanggal: tugas['tanggal'] ?? '',
                                  tugas: tugas['tugas'] ?? '',
                                ),
                          ),
                        );
                      },
                      child: Card(
                        color: Color(0xFF343A7C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  tugas['tugas'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _tanggalError = false;
      });
    }
  }

  void _addTugas() {
    setState(() {
      _namaError = _namaController.text.isEmpty;
      _tanggalError = _selectedDate == null;
      _tugasError = _tugasController.text.isEmpty;
    });

    if (!_namaError && !_tanggalError && !_tugasError) {
      setState(() {
        tugasPiketList.add({
          'nama': _namaController.text,
          'tanggal':
              '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          'tugas': _tugasController.text,
        });
        _tugasController.clear();
      });
    }
  }
}
