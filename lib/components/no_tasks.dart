import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksm_app/utils/custom_colors.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(
        Icons.notes_outlined,
        size: 130,
        color: CustomColors.redBaseButton,
      ),
      const SizedBox(height: 4),
      Center(
          child: Text("Você não possui nenhuma tarefa",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w100,
              )))
    ]);
  }
}
