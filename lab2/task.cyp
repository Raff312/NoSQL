create
    (platon:Person { fio: "Иванов Платон Маркович", age: 27, gender: "М" }),
    (antonina:Person { fio: "Игнатова Антонина Ивановна", age: 19, gender: "Ж" }),
    (daniil:Person { fio: "Николаев Даниил Александрович", age: 28, gender: "М" }),
    (anna:Person { fio: "Романова Анна Артуровна", age: 16, gender: "Ж" }),
    (olga:Person { fio: "Николаева Ольга Владимировна", age: 21, gender: "Ж" }),
    (saveliy:Person { fio: "Степанов Савелий Захарович", age: 25, gender: "М" }),
    (kira:Person { fio: "Беляева Кира Николаевна", age: 30, gender: "Ж" }),
    (ekaterina:Person { fio: "Петухова Екатерина Евгеньевна", age: 28, gender: "Ж" }),
    (lev:Person { fio: "Сизов Лев Гордеевич", age: 29, gender: "М" }),
    (alexander:Person { fio: "Левин Александр Давидович", age: 24, gender: "М" }),
    (maria:Person { fio: "Анисимова Мария Георгиевна", age: 26, gender: "Ж" }),
    (ad:Group { name: "ТОКСИЧНЫЙ АД ДЕДА HELLYEAHPLAY" }),
    (simp:Group { name: "SimpDangeon" }),
    (didg:Group { name: "Диджитализируй!" }),
    (news:Group { name: "Ньюсач/Двач" }),
    (typic:Group { name: "Tynu40k Goblina" }),
    (mdk:Group { name: "MDK" }),
    (dvach:Group { name: "Двач" }),
    (kod:Group { name: "Код Дурова" }),
    (platon) - [:FOLLOWS] -> (ad), (platon) - [:FOLLOWS] -> (simp),
    (antonina) - [:FOLLOWS] -> (didg),
    (daniil) - [:FOLLOWS] -> (news),
    (anna) - [:FOLLOWS] -> (ad), (anna) - [:FOLLOWS] -> (simp),
    (olga) - [:FOLLOWS] -> (didg),
    (saveliy) - [:FOLLOWS] -> (mdk), (saveliy) - [:FOLLOWS] -> (typic),
    (kira) - [:FOLLOWS] -> (dvach), (kira) - [:FOLLOWS] -> (news),
    (ekaterina) - [:FOLLOWS] -> (dvach), (ekaterina) - [:FOLLOWS] -> (news),
    (lev) - [:FOLLOWS] -> (simp),
    (alexander) - [:FOLLOWS] -> (kod), (alexander) - [:FOLLOWS] -> (didg),
    (maria) - [:FOLLOWS] -> (mdk), (maria) - [:FOLLOWS] -> (typic),
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

create
    (p1:Post { id: 1, text: "Безусловно, постоянный количественный рост и сфера нашей активности обеспечивает актуальность первоочередных требований. Равным образом, высококачественный прототип будущего проекта напрямую зависит от дальнейших направлений развития." }),
    (p2:Post { id: 2, text: "С учётом сложившейся международной обстановки, консультация с широким активом, а также свежий взгляд на привычные вещи — безусловно открывает новые горизонты для благоприятных перспектив." }),
    (p3:Post { id: 3, text: "Как уже неоднократно упомянуто, акционеры крупнейших компаний неоднозначны и будут превращены в посмешище, хотя само их существование приносит несомненную пользу обществу." }),
    (p4:Post { id: 4, text: "Как принято считать, независимые государства являются только методом политического участия и представлены в исключительно положительном свете. Вот вам яркий пример современных тенденций — высокое качество позиционных исследований создаёт предпосылки для анализа существующих паттернов поведения. Разнообразный и богатый опыт говорит нам, что существующая теория позволяет выполнить важные задания по разработке кластеризации усилий." }),
    (p5:Post { id: 5, text: "Также как перспективное планирование однозначно фиксирует необходимость переосмысления внешнеэкономических политик. Есть над чем задуматься: действия представителей оппозиции лишь добавляют фракционных разногласий и объявлены нарушающими общечеловеческие нормы этики и морали." }),
    (p6:Post { id: 6, text: "Равным образом, семантический разбор внешних противодействий выявляет срочную потребность распределения внутренних резервов и ресурсов." }),
    (p7:Post { id: 7, text: "Безусловно, повышение уровня гражданского сознания способствует подготовке и реализации новых предложений." });

