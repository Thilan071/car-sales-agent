// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.blue,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network(
//                 'https://static.vecteezy.com/system/resources/thumbnails/035/915/849/small/ai-generated-car-logo-isolated-no-background-ai-generated-free-png.png',
//                 width: 150,
//                 height: 150,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'ABC Car Assistant',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Explore our AI-powered chatbot for your car buying needs!',
//                 style: TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ChatbotScreen(),
//                     ),
//                   );
//                 },
//                 child: const Text('Get Started'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ChatbotScreen extends StatefulWidget {
//   const ChatbotScreen({super.key});

//   @override
//   _ChatbotScreenState createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isUserRegistered = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chatbot Interface')),
//       body: _isUserRegistered ? buildChatInterface() : buildUserForm(),
//     );
//   }

//   Widget buildUserForm() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'Welcome! Please enter your details to start chatting.',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _nameController,
//             decoration: InputDecoration(
//               labelText: 'Full Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(
//               labelText: 'Email Address',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.emailAddress,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               if (_nameController.text.isNotEmpty &&
//                   _emailController.text.isNotEmpty) {
//                 setState(() {
//                   _isUserRegistered = true;
//                 });
//               }
//             },
//             child: const Text('Start Chat'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildChatInterface() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'How Can I Assist You Today?',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(onPressed: () {}, child: const Text('Help')),
//             const SizedBox(width: 10),
//             ElevatedButton(onPressed: () {}, child: const Text('Account')),
//             const SizedBox(width: 10),
//             ElevatedButton(onPressed: () {}, child: const Text('Settings')),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/035/915/849/small/ai-generated-car-logo-isolated-no-background-ai-generated-free-png.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'ABC Car Assistant',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore our AI-powered chatbot for your car buying needs!',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatbotScreen(),
                    ),
                  );
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isUserRegistered = false;
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String userMessage) async {
    const String apiUrl = "http://127.0.0.1:8000/chat";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": userMessage, "conversation_id": "1"}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          messages.add({"user": userMessage});
          messages.add({
            "bot": responseData['response'] ?? "No response from bot",
          });
        });
      } else {
        setState(() {
          messages.add({"bot": "Error: Unable to fetch response."});
        });
      }
    } catch (error) {
      setState(() {
        messages.add({"bot": "Error: Unable to connect to server."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot Interface')),
      body: _isUserRegistered ? buildChatInterface() : buildUserForm(),
    );
  }

  Widget buildUserForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome! Please enter your details to start chatting.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _emailController.text.isNotEmpty) {
                setState(() {
                  _isUserRegistered = true;
                });
              }
            },
            child: const Text('Start Chat'),
          ),
        ],
      ),
    );
  }

  Widget buildChatInterface() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              String sender = messages[index].keys.first;
              String message = messages[index].values.first;
              return Align(
                alignment:
                    sender == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        sender == "user" ? Colors.blue[200] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(message, style: const TextStyle(fontSize: 16)),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    sendMessage(_messageController.text);
                    _messageController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
