import 'package:flutter/material.dart';
import 'package:prak_pertemuan_3/add_contact_page.dart';
import 'package:prak_pertemuan_3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? storedContacts = prefs.getStringList('contacts');

    setState(() {
      contacts = storedContacts?.map((contact) {
        final parts = contact.split('|');
        return {
          'name': parts[0],
          'phone': parts[1],
          'email': parts.length > 2 ? parts[2] : '',
        };
      }).toList() ?? [];
    });
  }

  void _addContact(Map<String, String> contact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    contacts.add(contact);
    await prefs.setStringList('contacts', contacts.map((c) => '${c['name']}|${c['phone']}|${c['email']}').toList());
    _loadContacts();
  }

  void _deleteContact(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    contacts.removeAt(index);
    await prefs.setStringList('contacts', contacts.map((c) => '${c['name']}|${c['phone']}|${c['email']}').toList());
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background abu-abu
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white, // AppBar putih
        elevation: 0, // Menghilangkan shadow pada AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Kontak',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Judul hitam
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Semua daftar kontak Anda',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Subjudul abu
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Card(
                    color: Colors.grey[100], // Warna kartu putih
                    margin: const EdgeInsets.symmetric(vertical: 8), // Menghilangkan margin horizontal
                    elevation: 0, // Menghilangkan bayangan
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.black), // Ikon pengguna
                      title: Text(
                        contact['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Teks hitam
                        ),
                      ),
                      subtitle: Text(
                        contact['phone']! + (contact['email']!.isNotEmpty ? '\n${contact['email']}' : ''),
                        style: const TextStyle(color: Colors.grey), // Teks abu untuk informasi tambahan
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteContact(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const Sidemenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, // Warna tombol hitam
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage()),
          );
          if (newContact != null) {
            _addContact(newContact);
          }
        },
        child: const Icon(Icons.add, color: Colors.white), // Ikon tambah putih
      ),
    );
  }
}