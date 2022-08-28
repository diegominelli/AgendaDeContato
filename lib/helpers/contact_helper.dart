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
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'contacts.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute('CREATE TABLE $contactTable('
          '$idColumn INTEGER PRIMARY KEY, '
          '$nameColumn TEXT, '
          '$emailColumn TEXT, '
          '$phoneColumn TEXT, '
          '$imgColumn TEXT)');
    });
  }

  Future<void> close() async {
    Database dbContact = await db;
    await dbContact.close();
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(
      contactTable,
      contact.toMap(),
    );
    return contact;
  }

  Future<List<Contact>> getAllContacts() async {
    Database dbContact = await db;
    final List listMap =
        await dbContact.rawQuery('SELECT * FROM $contactTable');
    final List<Contact> listContacts = [];
    for (Map m in listMap) {
      listContacts.add(Contact.fromMap(m));
    }
    return listContacts;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(
      contactTable,
      columns: [
        idColumn,
        nameColumn,
        emailColumn,
        phoneColumn,
        imgColumn,
      ],
      where: '$idColumn = ?',
      whereArgs: [id],
    );
    // ignore: prefer_is_empty
    if (maps.length <= 0) {
      return null;
    }
    return Contact.fromMap(maps.first);
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(
      contactTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(
      contactTable,
      contact.toMap(),
      where: '$idColumn = ?',
      whereArgs: [contact.id],
    );
  }
}

class Contact {
  int id = 0;
  String name = '';
  String email = '';
  String phone = '';
  String img = '';

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map<String, Object> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
    if (id > 0) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, email: $email, phone: $phone, img: $img}';
  }
}

// class ContactHelper {
//   static final ContactHelper _instance = ContactHelper.internal();

//   factory ContactHelper() => _instance;

//   ContactHelper.internal();

//   // ignore: unused_field
//   Database _db;

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     } else {
//       _db = await initDb();
//       return _db;
//     }
//   }

//   Future<Database> initDb() async {
//     // ignore: unused_local_variable
//     final databasesPath = await getDatabasesPath();
//     // ignore: unused_local_variable
//     final path = join(databasesPath, "contactsnew.db");

//     return await openDatabase(path, version: 1,
//         onCreate: (Database db, int newerVersion) async {
//       await db.execute(
//           "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)");
//     });
//   }

//   Future<Contact> saveContact(Contact contact) async {
//     // ignore: unused_local_variable, prefer_typing_uninitialized_variables
//     var db;
//     Database dbContact = await db;
//     contact.id = await dbContact.insert(
//       contactTable,
//       contact.toMap(),
//     );
//     return contact;
//   }

//   // ignore: missing_return
//   Future<Contact> getContact(int id) async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     Database dbContact = await db;
//     // ignore: unused_local_variable
//     List<Map> maps = await dbContact.query(contactTable,
//         columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
//         where: "$idColumn = ?",
//         whereArgs: [id]);
//     // ignore: prefer_is_empty
//     if (maps.length > 0) {
//       return Contact.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }

//   Future<int> deleteContact(int id) async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     // ignore: unused_local_variable
//     Database dbContact = await db;
//     return await dbContact
//         .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
//   }

//   Future<int> updateContact(Contact contact) async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     // ignore: unused_local_variable
//     Database dbContact = await db;
//     return await dbContact.update(contactTable, contact.toMap(),
//         where: "$idColumn = ?", whereArgs: [contact.id]);
//   }

//   Future<List> getAllContacts() async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     // ignore: unused_local_variable
//     Database dbContact = await db;
//     // ignore: unused_local_variable
//     List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
//     // ignore: unused_local_variable
//     List<Contact> listContact = [];
//     for (Map m in listMap) {
//       listContact.add(
//         Contact.fromMap(m),
//       );
//     }
//     return listContact;
//   }

//   Future<int> gerNumber() async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     // ignore: unused_local_variable
//     Database dbContact = await db;
//     return Sqflite.firstIntValue(
//         await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
//   }

//   Future close() async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     // ignore: unused_local_variable
//     Database dbContact = await db;
//     dbContact.close();
//   }
// }

// class Contact {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String img;

//   Contact();

//   Contact.fromMap(Map map) {
//     id = map[idColumn];
//     name = map[nameColumn];
//     email = map[emailColumn];
//     phone = map[phoneColumn];
//     img = map[imgColumn];
//   }

//   // ignore: missing_return
//   Map toMap() {
//     // ignore: unused_local_variable
//     Map<String, dynamic> map = {
//       nameColumn: name,
//       emailColumn: email,
//       phoneColumn: phone,
//       imgColumn: img,
//     };

//     if (id != null) {
//       map[idColumn] = id;
//     }
//     return map;
//   }

//   @override
//   // ignore: missing_return
//   String toString() {
//     return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
//   }
// }
