import 'package:hive_flutter/hive_flutter.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/models/note_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static final HiveService instance = HiveService._internal();
  HiveService._internal();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ChecklistItemAdapter());
    }
    
    // Open boxes
    await Hive.openBox<NoteModel>(HiveBoxes.notes);
    await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox(HiveBoxes.security);
    
    _initialized = true;
  }

  Box<NoteModel> get notesBox => Hive.box<NoteModel>(HiveBoxes.notes);
  Box get settingsBox => Hive.box(HiveBoxes.settings);
  Box get securityBox => Hive.box(HiveBoxes.security);

  Future<void> dispose() async {
    await Hive.close();
    _initialized = false;
  }
}
