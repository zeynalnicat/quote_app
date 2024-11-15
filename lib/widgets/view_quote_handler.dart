import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/blocs/quote_bloc.dart';
import 'package:quote_app/blocs/quote_state.dart';
import 'package:quote_app/data/database/quote_dao.dart';
import 'package:quote_app/widgets/quote_container.dart';

class ViewQuoteHandler extends StatefulWidget {
  const ViewQuoteHandler({super.key});

  @override
  State<ViewQuoteHandler> createState() => _ViewQuoteHandlerState();
}

class _ViewQuoteHandlerState extends State<ViewQuoteHandler>
    with TickerProviderStateMixin {
  late AnimationController animControl;
  late Animation<double> transAnim;
  late QuoteDao qDao;

  @override
  void initState() {
    super.initState();
    animControl = AnimationController(
        duration: const Duration(microseconds: 400), vsync: this);
    transAnim = Tween<double>(begin: 1.0, end: 0.0).animate(animControl)
      ..addListener(() {
        setState(() {});
      });
    context.read<QuoteBloc>().fetch();
    qDao = QuoteDao();
  }

  @override
  void dispose() {
    super.dispose();
    animControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuoteLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      QuoteContainer(
                        quote: state.quote.quote!,
                        author: state.quote.author!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF34D399),
                            ),
                            onPressed: () {
                              animControl.forward();
                              context.read<QuoteBloc>().fetch();
                            },
                            child: const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                var q = state.quote.quote;
                                var a = state.quote.author;
                                if (qDao.check(q!, a!) != true) {
                                  qDao.addQuote(
                                      state.quote.quote!,
                                      state.quote.author!,
                                      state.quote.category!);
                                } else {}
                              },
                              child: const Icon(
                                Icons.bookmark,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is QuoteError) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: Text("There is nothing to show here"),
          );
        },
      ),
    );
  }
}
