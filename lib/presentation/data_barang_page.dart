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
