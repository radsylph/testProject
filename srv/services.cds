// archivo: srv/services.cds
using {com.test as db} from '../db/schemaTest';

service testService @(path: '/testRoute') {
    entity employee           as projection on db.employee;
    entity client             as projection on db.client;
    entity project            as projection on db.project;
    entity workGroup          as projection on db.workGroup;
    entity workGroup_employee as projection on db.workGroup_employee;
    entity workGroup_project  as projection on db.workGroup_project;
    entity objetive           as projection on db.objetive;
}
