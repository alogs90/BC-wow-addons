local L = LibStub("AceLocale-3.0"):NewLocale("Gladdy", "ruRU", false)
if (not L) then return end

-- Addon title
L["Gladdy"] = "Гладди"

-- Bindings
L["Trinked used enemy #1"] = "Использование тринкета цели #1"
L["Trinked used enemy #2"] = "Использование тринкета цели #2"
L["Trinked used enemy #3"] = "Использование тринкета цели #3"
L["Trinked used enemy #4"] = "Использование тринкета цели #4"
L["Trinked used enemy #5"] = "Использование тринкета цели #5"

-- Specs
L["Balance"] = "Баланс"
L["Feral"] = "Сила зверя"
L["Restoration"] = "Исцеление"
L["Beast Mastery"] = "Чувство зверя"
L["Marksmanship"] = "Стрельба"
L["Survival"] = "Выживание"
L["Arcane"] = "Тайная магия"
L["Fire"] = "Огонь"
L["Frost"] = "Лед"
L["Holy"] = "Свет"
L["Protection"] = "Защита"
L["Retribution"] = "Возмездие"
L["Discipline"] = "Послушание"
L["Shadow"] = "Тьма"
L["Assassination"] = "Ликвидация"
L["Combat"] = "Бой"
L["Subtlety"] = "Скрытность"
L["Elemental"] = "Cтихии"
L["Enhancement"] = "Совершенствование"
L["Affliction"] = "Колдовство"
L["Demonology"] = "Демонология"
L["Destruction"] = "Разрушение"
L["Arms"] = "Оружие"
L["Fury"] = "Неистовство"

-- Horde races
L["Orc"] = "Орк"
L["Undead"] = "Нежить"
L["Tauren"] = "Таурен"
L["Troll"] = "Тролль"
L["Blood Elf"] = "Кровавый эльф"

-- Modifiers
L["CTRL"] = "CTRL"
L["SHIFT"] = "SHIFT"
L["ALT"] = "ALT"

-- Mouse buttons
L["Left button"] = "Левая кнопка"
L["Right button"] = "Правая кнопка"
L["Middle button"] = "Средня кнопка"
L["Button 4"] = "Кнопка 4"
L["Button 5"] = "Кнопка 5"

-- Announcement types
L["Self"] = "Аддон"
L["Party"] = "Групповой чат"
L["Say"] = "Общий чат"
L["Raid Warning"] = "Объявление рейду"
L["Scrolling Combat Text"] = "Scrolling Combat Text"
L["MikScrollingBattleText"] = "MikScrollingBattleText"
L["Blizzard's Floating Combat Text"] = "Blizzard's Floating Combat Text"
L["Parrot"] = "Parrot"
L["SpellAlert"] = "SpellAlert"
L["Disabled"] = "Выключено"

--Announcements
L["LOW HEALTH: %s"] = "МАЛО ЖИЗНЕЙ: %s"
L["TRINKET READY: %s (%s)"] = "ТРИНКЕТ ГОТОВ: %s (%s)"
L["TRINKET USED: %s (%s)"] = "ТРИНКЕТ ИСПОЛЬЗОВАН: %s (%s)"
L["DRINKING: %s (%s)"] = "ПЬЕТ: %s (%s)"
L["RESURRECTING: %s (%s)"] = "ВОСКРЕШАЕТ: %s (%s)"
L["SPEC DETECTED: %s - %s %s"] = "ОБНАРУЖЕН СПЕК: %s - %s %s"

-- Trinket values
L["Name text"] = "Текст возле имени"
L["Name icon"] = "Иконка возле имени"
L["Big icon"] = "Большая иконка"
L["Override class/aura icon"] = "Перекрывающая иконка"
L["Small icon"] = "Маленькая иконка"
L["Grid-style icon"] = "Grid-стайл иконка"

-- Misc
L["Gladdy - drag to move"] = "Гладди - тащите для перемещения"
L["Arena "] = "Арена "
L["Unknown"] = "Неизвестно"

-- Attributes
L["Action #%d"] = "Действие #%d"
L["None"] = "Нету"
L["Cast Spell"] = "Применить заклинание"
L["Delete"] = "Удалить"
L["Select the name of the click option"] = "Выберите название для опции клика"
L["Button"] = "Кнопка"
L["Select which mouse button to use"] = "Выберите, какую кнопку использовать"
L["Modifier"] = "Модификатор"
L["Select which modifier to use"] = "Выберите, какой модификатор применять"
L["Action"] = "Действие"
L["Select what action this mouse button does"] = "Выберите действие"
L["Spell name / Macro text"] = "Заклинание / Макро"

-- Welcome
L["Welcome to Gladdy!"] = "Вас приветствует Гладди!"
L["First launch detected, displaying test frame"] = "Обнаружен первый запуск. Показываем тестовое окно"
L["Valid slash commands are:"] = "Правильные команды:"
L["If it not first launch, then move or lock frame"] = "Если у вас это не первый запуск, переместите, либо закрепите окно"

