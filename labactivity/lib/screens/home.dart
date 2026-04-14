import 'package:flutter/material.dart ';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  String title = "Welcome to my Home Page";
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  double sum = 0;
  double difference = 0;
  double product = 0;


  @override
  void initState() {
    super.initState();
    _number1Controller.text = "0";
    _number2Controller.text = "0";
  }

  void addNumbers(){
    setState(() {
      sum = double.parse(_number1Controller.text) + double.parse(_number2Controller.text);
    });  
  }

  void subtractNumbers(){
    setState(() {
      difference = double.parse(_number1Controller.text) - double.parse(_number2Controller.text);
    });
  }

  void multiplyNumbers(){
    setState(() {
      product = double.parse(_number1Controller.text) * double.parse(_number2Controller.text);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _number1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter first number',
              ),
            ),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter second number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addNumbers,
              child: const Text('Add'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: subtractNumbers,
              child: const Text('Subtract'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: multiplyNumbers,
              child: const Text('Multiply'),
            ),
            const SizedBox(height: 20),
            Text('Sum: $sum'),
            SizedBox(height: 10),
            Text('Difference: $difference'),
            SizedBox(height: 10),
            Text('Product: $product'),
          ],
        ),
      ),  
    );
  }
}