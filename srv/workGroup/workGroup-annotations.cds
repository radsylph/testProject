using {testService as call} from '../services';
using from '../employee/employee-annotations';

annotate call.workGroup with {
    name         @title: 'Nombre del Grupo';
    description  @title: 'Descripción del Grupo';
    groupLeader  @title: 'Líder del Grupo'  @Common.ValueListWithFixedValues: true;
    project      @title: 'Proyectos'        @Common.ValueListWithFixedValues: true;
    ID           @UI.Hidden;
}

annotate call.workGroup with  @odata.draft.enabled  @(UI: {
    HeaderInfo             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Grupo de Trabajo',
        TypeNamePlural: 'Grupos de Trabajo',
        Title         : {
            $Type: 'UI.DataField',
            Value: name
        }
    },
    SelectionFields        : [name],
    FieldGroup #GeneralInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: description
            },
            {
                $Type: 'UI.DataField',
                Value: groupLeader_ID
            }
        ]
    },
    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: description
        },
        {
            $Type: 'UI.DataField',
            Value: groupLeader_ID
        }
    ],

    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GeneralInfo',
            Label : 'Información General',
            ID    : 'GeneralInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'project/@UI.LineItem#intermediate2',
            Label : 'Proyectos',
            ID    : 'ProjectsFacet'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'employee/@UI.LineItem#intermediate',
            Label : 'Employees',
            ID    : 'EmployeeFacet'
        }
    ]
});

annotate call.workGroup with {
    groupLeader @(Common: {
        Text           : groupLeader.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'employee',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: groupLeader_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
    })
}

annotate call.workGroup_project with {
    project @(Common: {
        Text                    : project.name,
        TextArrangement         : #TextOnly,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            Label         : 'Projects',
            CollectionPath: 'project',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: project_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
        ValueListWithFixedValues: false
    })
}

annotate call.workGroup_project with @(
    Common.SideEffects: {
        $Type           : 'Common.SideEffectsType',
        SourceProperties: [workGroup_ID],
        TargetProperties: ['project_ID']
    },
    UI                : {LineItem #intermediate2: [
        {
            $Type: 'UI.DataField',
            Value: project_ID,
            Label: 'Project'
        },
        {
            $Type: 'UI.DataField',
            Value: workGroup_ID,
            Label: 'WorkGroup'
        }
    ]}
);

annotate call.workGroup_employee with {
    employee @(Common: {
        Text                    : employee.name,
        TextArrangement         : #TextOnly,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            Label         : 'Employees',
            CollectionPath: 'employee',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: employee_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        },
        ValueListWithFixedValues: false,
    })
}

annotate call.workGroup_employee with @(
    Common.SideEffects: {
        $Type           : 'Common.SideEffectsType',
        SourceProperties: [workGroup_ID],
        TargetProperties: ['employee_ID']
    },
    UI                : {LineItem #intermediate: [
        {
            $Type: 'UI.DataField',
            Value: employee_ID,
            Label: 'Employee'
        },
        {
            $Type: 'UI.DataField',
            Value: workGroup_ID,
            Label: 'WorkGroup'
        }
    ], }
);
