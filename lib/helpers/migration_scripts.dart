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
    engine_optime_1 TEXT,
    engine_optime_2 TEXT,
    engine_optime_3 TEXT
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
    spares_quantity INTEGER NOT NULL,
    spare_name TEXT NOT NULL,
    spare_measure TEXT NOT NULL,
    spare_issue TEXT NOT NULL,
    spare_priority INTEGER NOT NULL,
    card_id TEXT NOT NULL
  )''',
  '''CREATE TABLE cards(
    card_id TEXT PRIMARY KEY,
    card_name TEXT NOT NULL,
    operation_id INTEGER NOT NULL,
    report_id INTEGER NOT NULL,
    conclusion INTEGER NOT NULL,
    description TEXT,
    area TEXT,
    damage TEXT,
    priority INTEGER NOT NULL,
    recommend TEXT,
    time TEXT,
    effect TEXT,
    man_hours INTEGER
  )''',
  '''CREATE TABLE pictures(
    picture_id INTEGER PRIMARY KEY AUTOINCREMENT,
    report_id INTEGER NOT NULL,
    card_id TEXT,
    picture_name TEXT,
    picture BLOB NOT NULL,
    picture_description TEXT
  )''',
  '''CREATE TABLE agreed_parts(
    report_id INTEGER NOT NULL,
    part_id INTEGER NOT NULL
  )'''
];

int numbScripts = migrationScripts.length;