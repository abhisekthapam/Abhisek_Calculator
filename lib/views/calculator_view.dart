import 'package:flutter/material.dart';

class AbhisekCalculator extends StatefulWidget {
  const AbhisekCalculator({super.key});

  @override
  State<AbhisekCalculator> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<AbhisekCalculator> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "7",
    "8",
    "9",
    "+",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  double? firstNumber;
  String? operator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Abhisek Calculator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: TextField(
                textAlign: TextAlign.right,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.85,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF212121),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(lstSymbols[index]),
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        _textController.text = "";
        firstNumber = null;
        operator = null;
      } else if (symbol == "<-") {
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if ("+-*/%".contains(symbol)) {
        if (_textController.text.isNotEmpty) {
          firstNumber = double.parse(_textController.text);
          operator = symbol;
          _textController.text = "";
        }
      } else if (symbol == "=") {
        if (firstNumber != null &&
            operator != null &&
            _textController.text.isNotEmpty) {
          double secondNumber = double.parse(_textController.text);
          double result =
              _performOperation(firstNumber!, secondNumber, operator!);
          _textController.text = result.toString();
          firstNumber = null;
          operator = null;
        }
      } else {
        _textController.text += symbol;
      }
    });
  }

  double _performOperation(double num1, double num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        if (num2 == 0) {
          return double.infinity;
        }
        return num1 / num2;
      case "%":
        return num1 * (num2 / 100);
      default:
        throw Exception("Invalid operator");
    }
  }
}
