import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/x.png'),
      const SizedBox(height: 10),
      Center(
          child: Text("Você não possui nenhuma tarefa",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w100,
              )))
    ]);
  }
}
