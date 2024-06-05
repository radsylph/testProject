namespace com.test; //creo el namespace, que es como un schema en sql

using {
    cuid,
    sap.common.CodeList,
    managed
} from '@sap/cds/common'; //import las libreiras que voy a usar para crear mis modelos
using {Address} from '../types/types';

//creo mi entidad, mi modelo de la base de datos que es como un tipo enumerado
//codeList
entity genre : CodeList {
    key code  : String enum {
            Male   = 'Masculino';
            Female = 'Femenino';
            Other  = 'Otro';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

entity position : CodeList {
    key code  : String enum {
            Developer      = 'DEV';
            Tester         = 'TEST';
            Manager        = 'MANA';
            project_leader = 'LEAD';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

entity rank : CodeList {
    key code  : String enum {
            Junior = 'JUN';
            Senior = 'SEN';
            Master = 'MAS';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

entity status : CodeList {
    key code  : String enum {
            Active    = 'ACT';
            Inactive  = 'INA';
            Suspended = 'SUS';
            Deleted   = 'DEL';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

//creo mi entidad, mi modelo de la base de datos y mi base para las demas entidades que sean una persona
entity person : cuid, managed {
    name              : String;
    lastName          : String;
    age               : Integer;
    email             : String;
    genre             : Association to genre;
    cellphone         : String;
    principal_address : Address;
//workGroup         : Association to workGroup; //test para el caso de Association #3

}

//@cds.autoexpose
entity client : person {
    rfc : String @mandatory;
}

entity project : cuid, managed {
    name        : String;
    description : String default 'No description';
    client      : Association to client;
    progress    : Integer default 0;
    objetive    : Composition of many objetive
                      on objetive.project = $self;
    workGroups  : Association to many workGroup_project
                      on workGroups.project = $self;
    starDate    : DateTime; //poner fecha de inicio y fecha de fin
    endDate     : DateTime;
//poner fecha de inicio y fecha de fin
}


entity workGroup_employee : cuid, managed {
    workGroup : Association to workGroup;
    employee  : Association to employee;
}

entity workGroup_project : cuid, managed {
    workGroup : Association to workGroup;
    project   : Association to project;
//task      : Association to task;
}


entity employee : person {
    socialSecurityNumber : String;
    position             : Association to position;
    rank                 : Association to rank;
    salary               : Integer;
    status               : Association to status;
    workGroups           : Association to many workGroup_employee
                               on workGroups.employee = $self; //test para el caso de Association #3
}

//despues

entity task : cuid, managed {
    name        : String                   @mandatory;
    description : String default 'No description';
    status      : Boolean default false;
    objetive    : Association to objetive  @mandatory;
    workGroup   : Association to workGroup @mandatory;
}

entity objetive : cuid, managed {
    name        : String;
    description : String;
    status      : Boolean default false;
    project     : Association to project @mandatory;
    progress    : Integer default 0;
    task        : Association to many task
                      on task.objetive = $self;
}

entity workGroup : cuid, managed {
    name        : String default 'test';
    description : String default 'test2';
    groupLeader : Association to employee;
    project     : Composition of many workGroup_project
                      on project.workGroup = $self;
    employee    : Composition of many workGroup_employee
                      on employee.workGroup = $self;

}
