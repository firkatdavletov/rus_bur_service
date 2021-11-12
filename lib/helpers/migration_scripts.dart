const migrationScripts = [
  '''CREATE TABLE reports(
    report_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    report_name TEXT NOT NULL,
    report_date TEXT NOT NULL,
    customer_company TEXT,
    customer_name TEXT,
    customer_phone TEXT,
    customer_email TEXT,
    machine_model TEXT,
    machine_sn TEXT,
    machine_year TEXT,
    report_place TEXT,
    report_note TEXT,
    engine_model TEXT,
    engine_sn TEXT,
    engine_optime TEXT
  )''',
  '''CREATE TABLE users(
    user_id INTEGER PRIMARY KEY,
    user_login TEXT NOT NULL,
    user_firstname TEXT NOT NULL,
    user_lastname TEXT NOT NULL,
    user_middlename TEXT,
    user_is_admin INTEGER NOT NULL
  )''',
  '''CREATE TABLE operations(
    operation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    operation_name TEXT NOT NULL,
    part_id INTEGER NOT NULL,
    is_required INTEGER NOT NULL
  )''',
  '''CREATE TABLE parts(
    part_id INTEGER PRIMARY KEY AUTOINCREMENT,
    part_name TEXT NOT NULL
  )''',
  '''CREATE TABLE spares(
    spare_id INTEGER PRIMARY KEY AUTOINCREMENT,
    spare_number TEXT NOT NULL,
    spare_name TEXT NOT NULL,
    spare_measure TEXT NOT NULL
  )''',
  '''CREATE TABLE cards(
    card_id INTEGER PRIMARY KEY AUTOINCREMENT,
    card_name TEXT NOT NULL,
    operation_id INTEGER NOT NULL,
    report_id INTEGER NOT NULL,
    conclusion TEXT NOT NULL,
    description TEXT,
    area TEXT,
    damage TEXT,
    priority TEXT,
    recommend TEXT,
    time TEXT,
    effect TEXT,
    man_hours INTEGER
  )''',
  '''CREATE TABLE used_parts(
    used_part_id INTEGER PRIMARY KEY AUTOINCREMENT,
    part_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL
  )''',
  '''CREATE TABLE pictures(
    picture_id INTEGER PRIMARY KEY AUTOINCREMENT,
    report_id INTEGER NOT NULL,
    card_id INTEGER,
    picture_name TEXT,
    picture BLOB NOT NULL,
    picture_description TEXT
  )'''
];

int numbScripts = migrationScripts.length;
