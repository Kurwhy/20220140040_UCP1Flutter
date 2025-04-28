import 'package:flutter/material.dart';
import 'detail_pelanggan_page.dart';

class DataPelangganPage extends StatefulWidget {
  const DataPelangganPage({Key? key}) : super(key: key);

  @override
  _DataPelangganPageState createState() => _DataPelangganPageState();
}

class _DataPelangganPageState extends State<DataPelangganPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _emailController.clear();
    _noHpController.clear();
    _alamatController.clear();
    _provinsiController.clear();
    _kodePosController.clear();
  }

  void _simpanData() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => DetailPelangganPage(
                nama: _namaController.text,
                email: _emailController.text,
                noHp: _noHpController.text,
                alamat: _alamatController.text,
                provinsi: _provinsiController.text,
                kodePos: _kodePosController.text,
              ),
        ),
      );
    }
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (fieldName == 'Email' && !value.contains('@')) {
      return 'Format email tidak valid';
    }
    if (fieldName == 'No HP' && value.length < 10) {
      return 'Nomor HP tidak valid';
    }
    if (fieldName == 'Kode Pos' && value.length != 5) {
      return 'Kode Pos harus 5 digit';
    }
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) => _validateField(value, label),
    );
  }
}
