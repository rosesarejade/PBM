import 'package:flutter/material.dart';
import 'story_plot.dart';

void main() {
  runApp(const DestinyApp());
}

class DestinyApp extends StatelessWidget {
  const DestinyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StoryPage(),
    );
  }
}

//STEP 9 - create storyBrain object from the StoryBrain class
StoryBrain storyBrain = StoryBrain();

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[100],
          title: const Text(
            "Choose Your Destiny",
            style: TextStyle(fontSize: 25, color: Colors.indigo),
          )),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    //STEP 10 - use storyBrain object to access the first story
                    // display and title
                    storyBrain.getStory(),
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 28, 1, 19),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () {
                    //Choice 1
                    //STEP 18 - call nestStory()
                    //STEP 24 - Run app
                    setState(() {
                      storyBrain.nextStory(1);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[200]),
                    elevation: MaterialStateProperty.all(
                        2), // Elevation effect using FlatButton
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20.0)),
                  ),
                  child: Text(
                    //STEP 13 - use storyBrain to get the text from choice 1
                    storyBrain.getChoice1(),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: storyBrain.buttonShouldBeVisible(),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        storyBrain.nextStory(2);
                      });
                    },
                    child: Text(
                      storyBrain.getChoice2(),
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
