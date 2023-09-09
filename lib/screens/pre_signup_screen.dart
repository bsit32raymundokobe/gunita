import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/congratulations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PreSignUpScreen extends StatefulWidget {
  const PreSignUpScreen({super.key});

  @override
  State<PreSignUpScreen> createState() => _PreSignUpScreenState();
}

class _PreSignUpScreenState extends State<PreSignUpScreen> {
  final _lastNameTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _middleNameTextController = TextEditingController();
  final _nameExtensionTextController = TextEditingController();
  final _genderController = TextEditingController();
  final _birthdayTextController = TextEditingController();

  String gender = "";
  bool isExtensionNameVisible = true; // Initially visible

  final _formkey = GlobalKey<FormState>();

  final MaskTextInputFormatter nameFormatter = MaskTextInputFormatter(
    mask: "####################", // 20 characters
    filter: {"#": RegExp(r'[a-zA-Z]')}, // Only alphabetic characters
  );

  DateTime? selectedDate; // Add this variable

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xffe7f9f9),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context); // Return to the previous page
                            },
                          ),
                        ],
                      ),
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4f22cd),
                        ),
                      ),
                      const Text(
                        "Create a new account",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8a8a8a),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Last name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff020003),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter your last name';
                              }
                              return null; // No error
                            },
                            controller: _lastNameTextController,
                            inputFormatters: [nameFormatter], // Apply the formatter
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "First name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff020003),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter your first name';
                              }
                              return null; // No error
                            },
                            controller: _firstNameTextController,
                            inputFormatters: [nameFormatter], // Apply the formatter
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Middle name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff020003),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "",
                              fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                              filled: true,
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            controller: _middleNameTextController,
                            inputFormatters: [nameFormatter], // Apply the formatter
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: isExtensionNameVisible,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Extension name",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff020003),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "",
                                    fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                                    filled: true,
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  controller: _nameExtensionTextController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Birthday",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff020003),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 60,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _birthdayTextController,
                                      onTap: () async {
                                        final DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          setState(() {
                                            selectedDate = pickedDate;
                                            _birthdayTextController.text =
                                                "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Select your birthday",
                                        fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                                        filled: true,
                                        prefixIcon: const Icon(Icons.cake_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12), // Add some spacing between fields
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff020003),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 60,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        hintText: "Gender",
                                        fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                                        filled: true,
                                        prefixIcon: const Icon(Icons.person),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      items: ['Male', 'Female'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          gender = val!;
                                          isExtensionNameVisible = (gender != "Female"); // Set visibility based on selected gender
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              addUserDetails(
                                _lastNameTextController.text.trim(),
                                _firstNameTextController.text.trim(),
                                _middleNameTextController.text.trim(),
                                gender.trim(),
                              );

                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const Congratulations(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                          child: const Text(
                            "NEXT",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4f22cd),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(280, 60),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUserDetails(
    String lastName,
    String firstName,
    String middleName,
    String gender,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('Users/${user.uid}/UserDetails').add({
      'last name': lastName,
      'first name': firstName,
      'middle name': middleName,
      'name extension': _nameExtensionTextController.text.trim(),
      'gender': gender,
    });
  }
}
