import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/screens/chatbotscreen.dart';
import 'package:shoebot/services/auth.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animated_text_kit/animated_text_kit.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override 
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() {
    context.read<AuthService>().signOut();
  }

  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "";
  bool _isListening = false;
  int k=0;
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognition();
  }

  Future<void> _initializeSpeechRecognition() async {

    bool available = await _speech.initialize();
    print(available);
    if (available) {
      setState(() {
        _isListening = true;
      });
    } else {
      print('Speech recognition not available on this device.');
    }
  }

  

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(1, 76, 1, 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 190),
                text: ["S H O E B O T"],
                textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Find your perfect pair",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              Image.asset('assets/c2.PNG', height: 150), // Adjust the height as needed
              SizedBox(height: 20),
              Text(
                _text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow,
                          labelText: "Ask me what you're looking for today!",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.yellow,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatBotScreen(_text),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            animate: _isListening,
            glowColor: Colors.yellow,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: () {
                if (_isListening) {
                  _speech.stop();
                } else {
                  _speech.listen(
                    onResult: (result) {
                      setState(() {
                        _text = result.recognizedWords;
                      });
                    },
                  );
                }
                setState(() {
                  _isListening = !_isListening;
                });
              },
              backgroundColor: Colors.yellow,
              child: Icon(
                _isListening ? Icons.mic_none : Icons.mic,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16), // Add space between the button and text field
        ],
      ),
    );
  }

  
}