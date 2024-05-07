import 'package:flutter/material.dart';
import 'package:quizzie/brain_quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// membuat object quizBrain
QuizBrain quizBrain = QuizBrain();

// main Method
void main() {
  runApp(const QuizzieApp());
}

class QuizzieApp extends StatelessWidget {
  const QuizzieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 241, 191, 218),
          title: const Text("Is it Swift or Shakespeare?",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 73, 0, 50))),
        ),
        backgroundColor: Color.fromARGB(255, 250, 238, 230),
        // body: title: ,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
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
  // List to save and store, displayed in Icon check or cross
  List<Icon> scoreKeeper = [];

  // Count True and False
  int numCorrect = 0;
  int numIncorrect = 0;

  // Function to check player's answers (parameter userPickedAnswer)
  // to answers from the list of questions(list questions/_questionBanks)
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    // setState
    setState(() {
      //Use IF/ELSE to check the end of the quiz, this will continue to the next line
      if (quizBrain.isFinished() == true) {
        //Alert when finished using rFlutterAlert
        Alert(
          context: context,
          title: 'Finished',
          desc: 'Congratulations! You\'ve reached the end of the Quiz\n'
              'Correct Answers: ${numCorrect + 1}\n'
              'Incorrect Answers: $numIncorrect\n'
              'Total Questions: ${quizBrain.getTotalQuestions()}',
        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      }

      //IF has not reached the end, ELSE do the answer checking
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.thumb_up_rounded,
            color: Color.fromARGB(255, 73, 0, 50),
          ));
          numCorrect++;
        } else {
          scoreKeeper.add(const Icon(
            Icons.thumb_down_off_alt_rounded,
            color: Color.fromARGB(255, 96, 73, 71),
          ));
          numIncorrect++;
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 32, 32, 32),
                  )),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 171, 188, 216)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              child: const Text(
                "TAYLOR SWIFT",
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 169, 155, 154)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              child: const Text(
                "WILLIAM SHAKESPEARE",
              ),
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
