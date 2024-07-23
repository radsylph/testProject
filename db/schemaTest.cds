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

entity employee_status : CodeList {
    key code  : String enum {
            Active    = 'ACT';
            Inactive  = 'INA';
            Suspended = 'SUS';
            Deleted   = 'DEL';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

entity project_status : CodeList {
    key code  : String enum {
            Incomplete = 'INC';
            Complete   = 'COM';
            Cancelled  = 'CAN';
            Ongoing    = 'ONG';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

//creo mi entidad, mi modelo de la base de datos y mi base para las demas entidades que sean una persona


//@cds.autoexpose
entity client : person {
    rfc : String @mandatory;
}

entity project : cuid, managed {
    name        : String;
    description : String default 'No description';
    client      : Association to client;
    progress    : Integer default 0;
    testValue2  : Integer default 0;
    testValue3  : Integer default 0;
    objective   : Composition of many objective
                      on objective.project = $self;
    workGroups  : Association to many workGroup_project
                      on workGroups.project = $self;
    starDate    : DateTime;
    status      : Association to project_status;
    endDate     : DateTime;
    Iscreated   : Boolean default false;
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

@assert.unique: {
    SCN  : [socialSecurityNumber, ],
    email: [email, ],
}
entity employee : person {
    socialSecurityNumber : String @assert.unique;
    position             : Association to position;
    rank                 : Association to rank;
    salary               : Integer;
    status               : Association to employee_status;
    workGroups           : Association to many workGroup_employee
                               on workGroups.employee = $self; //test para el caso de Association #3
}
//despues

entity task : cuid, managed {
    name        : String                   @mandatory;
    description : String default 'No description';
    status      : Boolean default false;
    objective   : Association to objective @mandatory;
    workGroup   : Association to workGroup @mandatory;
}

entity objective : cuid, managed {
    name        : String;
    description : String;
    status      : Boolean default false;
    project     : Association to project @mandatory;
    progress    : Integer default 0;
    task        : Association to many task
                      on task.objective = $self;
    completed   : Boolean default false;
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

entity book : cuid, managed { //se crea la entidad
    title       : String  @title: 'Title';
    stock       : Integer @title: 'Stock';
    category1   : String  @title: 'Category1';
    category2   : String  @title: 'Category2';
    publishedAt : Date    @title: 'Published At';
}

entity salesOrderType : cuid, managed {
    customerCompanyName    : String @title: 'Company Name';
    revenueInLocalCurrency : String @title: 'Gross ammount';
    localCurrency          : String @title: 'Currency code';
    numberOfItems          : String @title: 'Number of items';
}

entity SalesPerSupplierType : cuid, managed {
    supplier                      : String(10)     @title       : 'Business Partner ID';
    supplierName                  : String(80)     @title       : 'Supplier';
    grossAmountInCompanyCurrency  : Decimal(16, 3) @title       : 'Revenue';
    netUnitPriceInCompanyCurrency : Decimal(16, 3) @title       : 'Average Item Price';
    quantity                      : Decimal(13, 3) @title       : 'Number of Sold Items';
    companyCurrency               : String(5)      @Common.Label: 'ISO Currency Code'    @Common.IsUpperCase: true;
    quantityUnit                  : String(3)      @Common.Label: 'Unit of Measure';
    companyCurrencyShortName      : String(15)     @Common.Label: 'Short text';
    quantityUnitName              : String(10)     @Common.Label: 'Measuremt unit text'  @Common.QuickInfo  : 'Unit of Measurement Text (Maximum 10 Characters)'
}

entity SalesHistoryType : managed, cuid {
    creationMonthAsDate          : DateTime;
    creationMonth                : String(2);
    creationMonth_Text           : String(10);
    grossAmountInCompanyCurrency : Decimal(16, 3) @title       : 'Revenue';
    companyCurrency              : String(5);
    companyCurrency_Text         : String(40)     @Common.Label: 'Long text';
    referenceAmount              : Integer;
}


entity material : cuid, managed {
    nam_mat  : String(100);
    des_mat  : String(150);
    cat_mat  : Association to category;
    pri_mate : Integer;
}

entity currency : cuid, managed {
    nam_cur : String(100);
    des_cur : String(150);
    sym_cur : String(10);
    rat_cur : Decimal(10, 2);
}

entity receipt : cuid, managed {
    dat_receipt : DateTime;
    movements   : Composition of many movement
                      on movements.rec_id = $self;
}

entity movement : cuid, managed {
    rec_id       : Association to receipt;
    mat_id       : Association to material;
    cur_id       : Association to currency;
    qua_movement : Integer;
}

entity receipt_type : CodeList {
    key code  : String enum {
            Buy  = 'BUY';
            Sell = 'SELL';
        };
        name  : String @UI.Hidden;
        descr : String @UI.Hidden;
}

entity buy_receipt : cuid, managed {
    dat_receipt : DateTime;
    tot_receipt : Decimal(10, 2);
    rec_type    : Association to receipt_type;
    movements   : Composition of many buy_movement
                      on movements.rec_id = $self;
}

entity buy_movement : cuid, managed {
    rec_id       : Association to buy_receipt;
    mat_id       : Association to material;
    cur_id       : Association to currency;
    qua_movement : Integer;
}

entity sell_receipt : cuid, managed {
    dat_receipt : DateTime;
    tot_receipt : Decimal(10, 2);
    movements   : Composition of many sell_movement
                      on movements.rec_id = $self;
}

entity sell_movement : cuid, managed {
    rec_id       : Association to sell_receipt;
    mat_id       : Association to material;
    cur_id       : Association to currency;
    qua_movement : Integer;
}

entity category : cuid, managed {
    nam_cat : String(100);
    des_cat : String(150);
}
