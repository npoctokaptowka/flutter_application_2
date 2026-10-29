import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState([], -1));

  void saveNote(String text) {
    if (text.isEmpty) return;
    final notes = List<String>.from(state.notes);
    if (state.editIndex == -1) {
      notes.add(text);
    } else {
      notes[state.editIndex] = text;
    }
    emit(NotesState(notes, -1));
  }

  void editNote(int index) {
    emit(NotesState(state.notes, index));
  }

  void deleteNote(int index) {
    final notes = List<String>.from(state.notes);
    notes.removeAt(index);
    emit(NotesState(notes, -1));
  }
}