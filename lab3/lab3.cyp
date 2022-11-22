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
load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/user-nodes.csv' as row
create (person:Person {
    id: row.id,
    name: row.name
});

load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/message-nodes.csv' as row
create (message:Message {
    id: row.id,
    text: row.text
});

load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/user-relationships.csv' as row
match (source:Person { id: row.src })
match (destination:Person { id: row.dst })
merge (source) - [:FOLLOWS { distance: toInteger(row.dist) }] -> (destination);

load csv with headers
from 'https://raw.githubusercontent.com/Raff312/NoSQL/main/lab3/message-relationships.csv' as row
match (source:Person { id: row.src })
match (destination:Message { id: row.dst })
merge (source) - [:FOLLOWS { distance: toInteger(row.dist) }] -> (destination);

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

