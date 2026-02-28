import '../../../../core/exported_files/exported_file.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Contacts'),
      //   backgroundColor: AppColors.mainColor,
      //   foregroundColor: Colors.white,
      // ),
      backgroundColor: const Color(0xFF00695C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),

              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomBorderedWidget(
                      text: "HELLO WORLD",
                      borderColor: Colors.teal, // কন্টেইনার বর্ডার সবুজ
                      textColor: Colors.black, // টেক্সট হবে হলুদ
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

class CustomBorderedWidget extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;

  const CustomBorderedWidget({
    super.key,
    required this.text,
    this.borderColor = Colors.blue, // কন্টেইনার বর্ডার কালার
    this.textColor = Colors.white, // টেক্সটের ভেতরের কালar
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Stack(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                foreground: Paint()..style = PaintingStyle.stroke,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
