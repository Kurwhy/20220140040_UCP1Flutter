import 'package:flutter/material.dart';

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
            // lanjut di commit berikutnya
          ],
        ),
      ),
    );
  }
}
