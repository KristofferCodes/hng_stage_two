import 'package:flutter/material.dart';

void main() {
  runApp(TextEditorApp());
}

class TextEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: TextListScreen(),
    );
  }
}

class TextListScreen extends StatefulWidget {
  @override
  _TextListScreenState createState() => _TextListScreenState();
}

class _TextListScreenState extends State<TextListScreen> {
  List<String> texts = [
    'Olabode Ayomide Kristoffer',
    'kristofferr',
    'Github.com/kristofferCodes',
    'I am a mobile engineer that has passion in the development of mobile applications. I have experience in the development of various mobile applications. I am a very easy person to work with as i try to provide solutions to other peoples problems as well as giving an attentive ear to feedbacks and enquiries',
  ];

  List<String> descriptions = [
    'Name',
    'Slack Username',
    'Github Profile',
    'Short bio',
  ];

  List<TextStyle> textStyles = const [
    TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 16.0, color: Colors.white),
    TextStyle(fontSize: 16.0, color: Colors.white),
    TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curriculum vitae (tap to edit)'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return TextListItem(
            text: texts[index],
            description: descriptions[index],
            textStyle: textStyles[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TextEditorScreen(
                    initialText: texts[index],
                    initialDescription: descriptions[index],
                    initialTextStyle: textStyles[index],
                    onUpdate: (editedText, editedDescription) {
                      setState(() {
                        texts[index] = editedText;
                        descriptions[index] = editedDescription;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TextListItem extends StatelessWidget {
  final String text;
  final String description;
  final TextStyle textStyle;
  final VoidCallback onTap;

  TextListItem({
    required this.text,
    required this.description,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Text(
          description,
          style: const TextStyle(
              fontSize: 12.0, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Text(
        text,
        style: textStyle,
      ),
      onTap: onTap,
    );
  }
}

class TextEditorScreen extends StatefulWidget {
  final String initialText;
  final String initialDescription;
  final TextStyle initialTextStyle;
  final Function(String, String) onUpdate;

  TextEditorScreen({
    required this.initialText,
    required this.initialDescription,
    required this.initialTextStyle,
    required this.onUpdate,
  });

  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  late TextEditingController _textEditingController;
  late String _description;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
    _description = widget.initialDescription;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              maxLines: null,
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Edit Info'),
            ),
            const SizedBox(height: 16.0),
            const Text('Category:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6.0),
            Text(
              _description, // Display the description as uneditable text
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final editedText = _textEditingController.text;
                widget.onUpdate(editedText, _description);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
