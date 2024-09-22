import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  _showInput(controller, placeholder, isPassword, icon) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: placeholder,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Kontak',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            _showInput(
              _nameController,
              'Nama Kontak',
              false,
              Icons.person,
            ),
            const SizedBox(height: 20),
            _showInput(
              _phoneController,
              'Nomor HP',
              false,
              Icons.phone,
            ),
            const SizedBox(height: 20),
            _showInput(
              _emailController,
              'Email (opsional)',
              false,
              Icons.email,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
                    final newContact = {
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                    };
                    Navigator.pop(context, newContact);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
