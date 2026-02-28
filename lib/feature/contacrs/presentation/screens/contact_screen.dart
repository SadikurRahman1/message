import '../../../../core/exported_files/exported_file.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // Table Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 150,
                            child: CustomBorderedWidget(
                              text: "Name",
                              borderColor: Colors.teal,
                              textColor: Colors.teal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 150,
                            child: CustomBorderedWidget(
                              text: "Phone",
                              borderColor: Colors.teal,
                              textColor: Colors.teal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 200,
                            child: CustomBorderedWidget(
                              text: "Email",
                              borderColor: Colors.teal,
                              textColor: Colors.teal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: CustomBorderedWidget(
                              text: "Action",
                              borderColor: Colors.teal,
                              textColor: Colors.teal,
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Table Body
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomBorderedWidget(
                            text: "John Doe",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 150,
                          child: CustomBorderedWidget(
                            text: "+880123456",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 200,
                          child: CustomBorderedWidget(
                            text: "john@mail.com",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: CustomBorderedWidget(
                            text: "View",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomBorderedWidget(
                            text: "Jane Smith",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 150,
                          child: CustomBorderedWidget(
                            text: "+880987654",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 200,
                          child: CustomBorderedWidget(
                            text: "jane@mail.com",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: CustomBorderedWidget(
                            text: "View",
                            borderColor: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),)
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
    this.borderColor = Colors.blue, 
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ResponsiveText(
        text: text,
        color: textColor,
        fontSize: 14,
        // fontWeight: FontWeight.bold,
      ),
    );
  }
}
