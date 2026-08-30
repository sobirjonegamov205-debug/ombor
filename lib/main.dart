import 'package:flutter/material.dart';

void main() {
  runApp(const OmborApp());
}

class OmborApp extends StatelessWidget {
  const OmborApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ombor Nazorati',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const OmborHomePage(),
    );
  }
}

class OmborHomePage extends StatefulWidget {
  const OmborHomePage({super.key});

  @override
  State<OmborHomePage> createState() => _OmborHomePageState();
}

class Mahsulot {
  String nomi;
  int soni;
  double narxi;

  Mahsulot({required this.nomi, required this.soni, required this.narxi});
}

class _OmborHomePageState extends State<OmborHomePage> {
  final List<Mahsulot> _mahsulotlar = [];

  final _nomiController = TextEditingController();
  final _soniController = TextEditingController();
  final _narxiController = TextEditingController();

  void _mahsulotQoshish() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Omborga mahsulot qo\'shish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomiController,
                decoration: const InputDecoration(labelText: 'Mahsulot nomi'),
              ),
              TextField(
                controller: _soniController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Soni (dona)'),
              ),
              TextField(
                controller: _narxiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Narxi (so\'m)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nomiController.text.isNotEmpty &&
                    _soniController.text.isNotEmpty &&
                    _narxiController.text.isNotEmpty) {
                  setState(() {
                    _mahsulotlar.add(
                      Mahsulot(
                        nomi: _nomiController.text,
                        soni: int.parse(_soniController.text),
                        narxi: double.parse(_narxiController.text),
                      ),
                    );
                  });
                  _nomiController.clear();
                  _soniController.clear();
                  _narxiController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Saqlash'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ombor Qoldiqlari'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _mahsulotlar.isEmpty
          ? const Center(
              child: Text(
                'Hozircha omborda mahsulot yo\'q.\nPastdagi [+] tugmasini bosing.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _mahsulotlar.length,
              itemBuilder: (context, index) {
                final mahsulot = _mahsulotlar[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      mahsulot.nomi,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        'Soni: ${mahsulot.soni} dona | Narxi: ${mahsulot.narxi} so\'m'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _mahsulotlar.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mahsulotQoshish,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}