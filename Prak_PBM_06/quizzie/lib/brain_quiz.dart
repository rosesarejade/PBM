import 'questions.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question(
        questionText: '\"Love all, trust a few, do wrong to none.\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"And when you\'re young, you just run, but you come back to what you need.\"',
        questionAnswer: true),
    Question(
        questionText:
            '\"The greatest thing you\'ll ever learn is just to love and be loved in return.\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"Love is not love which alters when it alteration finds.\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"Past the curses and cries Beyond the terror in the nightfall\"',
        questionAnswer: true),
    Question(
        questionText:
            '\"My tongue will tell the anger of my heart, or else my heart concealing it will break\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"I\'d meet you where the spirit meets the bones in a faith-forgotten land\"',
        questionAnswer: true),
    Question(
        questionText:
            '\"Your touch brought forth an incandescent glow Tarnished but so grand\"',
        questionAnswer: true),
    Question(
        questionText:
            '\"The Earth that\'s natures\' mother is her tomb. What is her burying grave? That is her womb.\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"And all we are is skin and bone, trained to get along, forever going.\"',
        questionAnswer: true),
    Question(
        questionText: '\"Some rise by sin, and some by virtue fall\"',
        questionAnswer: false),
    Question(
        questionText:
            '\"I want auroras and sad prose, I want to watch wisteria grow\"',
        questionAnswer: true),
    Question(
        questionText:
            '\"Take the words for what they are; a dwindling, mercurial high\"',
        questionAnswer: true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  //Create isFinished method that checks the last questions.
  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('returning true');
      return true;
    } else {
      return false;
    }
  }

  //Count amount of questions
  int getTotalQuestions() {
    return _questionBank.length;
  }

  //Reset method to set the question number back to zero
  void reset() {
    _questionNumber = 0;
  }
}
