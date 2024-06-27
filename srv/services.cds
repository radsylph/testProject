using {com.test as db} from '../db/schemaTest';


service testService @(path: '/testRoute') {
    entity employee           as projection on db.employee;
    entity client             as projection on db.client;
    entity project            as projection on db.project;
    entity workGroup          as projection on db.workGroup;
    entity workGroup_employee as projection on db.workGroup_employee;
    entity workGroup_project  as projection on db.workGroup_project;
    entity objective          as projection on db.objective;
}

service libraryService @(path: '/libraryRoute') {
    entity book as projection on db.book;
}

annotate libraryService.book with @(
    Aggregation.ApplySupported              : {
        Transformations       : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'search'
        ],
        Rollup                : #None,
        PropertyRestrictions  : true,
        GroupableProperties   : [
            ID,
            category1,
            category2,
            title,
            publishedAt
        ],
        AggregatableProperties: [{
            $Type   : 'Aggregation.AggregatablePropertyType',
            Property: stock
        }, ],
    },
    Analytics.AggregatedProperty #totalStock: {
        $Type               : 'Analytics.AggregatedPropertyType',
        AggregatableProperty: stock,
        AggregationMethod   : 'sum',
        Name                : 'totalStock',
        ![@Common.Label]    : 'Total Stock'
    }
);
