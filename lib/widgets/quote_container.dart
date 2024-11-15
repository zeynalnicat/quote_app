import 'package:flutter/material.dart';

class QuoteContainer extends StatelessWidget {
  const QuoteContainer({required this.quote, required this.author, super.key});

  final String quote;
  final String author;

  @override
  Widget build(BuildContext context) {
    final double wd = (MediaQuery.of(context).size.width) * 0.8;

    return SizedBox(
        width: wd,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Card(
            margin: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: const Color(0xFFE5E7EB),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quote,
                    style: const TextStyle(fontSize: 16, fontFamily: "IBM"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "IBM",
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
