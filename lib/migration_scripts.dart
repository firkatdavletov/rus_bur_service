const migrationScripts = [
  '''CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)''',
  '''CREATE TABLE reports(
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    customer_id INTEGER,
    machine_id INTEGER,
    engine_id INTEGER,
    name TEXT,
    date TEXT,
    place TEXT,
    note TEXT
  )''',
  '''CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    customer_first_name TEXT,
    customer_last_name TEXT,
    customer_middle_name TEXT,
    customer_phone TEXT,
    customer_email TEXT
  )''',
  '''CREATE TABLE machines(
    machine_id INTEGER PRIMARY KEY,
    machine_model TEXT,
    machine_sn TEXT,
    machine_year TEXT
  )''',
  '''CREATE TABLE engines(
    engine_id INTEGER PRIMARY KEY,
    engine_model TEXT,
    engine_sn TEXT,
    engine_optime TEXT
  )'''
];

int numbScripts = migrationScripts.length;