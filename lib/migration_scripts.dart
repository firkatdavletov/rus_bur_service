const migrationScripts = [
  '''CREATE TABLE reports(
    report_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER FOREIGN KEY,
    customer_id INTEGER FOREIGN KEY,
    machine_id INTEGER FOREIGN KEY,
    engine_id INTEGER FOREIGN KEY,
    report_name TEXT,
    report_date TEXT,
    report_place TEXT,
    report_note TEXT
  )''',
  '''CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_company TEXT NOT NULL,
    customer_firstname TEXT,
    customer_lastname TEXT,
    customer_middlename TEXT,
    customer_phone TEXT,
    customer_email TEXT
  )''',
  '''CREATE TABLE machines(
    machine_id INTEGER PRIMARY KEY AUTOINCREMENT,
    machine_model TEXT NOT NULL,
    machine_sn TEXT NOT NULL,
    machine_year TEXT
  )''',
  '''CREATE TABLE engines(
    engine_id INTEGER PRIMARY KEY AUTOINCREMENT,
    engine_model TEXT NOT NULL,
    engine_sn TEXT NOT NULL,
    engine_optime TEXT
  )''',
  '''CREATE TABLE users(
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_login TEXT NOT NULL,
    user_firstname TEXT NOT NULL,
    user_lastname TEXT NOT NULL,
    user_middlename TEXT
  )''',
  '''INSERT INTO users(
    user_login,
    user_firstname,
    user_lastname,
    user_middlename 
  ) VALUES (
    'admin',
    'firstname',
    'lastname',
    'middlename'
  )'''
];

int numbScripts = migrationScripts.length;

const createAdmin = '''
  
''';