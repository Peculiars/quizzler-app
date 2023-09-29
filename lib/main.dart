import 'package:flutter/material.dart';
import 'package:quizzler_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool pickedAnswer){
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: "You've reached the end of the quiz"
          ).show();

          quizBrain.reset();
          scoreKeeper = [];
      } else {
        if (pickedAnswer == correctAnswer) {
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            )
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            )
          );
        }
        quizBrain.nextQuestion();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
               quizBrain.getQuestionText(),
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 25.0
              ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 40.0, bottom: 20.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)
                ),
              onPressed: (){
                checkAnswer(true);
              },
               child: const Text('True'),
               ),
          ),
        ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 60.0),
               child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                onPressed: (){
                  checkAnswer(false);
                },
                 child: const Text('False')
                 ),
             ),
           ),
           Row(
            children: scoreKeeper,
           )
      ],
    );
  }
}