import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/screens/chatbotscreen.dart';
import 'package:shoebot/services/auth.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



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

      appBar: AppBar(
       title: const Text("Search for your shoe"), centerTitle: true,
       actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.power_settings_new))],
     ),
      body: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text(
              "S H O E B O T",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0),
            child: const Text(
              "Find your perfect pair",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 40.0),
            child: Center(
              child: Image.asset('assets/c2.PNG'), // Use the asset path here
            ),
          ),
          Text(
            _text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "Ask me what you're looking for today!",
                    fillColor: Colors.yellow,
                    filled: true,
              
                  ),
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                ),
              ),
              IconButton(
                color: Colors.yellow,
                icon: const Icon(Icons.send),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatBotScreen(_text),
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
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Icon(_isListening ? Icons.mic_none : Icons.mic,color: Colors.black),
          ),
          ),
          const SizedBox(width: 16), // Add space between the button and text field
        ],
      ),
    );
  }


  
}