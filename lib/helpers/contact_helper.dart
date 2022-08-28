// ignore: unused_import
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

const String contactTable = 'contactTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String emailColumn = 'emailColumn';
const String phoneColumn = 'phoneColumn';
const String imgColumn = 'imgColumn';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  // ignore: unused_field
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    // ignore: unused_local_variable
    final databasesPath = await getDatabasesPath();
    // ignore: unused_local_variable
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)");
    });
  }
}

Future<Contact> saveContact(Contact contact) async {
  // ignore: unused_local_variable, prefer_typing_uninitialized_variables
  var db;
  Database dbContact = await db;
  contact.id = await dbContact.insert(
    contactTable,
    contact.toMap(),
  );
  return contact;
}

// ignore: missing_return
Future<Contact> getContact(int id) async {
  // ignore: prefer_typing_uninitialized_variables
  var db;
  Database dbContact = await db;
  // ignore: unused_local_variable
  List<Map> maps = await dbContact.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
  // ignore: prefer_is_empty
  if (maps.length > 0) {
    return Contact.fromMap(maps.first);
  } else {
    return null;
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  // ignore: missing_return
  Map toMap() {
    // ignore: unused_local_variable
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  // ignore: missing_return
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}
