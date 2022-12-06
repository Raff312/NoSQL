// 2.1.1
db.getCollection('labs').aggregate([
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

// 2.1.2
db.getCollection('labs').aggregate([
    {
        $match: { "URL": "https://google.com/" }
    },
    {
        $group: {
            _id: "$IP"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

// 2.1.3
db.getCollection('labs').find({
    timeStamp: { $gte: "2017-08-25T16:40:00Z", $lte: "2017-08-25T17:00:00Z" }
}, { _id: 0, "URL": 1 }).sort({ "URL": -1 });

db.getCollection('labs').aggregate([
    {
        $match: { timeStamp: { $gte: "2017-08-25T16:40:00Z", $lte: "2017-08-25T17:00:00Z" } }
    },
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

// 2.1.4
db.getCollection('labs').aggregate([
    {
        $match: { "IP": "252.73.135.153" }
    },
    {
        $group: {
            _id: "$URL"
        }
    },
    {
        $sort: { _id: 1 }
    }
]);

// 2.2.1
db.getCollection('labs').aggregate([
    {
        $group: {
            _id: "$URL",
            SumTimeSpent: { $sum: "$timeSpent" }
        }
    },
    {
        $sort: { "SumTimeSpent": -1 }
    }
]);

// 2.2.2
db.getCollection('labs').aggregate([
    {
        $group: {
            _id: "$URL",
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: { "NumberOfVisits": -1 }
    }
]);

// 2.2.3
db.getCollection('labs').aggregate([
    {
        $match: {
            timeStamp: { $gte: "2016-08-25T16:40:00Z", $lte: "2022-08-25T17:00:00Z" }
        }
    },
    {
        $addFields: {
            "date": { $toDate: "$timeStamp"}
        }
    },
    {
        $group: {
            _id: {
                URL: "$URL",
                day: { $dayOfMonth: "$date" }
            },
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: {
            _id: 1,
            "NumberOfVisits": -1
        }
    }
]);

// 2.2.4
db.getCollection('labs').aggregate([
    {
        $group: {
            _id: "$IP",
            SumTimeSpent: { $sum: "$timeSpent" },
            NumberOfVisits: { $sum: 1 }
        }
    },
    {
        $sort: {
            _id: 1,
            "NumberOfVisits": -1,
            "SumTimeSpent": -1
        }
    }
]);
