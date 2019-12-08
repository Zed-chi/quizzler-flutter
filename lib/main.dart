import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import "./quiz_brain.dart";

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int counter = 0;
  List<Widget> scoreKeeper = [];

  void nextQuestion(){
    if (counter < quizBrain.length()-1){
      counter+=1;
    } else{
      Alert(context: context, title: "You ve Answered all the questions", desc: "Resetting questionis").show();
      counter = 0;
      scoreKeeper.clear();
    }
  }
  void markAnswer(chosing){
    if (chosing == quizBrain.getAnswer(counter)){
      setState(() {
        scoreKeeper.add(
          Icon(Icons.check, color:Colors.green)
        );
      });
    } else {
      setState(() {
        scoreKeeper.add(
          Icon(Icons.close, color:Colors.red)
        );
      });
    }
    nextQuestion();
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
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getText(counter),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                markAnswer(true);                                
              },
            ),
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                markAnswer(false);   
              },
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