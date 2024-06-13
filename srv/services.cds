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

// annotate testService.project with @Aggregation.ApplySupported: {
//     Transformations       : [
//         'aggregate',
//         'topcount',
//         'bottomcount',
//         'identity',
//         'concat',
//         'groupby',
//         'filter',
//         'search'
//     ],
//     Rollup                : #None,
//     PropertyRestrictions  : true,
//     GroupableProperties   : [],
//     AggregatableProperties: [],
// }; testear despues  https://learning.sap.com/learning-journeys/developing-an-sap-fiori-elements-app-based-on-a-cap-odata-v4-service/adding-a-chart-to-the-list-report_d228124b-1918-40be-b386-16d9e5af6897
