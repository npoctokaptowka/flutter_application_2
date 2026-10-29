import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Заметки')),
        body: const NotesWidget(),
      ),
    );
  }
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];
  int _editIndex = -1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_controller.text.isEmpty) return;
    setState(() {
      if (_editIndex == -1) {
        _notes.add(_controller.text);
      } else {
        _notes[_editIndex] = _controller.text;
        _editIndex = -1;
      }
    });
    _controller.clear();
  }

  void _editNote(int index) {
    setState(() {
      _editIndex = index;
    });
    _controller.text = _notes[index];
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
      _editIndex = -1;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Введите текст заметки',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _saveNote,
            child: Text(_editIndex == -1 ? 'Сохранить' : 'Сохранить изменения'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editNote(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}