// 1
create
    (platon:Person { fio: "Иванов Платон Маркович", age: 27, gender: "М", groups: ["ТОКСИЧНЫЙ АД ДЕДА HELLYEAHPLAY", "SimpDangeon"] }),
    (antonina:Person { fio: "Игнатова Антонина Ивановна", age: 19, gender: "Ж", groups: ["Диджитализируй!"] }),
    (daniil:Person { fio: "Николаев Даниил Александрович", age: 28, gender: "М", groups: ["Ньюсач/Двач"] }),
    (anna:Person { fio: "Романова Анна Артуровна", age: 16, gender: "Ж", groups: ["ТОКСИЧНЫЙ АД ДЕДА HELLYEAHPLAY", "SimpDangeon"] }),
    (olga:Person { fio: "Николаева Ольга Владимировна", age: 21, gender: "Ж", groups: ["Диджитализируй!"] }),
    (saveliy:Person { fio: "Степанов Савелий Захарович", age: 25, gender: "М", groups: ["MDK", "Tynu40k Goblina"] }),
    (kira:Person { fio: "Беляева Кира Николаевна", age: 30, gender: "Ж", groups: ["Двач", "Ньюсач/Двач"] }),
    (ekaterina:Person { fio: "Петухова Екатерина Евгеньевна", age: 28, gender: "Ж", groups: ["Двач", "Ньюсач/Двач"] }),
    (lev:Person { fio: "Сизов Лев Гордеевич", age: 29, gender: "М", groups: ["SimpDangeon"] }),
    (alexander:Person { fio: "Левин Александр Давидович", age: 24, gender: "М", groups: ["Код Дурова", "Диджитализируй!"] }),
    (maria:Person { fio: "Анисимова Мария Георгиевна", age: 26, gender: "Ж", groups: ["MDK", "Tynu40k Goblina"] }),
    (lev) - [:FRIENDS] -> (alexander), (alexander) - [:FRIENDS] -> (lev),
    (alexander) - [:FRIENDS] -> (platon), (platon) - [:FRIENDS] -> (alexander),
    (alexander) - [:FRIENDS] -> (daniil), (daniil) - [:FRIENDS] -> (alexander),
    (platon) - [:FRIENDS] -> (maria), (maria) - [:FRIENDS] -> (platon),
    (maria) - [:FRIENDS] -> (antonina), (antonina) - [:FRIENDS] -> (maria),
    (anna) - [:FRIENDS] -> (ekaterina), (ekaterina) - [:FRIENDS] -> (anna),
    (ekaterina) - [:FRIENDS] -> (kira), (kira) - [:FRIENDS] -> (ekaterina),
    (kira) - [:FRIENDS] -> (anna), (anna) - [:FRIENDS] -> (kira),
    (saveliy) - [:FRIENDS] -> (lev), (lev) - [:FRIENDS] -> (saveliy),
    (olga) - [:FRIENDS] -> (kira), (kira) - [:FRIENDS] -> (olga),
    (olga) - [:FRIENDS] -> (anna), (anna) - [:FRIENDS] -> (olga),
    (ekaterina) - [:FRIENDS] -> (daniil), (daniil) - [:FRIENDS] -> (ekaterina);

// 2.1
match (p:Person)
return p.fio as ФИО
order by p.fio;

// 2.2
match (p:Person)
where p.gender = 'М'
return p.fio as ФИО, p.age as Возраст
order by p.age desc;

// 2.3
match (:Person { fio: "Романова Анна Артуровна" }) - [:FRIENDS] -> (n)
return n.fio as ФИО
order by n.fio;

// 2.4
match (p:Person { fio: "Романова Анна Артуровна" }) - [:FRIENDS * 2] -> (n)
where not (p) - [:FRIENDS] -> (n) and not (n) = (p)
return distinct n.fio as ФИО
order by n.fio;

// 2.5
match (p:Person) - [:FRIENDS] -> (n)
return distinct p.fio as ФИО, count(n) as КоличествоДрузей
order by p.fio;

// 2.6
match (p:Person)
unwind p.groups as group
return distinct group as Группа
order by group;

// 2.7
match (p:Person { fio: "Романова Анна Артуровна" })
unwind p.groups as group
return distinct group as Группа
order by group;

// 2.8
match (p:Person)
unwind p.groups as group
return distinct group as Группа, count(group) as КоличествоЧленов
order by КоличествоЧленов desc;

// 2.9
match (p:Person)
return distinct p.fio as ФИО, size(p.groups) as КоличествоГрупп
order by КоличествоГрупп desc;

// 2.10
match (p:Person { fio: "Сизов Лев Гордеевич" }) - [:FRIENDS * 2] -> (n)
where not (p) - [:FRIENDS] -> (n) and not (n) = (p)
return distinct n.fio as ФИО, size(n.groups) as КоличествоГрупп
order by КоличествоГрупп desc;