match (a1:Person { fio: "Романова Анна Артуровна" })
match (p1:Post { id: 1 })
match (p3:Post { id: 3 })
match (p5:Post { id: 5 })
create (a1) - [:CREATES] -> (p1)
create (a1) - [:REPOST] -> (p3)
create (a1) - [:REPOST] -> (p5);

match (a2:Person { fio: "Николаева Ольга Владимировна" })
match (p2:Post { id: 2 })
match (p5:Post { id: 5 })
create (a2) - [:CREATES] -> (p2)
create (a2) - [:REPOST] -> (p5);

match (a3:Person { fio: "Степанов Савелий Захарович" })
match (p3:Post { id: 3 })
match (p4:Post { id: 4 })
match (p6:Post { id: 6 })
match (p7:Post { id: 7 })
create (a3) - [:CREATES] -> (p3)
create (a3) - [:REPOST] -> (p4)
create (a3) - [:REPOST] -> (p5)
create (a3) - [:REPOST] -> (p7);

match (a4:Person { fio: "Беляева Кира Николаевна" })
match (p4:Post { id: 4 })
match (p2:Post { id: 2 })
match (p5:Post { id: 5 })
create (a4) - [:CREATES] -> (p4)
create (a4) - [:REPOST] -> (p2)
create (a4) - [:REPOST] -> (p5);

match (a5:Person { fio: "Петухова Екатерина Евгеньевна" })
match (p2:Post { id: 2 })
match (p5:Post { id: 5 })
create (a5) - [:CREATES] -> (p5)
create (a5) - [:REPOST] -> (p2);

match (a6:Person { fio: "Сизов Лев Гордеевич" })
match (p6:Post { id: 6 })
match (p2:Post { id: 2 })
match (p5:Post { id: 5 })
create (a6) - [:CREATES] -> (p6)
create (a6) - [:REPOST] -> (p2)
create (a6) - [:REPOST] -> (p5);

match (a7:Person { fio: "Левин Александр Давидович" })
match (p7:Post { id: 7 })
match (p6:Post { id: 6 })
create (a7) - [:CREATES] -> (p7)
create (a7) - [:REPOST] -> (p6);

match (a8:Person { fio: "Анисимова Мария Георгиевна" })

match (a30:Person { fio: "Иванов Платон Маркович" })
match (p7:Post { id: 7 })
match (p6:Post { id: 6 })
create (a30) - [:REPOST] -> (p7)
create (a30) - [:REPOST] -> (p6);

match (a30:Person { fio: "Иванов Платон Маркович" })
match (p7:Post { id: 7 })
create (a30) - [:CREATES] -> (p7)


match (a0:Person { fio: "Николаев Даниил Александрович" })
match (p4:Post { id: 4 })
match (p2:Post { id: 2 })
match (p5:Post { id: 5 })
match (p3:Post { id: 3 })
create (a0) - [:REPOST] -> (p4)
create (a0) - [:REPOST] -> (p2)
create (a0) - [:REPOST] -> (p5)
create (a0) - [:REPOST] -> (p3);


match (person:Person) - [:REPOST] -> (post:Post)
with person, count(post) as postsCount
with max(postsCount) as max
match (person:Person) - [:REPOST] -> (post:Post)
WITH person, count(post) as count, max
where count = max
with person
match (person) - [:FRIENDS * 2] -> (n:Person)
where not (person) - [:FRIENDS] -> (n) and not (n) = (person)
match (n) - [:CREATES] -> (post:Post)
return post.text
order by size(post.text) desc
limit 3;