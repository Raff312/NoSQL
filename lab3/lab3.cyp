// 1.1
load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/transport-nodes.csv' as row
create (place:Place {
    id: row.id,
    latitude: toFloat(row.latitude),
    longitude: toFloat(row.longitude),
    population: toInteger(row.population)
});

load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/transport-relationships.csv' as row
match (origin:Place { id: row.src })
match (destination:Place { id: row.dst })
merge (origin) - [:EROAD { distance: toInteger(row.cost) }] -> (destination);

// 1.2
match (n)
where not (n)--()
delete n;

// 1.3
call gds.graph.project("graph", "Place", "EROAD", { relationshipProperties: "distance" });

match (n:Place { id: "London" })
call gds.allShortestPaths.delta.stream("graph", {
    sourceNode: n,
    delta: 1.0,
    relationshipWeightProperty: "distance"
 })
yield index, sourceNode, targetNode, totalCost, nodeIds, costs, path
where not sourceNode = targetNode
return
    index,
    gds.util.asNode(sourceNode).id AS sourceId,
    gds.util.asNode(targetNode).id AS targetId,
    totalCost,
    [nodeId IN nodeIds | gds.util.asNode(nodeId).id] AS nodeIds,
    costs
order by totalCost;

// 2.1
create
(svetlana:Person { name: "Svetlana" }),
(anatoliy:Person { name: "Anatoliy" }),
(alena:Person { name: "Alena" }),
(emily:Person { name: "Emily" }),
(sophie:Person { name: "Sophie" }),
(james:Person { name: "James" }),
(michael:Person { name: "Michael" }),
(emma:Person { name: "Emma" }),
(isabella:Person { name:"Isabella" }),
(regina:Person { name: "Regina" }),
(timofey:Person { name: "Timofey" }),
(roman:Person { name: "Roman" }),
(stepan:Person { name: "Stepan" }),
(galina:Person { name:"Galina" }),
(oleg:Person { name: "Oleg" }),
(ivan:Person { name: "Ivan" }),
(inna:Person { name: "Inna" }),
(margarita:Person { name: "Margarita" }),
(maksim:Person { name: "Maksim" }),
(diana:Person { name: "Diana" }),

(a1:Message { text: "Привет!" }),
(a2:Message { text: "Пока!" }),
(a3:Message { text: "Берегитесь!" }),
(a4:Message { text: "Ничего не бывает" }),
(a5:Message { text: "Упади красиво" }),
(a6:Message { text: "Живи и ошибайся" }),
(a7:Message { text: "Выбрал короткий путь?" }),
(a8:Message { text: "Мой разум бессилен" }),
(a9:Message { text:"Все будет правильно" }),
(a10:Message { text: "Хочу сладкого!" }),
(a11:Message { text: "Она еще не сдалась" }),
(a12:Message { text: "Трудности произошли сейчас" }),
(a13:Message { text: "Человек ценен" }),
(a14:Message { text: "Не потрать зря" }),
(a15:Message { text: "Где умирает надежда?" }),
(a16:Message { text: "Пошел первый снег!" }),
(a17:Message { text: "Произошла потеря времени" }),
(a18:Message { text: "У нас все хорошо спланировано" }),
(a19:Message { text:"В каждом слове есть смысл" }),
(a20:Message { text: "Всегда есть шанс" }),

(svetlana)-[:FOLLOWS { dist: 300 }]->(anatoliy),
(svetlana)-[:FOLLOWS { dist: 400 }]->(alena),
(svetlana)-[:FOLLOWS { dist: 120 }]->(emily),
(anatoliy)-[:FOLLOWS { dist: 610 }]->(emily),
(anatoliy)-[:FOLLOWS { dist: 210 }]->(alena),
(anatoliy)-[:FOLLOWS { dist: 740 }]->(sophie),
(alena)-[:FOLLOWS { dist: 600 }]->(michael),
(alena)-[:FOLLOWS { dist: 450 }]->(james),
(emily)-[:FOLLOWS { dist: 350 }]->(regina),
(sophie)-[:FOLLOWS { dist: 150 }]->(emma),
(james)-[:FOLLOWS { dist: 750 }]->(stepan),
(michael)-[:FOLLOWS { dist: 520 }]->(galina),
(emma)-[:FOLLOWS { dist: 420 }]->(oleg),
(isabella)-[:FOLLOWS { dist: 270 }]->(ivan),
(regina)-[:FOLLOWS { dist: 170 }]->(inna),
(timofey)-[:FOLLOWS { dist: 290 }]->(margarita),
(roman)-[:FOLLOWS { dist: 490 }]->(maksim),
(stepan)-[:FOLLOWS { dist: 360 }]->(inna),
(galina)-[:FOLLOWS { dist: 760 }]->(roman),
(oleg)-[:FOLLOWS { dist: 1070 }]->(sophie),

(svetlana)-[:FOLLOWS { dist: 690 }]->(a1),
(svetlana)-[:FOLLOWS { dist: 690 }]->(a2),
(anatoliy)-[:FOLLOWS { dist: 450 }]->(a3),
(alena)-[:FOLLOWS { dist: 880 }]->(a4),
(emily)-[:FOLLOWS { dist: 880 }]->(a5),
(sophie)-[:FOLLOWS { dist: 380 }]->(a6),
(james)-[:FOLLOWS { dist: 480 }]->(a7),
(michael)-[:FOLLOWS { dist: 580 }]->(a8),
(michael)-[:FOLLOWS { dist: 580 }]->(a9),
(emma)-[:FOLLOWS { dist: 1190 }]->(a10),
(isabella)-[:FOLLOWS { dist: 1700 }]->(a11),
(regina)-[:FOLLOWS { dist: 430 }]->(a12),
(timofey)-[:FOLLOWS { dist: 360 }]->(a13),
(timofey)-[:FOLLOWS { dist: 360 }]->(a14),
(roman)-[:FOLLOWS { dist: 420 }]->(a15),
(stepan)-[:FOLLOWS { dist: 1420 }]->(a16),
(galina)-[:FOLLOWS { dist: 520 }]->(a17),
(galina)-[:FOLLOWS { dist: 1520 }]->(a18),
(oleg)-[:FOLLOWS { dist: 1420 }]->(a19),
(oleg)-[:FOLLOWS { dist: 1720 }]->(a20);

// 2.2
match (n)
where not (n)--()
delete n;

// 2.3
call gds.graph.project("usersGraph", "Person", "FOLLOWS");

call gds.alpha.closeness.harmonic.stream("usersGraph")
yield nodeId, centrality
return gds.util.asNode(nodeId).name AS name, centrality
order by centrality desc;

