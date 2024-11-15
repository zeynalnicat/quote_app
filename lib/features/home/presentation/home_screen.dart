import 'package:flutter/material.dart';
import 'package:quote_app/features/quote_bookmark.dart/presentation/bookmark_screen.dart';
import 'package:quote_app/widgets/view_quote_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  var rv = false;

  late AnimationController animControl;
  late Animation<double> transAnim;

  @override
  void initState() {
    super.initState();
    animControl = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    transAnim = Tween<double>(begin: 200.0, end: 0).animate(animControl)
      ..addListener(() {
        setState(() {});
      });

    animControl.forward();
  }

  @override
  void dispose() {
    animControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(transAnim.value, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5E7EB),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (route) => const BookmarkScreen()));
                      },
                      child: const Icon(
                        Icons.book,
                        color: Colors.black,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Switch(
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF0069D0),
                    inactiveThumbColor: const Color(0xFF8F8FA2),
                    value: rv,
                    onChanged: (value) {
                      setState(() {
                        rv = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Transform.translate(
                  offset: Offset(0.0, transAnim.value),
                  child: const ViewQuoteHandler())),
        ],
      ),
    ));
  }
}