-- Options
L["General"] = "Основные"
L["General settings"] = "Основые настройки"
L["Lock frame"] = "Закрепить фрейм"
L["Toggle if frame can be moved"] = "Включите, если фрейм можно двигать"
L["Grow frame upwards"] = "Расти вверх"
L["If enabled the frame will grow upwards instead of downwards"] = "Если включено, то фрейм будет расти вверх, а не вниз"
L["Frame resize"] = "Автоизменение высоты"
L["If enabled the frame will update height depending on current bracket"] = "Если включено, то фрейм будет автоматически изменять свою высоту, в зависимости от текущего брекета"
L["Frame scale"] = "Размер фрейма"
L["Scale of the frame"] = "Размер фрейма"
L["Frame padding"] = "Отступы фрейма"
L["Padding of the frame"] = "Отступы фрейма"
L["Frame color"] = "Цвет фрейма"
L["Color of the frame"] = "Цвет фрейма"
L["Highlight target"] = "Подсвечивать цель"
L["Toggle if the selected target should be highlighted"] = "Включите, если необходима подсветка вашей цели"
L["Show border around target"] = "Отображать контур вокруг цели"
L["Toggle if a border should be shown around the selected target"] = "Включите, если контур должен появляться вокруг выбранной цели"
L["Show border around focus"] = "Отображать контур вокруг фокуса"
L["Toggle of a border should be shown around the current focus"] = "Включите, если контур должен появляться вокруг фокуса"
L["Show border around raid leader"] = "Отображать контур вокруг цели рейд лидера"
L["Toggle if a border should be shown around the raid leader"] = "Включите, если контур должен появляться вокруг цели рейд лидера"
L["Clique support"] = "Поддержка Clique"
L["Toggles the Clique support, requires UI reload to take effect"] = "Включает поддержку Clique (требуется перезагрузка интерфейса)"					
L["Announcements"] = "Уведомления"
L["Set options for different announcements"] = "Настройки уведомление"
L["Announce type"] = "Тип уведомления"
L["How should we announce"] = "Как мы должны вас оповещать"
L["New enemies"] = "Новые враги"
L["Announce new enemies found"] = "Уведомлять о новых врагах"
L["Talent spec detection"] = "Обнаружение спека"
L["Announce when an enemy's talent spec is discovered"] = "Уведомлять при обнаружении спека противника"
L["Drinking"] = "Питье"
L["Announces enemies that start to drink"] = "Уведомлять, если противник начал пить"
L["Resurrections"] = "Воскрешение"
L["Announces enemies who starts to cast a resurrection spell"] = "Уведомлять, если противник начал применять воскрешающее заклинание"
L["Trinket used"] = "Использование тринкета"
L["Announce when an enemy's trinket is used"] = "Уведомлять, когда противник использует тринкет"
L["Trinket ready"] = "Готовность тринкета"
L["Announce when an enemy's trinket is ready again"] = "Уведомлять, когда тринкет одного из противников будет готов"
L["Enemies on low health"] = "Враги с малым здоровьем"
L["Announce enemies that go below a certain percentage of health"] = "Уведомлять, когда здоровье врагов упадет ниже определенного значение"
L["Low health percentage"] = "Порог здоровья"
L["The percentage when enemies are counted as having low health"] = "Проценть, при котором враги считаются с малым здоровьем"
L["Trinket display"] = "Отображение тринкета"
L["Set options for the trinket status display"] = "Настроить отображение пвп тринкета"
L["Show PvP trinket status"] = "Показывать статус пвп тринкета?"
L["Show PvP trinket status to the right of the enemy name"] = "Показывать статус пвп тринкета?"
L["Choose how to display the trinket status"] = "Выберите стиль отображения тринкета"
L["Big icon scale"] = "Размер большой иконки"
L["The scale of the big trinket icon"] = "Размер большой иконки"
L["Bars"] = "Полосы"
L["Bars settings"] = "Настройки полос"
L["Show cast bars"] = "Показывать полосы применения"
L["Show power bars"] = "Показывать полосы маны"
L["Size and margin"] = "Размеры и поля"
L["Size and margin settings"] = "Настройки размеров и полей"
L["Bar width"] = "Ширина полос"
L["Width of the health/power bars"] = "Ширина полос здоровья/маны"
L["Bar height"] = "Высота полос"
L["Width of the health bar"] = "Высота полос здоровья"
L["Power bar height"] = "Высота полос маны"
L["Height of the power bar"] = "Высота полос маны"
L["Cast bar height"] = "Высота полос применения"
L["Height of the cast bar"] = "Высота полос применения"
L["Bar bottom margin"] = "Отступ до следующей полосы"
L["Margin to the next bar"] = "Отступ до следующей полосы"
L["Colors"] = "Цвета"
L["Color settings"] = "Настройки цвета"
L["Color by class"] = "Цвет по классу"
L["Color the health bar by class"] = "Цвета полосы здоровья, в зависимости от класса"
L["Health bar color"] = "Цвет полосы здоровья"
L["Color of the health bar"] = "Цвет полосы здоровья"
L["Bar texture"] = "Текстура полос"
L["Texture of health/cast bars"] = "Текстура полос"
L["Mana color"] = "Цвет маны"
L["Color of the mana bar"] = "Цвет маны"
L["Game default"] = "Цвет по-умолчанию"
L["Use game default mana color"] = "Цвет маны по-умолчанию"
L["Energy color"] = "Цвет энергии"
L["Color of the energy bar"] = "Цвет энергии"
L["Game default"] = "Цвет по-умолчанию"
L["Use game default energy color"] = "Цвет энергии по-умолчанию"
L["Rage color"] = "Цвет ярости"
L["Color of the rage bar"] = "Цвет ярости"
L["Game default"] = "Цвет по-умолчанию"
L["Use game default rage color"] = "Цвет ярости по-умолчанию"
L["Cast bar color"] = "Цвет полосы применения"
L["Color of the cast bar"] = "Цвет полосы применения"
L["Cast bar background color"] = "Фоновый цвет полосы применения"
L["Color of the cast bar background"] = "Фоновый цвет полосы применения"
L["Text"] = "Текст"
L["Text settings"] = "Настройки текста"
L["Shorten Health/Power text"] = "Короткий текст здоровья/маны"
L["Shorten the formatting of the health and power text to e.g. 20.0/25.3 when the amount is over 9999"] = "Укороченные значения здоровья/маны, когда их значение более 9999"
L["Show health percentage"] = "Показвать здоровье в процентах"
L["Show health percentage on the health bar"] = "Показвать здоровье в процентах"
L["Show the actual health"] = "Показывать текущее здоровье"
L["Show the actual health on the health bar"] = "Show the actual health on the health bar"
L["Show max health"] = "Показывать максимальное здоровье"
L["Show maximum health on the health bar"] = "Показывать максимальное здоровье"
L["Show power text"] = "Показывать текст маны"
L["Show mana/energy/rage text on the power bar"] = "Показывать текст маны"
L["Show power percentage"] = "Показывать ману в процентах"
L["Show mana/energy/rage percentage on the power bar"] = "Показывать ману в процентах"
L["Show the actual power"] = "Показывать текущую ману"
L["Show the actual mana/energy/rage on the power bar"] = "Показывать текущую ману"
L["Show max power"] = "Показыать максимальную ману"
L["Show maximum mana/energy/rage on the power bar"] = "Показыать максимальную ману"
L["Show race text"] = "Текст расы"
L["Show race text on the power bar"] = "Текст расы"
L["Show spec text"] = "Текст спека"
L["Show spec text on the power bar"] = "Текст спека"
L["Show DR text"] = "ДР текст"
L["Show DR text on the icons"] = "ДР текст"
L["Health text size"] = "Размер текста здоровья"
L["Size of the health bar text"] = "Размер текста на полосах здоровья"
L["Mana text size"] = "Размер текста маны"
L["Size of the mana bar text"] = "Размер текста на полосах маны"
L["Cast bar text size"] = "Размер текста применения"
L["Size of the cast bar text"] = "Размер текста на полосах применения"
L["Aura text size"] = "Размер текста ауры"
L["Size of the aura text"] = "Размео текста на иконках ауры"
L["DR text size"] = "Размер текста ДР"
L["Size of the DR text"] = "Размер текста на иконках ДО"
L["Colors"] = "Цвета"
L["Color settings"] = "Настройки цвета"
L["Health text color"] = "Цвет текста здоровья"
L["Color of the health bar text"] = "Цвет текста здоровья"
L["Mana text color"] = "Цвет текста маны"
L["Color of the mana bar text"] = "Цвет текста маны"
L["Cast bar text color"] = "Цвет текста применения"
L["Color of the cast bar text"] = "Цвет текста применения"
L["Aura text color"] = "Цвет текста ауры"
L["Color of the aura text"] = "Цвет текста ауры"
L["DR text color"] = "Цвет текста ДР"
L["Color of the DR text"] = "Цвет текста ДР"
L["DR tracker"] = "ДР"
L["DR settings"] = "Настройки ДР"
L["Show icons"] = "Включен"
L["Show DR cooldown icons"] = "Отображать иконки ДР"
L["Left"] = "Лево"
L["Right"] = "Право"
L["Icon Size"] = "Размер иконки"
L["Size of the DR Icons"] = "Размер иконки"
L["DR Cooldown anchor"] = "Якорь расположения иконок"
L["Anchor of the cooldown icons"] = "Якорь расположения иконок"
L["Top"] = "Верх"
L["Center"] = "Центр"
L["Bottom"] = "Низ"
L["Auras"] = "Ауры"
L["Aura settings"] = "Настройки ауры"
L["Add new aura"] = "Добавить новую ауру"
L["Name"] = "Название"
L["Name of the aura"] = "Название новой ауры"
L["Priority"] = "Приоритет"
L["Select what priority the aura should have - higher equals more priority"] = "Выберите приоритет"
L["Add"] = "Добавить"
L["Add an aura"] = "Добавить ауру"
L["Aura list"] = "Список аур"
L["List of enabled auras"] = "Список включенных аур"
L["Clicks"] = "Клики"
L["Click settings"] = "Настройки кликов"