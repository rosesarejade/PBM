//STEP 6 - import story.dart
import 'story.dart';

//STEP 5 - create StoryBrain class
class StoryBrain {
  //STEP 7- create storyData as private properties
  final List<Story> _storyData = [
    Story(
        storyTitle:
            'Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: "Need a ride, sweetheart?".',
        choice1: 'I\'ll hop in. Thanks for the help!',
        choice2: 'Better ask if the lady\'s a murderer first.'),
    Story(
        storyTitle: 'She nods slowly, unphased by the question.',
        choice1: 'At least she\'s honest. I\'ll climb in.',
        choice2: 'Wait, I know how to change a tire. I change them myself'),
    Story(
        storyTitle:
            'As you begin to drive, the stranger lady starts talking about her relationship with his father. She gets angrier as the minute pass by. She asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. She reaches for the glove box.',
        choice1: 'I love Elton John! Hand her the cassette tape.',
        choice2: 'It\'s her or me! You take the knife and stab her.'),
    Story(
        storyTitle:
            'What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?',
        choice1: 'Restart',
        choice2: ''),
    Story(
        storyTitle:
            'As you smash through the guardrail and careen towards the jagged rocks below, you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.',
        choice1: 'Restart',
        choice2: ''),
    Story(
        storyTitle:
            'You bond with the murderer while crooning verses of "Can you feel the love tonight". She drops you off at the next town. Before you go she asks you if you know any good places to dump bodies. You reply: "Try the pier".',
        choice1: 'Restart',
        choice2: ''),
  ];

  //STEP 8 - create getStory() method that return the first storyTitle from _storyData yang return first storyTitle dari _storyData.
  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  //STEP 11 - create method getChoice1 that returns choice1 from _storyData
  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  //STEP 12 - create method getChoice2 that returns choice2 from _storyData
  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  //STEP 16 - create property storyNumber starting from zero (0). this will be used to track story that is currently viewed

  //STEP 25 - change storyNumber property to private property so that only story_brain.dart is able to access
  int _storyNumber = 0;

  void restart() {
    _storyNumber = 0;
  }

  //STEP 17 - create method nextStory()
  void nextStory(int choiceNumber) {
    //STEP 21 - using story plan, update nextStory and change storyNumber
    if (choiceNumber == 1 && _storyNumber == 0) {
      _storyNumber = 2;
    } else if (choiceNumber == 2 && _storyNumber == 0) {
      _storyNumber = 1;
    } else if (choiceNumber == 1 && _storyNumber == 1) {
      _storyNumber = 2;
    } else if (choiceNumber == 2 && _storyNumber == 1) {
      _storyNumber = 3;
    } else if (choiceNumber == 1 && _storyNumber == 2) {
      _storyNumber = 5;
    } else if (choiceNumber == 2 && _storyNumber == 2) {
      _storyNumber = 4;
    }

    //STEP 22 - in nextStory() if storyNumber is 3 or 4 or 5,
    // meaning game ends and calling the method restart
    else if (_storyNumber == 3 || _storyNumber == 4 || _storyNumber == 5) {
      restart();
    }
  }

  //STEP 27 - create method buttonShouldBeVisible() to check if storyNumber is 0 or 1 or 2
  bool buttonShouldBeVisible() {
    //You could also just check if (_storyNumber < 3)
    if (_storyNumber < 3) {
      return true;
    } else {
      return false;
    }
  }
}
