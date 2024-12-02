import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMaleSelected = true;
  int weight = 65;
  int age = 20;
  double height = 170.0;

  double bmi = 0;
  String classification = '';

  void calculateAndDisplayBMI() {
    setState(() {
      if (height == 0) {
        bmi = 0;
        classification = '';
        return;
      }
      // BMI formula: weight (kg) / height (m)^2
      double heightInMeters = height / 100;
      bmi = weight / (heightInMeters * heightInMeters);
      classification = getBMIClassification(bmi);
    });
  }

  String getBMIClassification(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi >= 18.5 && bmi < 24.9) return 'Normal weight';
    if (bmi >= 25 && bmi < 29.9) return 'Overweight';
    return 'Obesity';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'poppins',
        primaryColor: Colors.black,
        scaffoldBackgroundColor: HexColor("#D1D9E6"),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 55),
                    const Text(
                      'Welcome to Virgiliu\'s App 😊',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      'Calculatoare si Retele 211',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ButtonWidget(
                      isMaleSelected: isMaleSelected,
                      onGenderChanged: (bool isMale) {
                        setState(() {
                          isMaleSelected = isMale;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        IncrementDecrementWidget(
                          label: 'Weight',
                          initialValue: weight,
                          onChanged: (value) {
                            setState(() {
                              weight = value;
                            });
                          },
                        ),
                        SizedBox(width: 32),
                        IncrementDecrementWidget(
                          label: 'Age',
                          initialValue: age,
                          onChanged: (value) {
                            setState(() {
                              age = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      label: 'Height, cm',
                      placeholder: 'Introduceti inaltimea',
                      onChanged: (value) {
                        setState(() {
                          height = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  bmi.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 67,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  classification,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BottomButton(
                  onPressed: calculateAndDisplayBMI,
                  buttonText: 'Let\'s go',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final bool isMaleSelected;
  final ValueChanged<bool> onGenderChanged;

  const ButtonWidget({
    super.key,
    required this.isMaleSelected,
    required this.onGenderChanged,
  });

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.onGenderChanged(true);
          },
          child: Container(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: widget.isMaleSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Text(
                '♂ Male',
                style: TextStyle(
                  color: widget.isMaleSelected ? Colors.white : Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        GestureDetector(
          onTap: () {
            widget.onGenderChanged(false);
          },
          child: Container(
            width: 155,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: !widget.isMaleSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Text(
                '♀ Female',
                style: TextStyle(
                  color: !widget.isMaleSelected ? Colors.white : Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class IncrementDecrementWidget extends StatefulWidget {
  final String label;
  final int initialValue;
  final ValueChanged<int> onChanged;

  const IncrementDecrementWidget({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _IncrementDecrementWidgetState createState() => _IncrementDecrementWidgetState();
}

class _IncrementDecrementWidgetState extends State<IncrementDecrementWidget> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void increment() {
    setState(() {
      value++;
      widget.onChanged(value);
    });
  }

  void decrement() {
    setState(() {
      value = value > 0 ? value - 1 : 0;
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: decrement,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: increment,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: placeholder,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const BottomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}