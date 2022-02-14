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
    engine_optime_1 INTEGER,
    engine_optime_2 INTEGER,
    engine_optime_3 INTEGER,
    engine_optime_4 INTEGER
  )''',
  '''CREATE TABLE users(
    user_id INTEGER PRIMARY KEY,
    user_login TEXT NOT NULL,
    user_firstname TEXT NOT NULL,
    user_lastname TEXT NOT NULL,
    user_middlename TEXT,
    user_is_admin INTEGER NOT NULL,
    user_is_superadmin INTEGER NOT NULL
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
    effect TEXT,
    term_week INTEGER,
    term_mh INTEGER,
    term_bh INTEGER,
    term_m INTEGER,
    man_hours INTEGER,
    status INTEGER NOT NULL,
    term_status INTEGER NOT NULL
  )''',
  '''CREATE TABLE pictures(
    picture_id INTEGER PRIMARY KEY AUTOINCREMENT,
    report_id INTEGER NOT NULL,
    card_id TEXT,
    picture_name TEXT,
    picture_description TEXT,
    picture_file_name INTEGER
  )''',
  '''CREATE TABLE agreed_parts(
    report_id INTEGER NOT NULL,
    part_id INTEGER NOT NULL
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Двигатель"
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Трансмиссия"
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Коробка передач"
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Шасси"
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Электроника"
  )''',
  '''INSERT INTO parts (
    part_name
  ) VALUES (
    "Гидравлика"
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Произвести диагностику двигателя",
    1,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Замена уплотнительных колец",
    1,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Протяжка всех болтовых соединений",
    2,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Замена трансмиссионного масла",
    2,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Замена масла в коробке передач",
    3,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Регулировка межосевого зазора",
    3,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Замена кронштейна тяги",
    4,
    1
  )''',
  '''INSERT INTO operations (
    operation_name,
    part_id,
    is_required
  ) VALUES (
    "Замена контроллера управления",
    5,
    1
  )''',
  '''INSERT INTO reports (
    user_id,
    report_name,
    report_date,
    customer_company,
    customer_name,
    customer_phone,
    customer_email,
    machine_model,
    machine_sn,
    machine_year,
    report_place,
    report_note,
    engine_model,
    engine_sn,
    engine_optime_1,
    engine_optime_2,
    engine_optime_3,
    engine_optime_4
  ) VALUES (
    1,
    "1-1",
    "1/12/2021",
    "ООО Промтех",
    "Иванов Василий Иванович",
    "89993456787",
    "ivanov@promtech.ru",
    "КРС-4521",
    "4565494-355",
    "2011",
    "Екатеринбург, пр.Космонавтов, 18",
    "Примечание",
    "ДВС-456",
    "45675-6",
    "23",
    "6",
    "0",
    "1" 
  )''',
  '''INSERT INTO reports (
    user_id,
    report_name,
    report_date,
    customer_company,
    customer_name,
    customer_phone,
    customer_email,
    machine_model,
    machine_sn,
    machine_year,
    report_place,
    report_note,
    engine_model,
    engine_sn,
    engine_optime_1,
    engine_optime_2,
    engine_optime_3,
    engine_optime_4
  ) VALUES (
    1,
    "1-2",
    "5/12/2021",
    "ООО Семаргл",
    "Петров Сергей Сергеевич",
    "89594456787",
    "petrov@semargl.ru",
    "КП-4521",
    "43294-355",
    "2009",
    "Новосибирск, ул.Техническая, 1",
    "Примечание",
    "ДВС-436",
    "45235-6",
    "0",
    "356",
    "2",
    "1" 
  )''',
  '''INSERT INTO reports (
    user_id,
    report_name,
    report_date,
    customer_company,
    customer_name,
    customer_phone,
    customer_email,
    machine_model,
    machine_sn,
    machine_year,
    report_place,
    report_note,
    engine_model,
    engine_sn,
    engine_optime_1,
    engine_optime_2,
    engine_optime_3,
    engine_optime_4
  ) VALUES (
    1,
    "1-3",
    "25/01/2022",
    "ООО ТехноПарк",
    "Кольцов Кирилл Сергеевич",
    "84594756787",
    "kolcov@techpark.ru",
    "КЛ-345621",
    "4324-6455",
    "2005",
    "Нижний Тагил, пл.Революции, 5",
    "Примечание",
    "ДВС-56",
    "45335-6",
    "45",
    "3",
    "2",
    "1" 
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    1,
    2
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    1,
    3
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    1,
    4
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    2,
    4
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    2,
    1
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    3,
    1
  )''',
  '''INSERT INTO agreed_parts (
    report_id,
    part_id
  ) VALUES (
    1,
    5
  )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "1-2-3",
      "card name",
      3,
      1,
      1,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      1,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "1-2-4",
      "card name",
      4,
      1,
      2,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      2,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "1-3-5",
      "card name",
      5,
      1,
      3,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      3,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "1-3-6",
      "card name",
      6,
      1,
      1,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      1,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "1-4-7",
      "card name",
      7,
      1,
      2,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      2,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "2-4-7",
      "card name",
      7,
      2,
      2,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      2,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "2-1-1",
      "card name",
      1,
      2,
      1,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      3,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "2-1-2",
      "card name",
      2,
      2,
      3,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      2,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "3-1-1",
      "card name",
      1,
      3,
      1,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      1,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "3-1-2",
      "card name",
      1,
      3,
      2,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      2,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO cards(
      card_id,
      card_name,
      operation_id,
      report_id,
      conclusion,
      description,
      area,
      damage,
      priority,
      recommend,
      effect,
      man_hours,
      term_week,
      term_mh,
      term_bh,
      term_m,
      status,
      term_status
    ) VALUES (
      "3-5-8",
      "card name",
      8,
      3,
      3,
      "Описание проблемы",
      "Зона выявления дефекта",
      "Повреждения",
      3,
      "Рекомендации",
      "Положительный эффект",
      4,
      1,
      2,
      3,
      4,
      0,
      0
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "12355-1",
      5,
      "Масленка",
      "шт",
      "Износ",
      1,
      "1-2-3"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "8654-2",
      3,
      "Уплотнительное кольцо",
      "шт",
      "Износ",
      1,
      "1-2-4"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "23454-3",
      7,
      "Сальник",
      "шт",
      "Разрушение",
      2,
      "1-3-5"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "214-4",
      7,
      "Сопло",
      "шт",
      "Разрушение",
      2,
      "1-3-6"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "123543-5",
      3,
      "Гайка крепления поддона",
      "шт",
      "Разрушение",
      3,
      "1-4-7"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "2434-6",
      1,
      "Кронштейн тяги",
      "шт",
      "Разрушение",
      1,
      "2-4-7"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "34324-7",
      3,
      "Кулиса",
      "шт",
      "Разрушение",
      2,
      "2-1-1"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "324534-8",
      4,
      "Уплотнение крышки",
      "шт",
      "Разрушение",
      3,
      "2-1-2"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "23534-9",
      1,
      "Втулка оси",
      "шт",
      "Разрушение",
      1,
      "3-1-1"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "3435-10",
      3,
      "Полуось",
      "шт",
      "Разрушение",
      2,
      "3-1-2"
    )''',
  '''INSERT INTO spares(
      spare_number,
      spares_quantity,
      spare_name,
      spare_measure,
      spare_issue,
      spare_priority,
      card_id
    ) VALUES (
      "2454-11",
      1,
      "Тяга левая",
      "шт",
      "Разрушение",
      3,
      "3-5-8"
    )''',
];

int numbScripts = migrationScripts.length;
