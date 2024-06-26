using {testService as call} from '../services';
using from '../client/client-annotations';
using from '../employee/employee-annotations';
using from '../workGroup/workGroup-annotations';

annotate call.project with {
    name        @title: 'Nombre del proyecto';
    description @title: 'Descripción del proyecto';
    client      @title: 'Cliente del proyecto'  @Common.ValueListWithFixedValues: true;
    //workGroups  @title: 'Grupo de trabajo asignado'  @Common.ValueListWithFixedValues: true;
    progress    @title: 'Progreso del proyecto';
    starDate    @title: 'Fecha de inicio';
    endDate     @title: 'Fecha de finalización';
}

annotate call.project with {
    client @(Common: {
        Text           : client.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'client',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: client_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    })
}

annotate call.workGroup_project with {
    workGroup @(Common: {
        Text           : workGroup.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'workGroup',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: workGroup_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    })
}

annotate call.project with  @odata.draft.enabled  @(UI: {
    HeaderInfo             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Proyecto',
        TypeNamePlural: 'Proyectos',
        Title         : {
            $Type: 'UI.DataField',
            Value: 'prueba header title proyecto'
        }
    },
    SelectionFields        : [client.name,
                                           //project_leader.name
                                           // workGroups.name
                             ],
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
                Value: client_ID,
                Label: 'Cliente'
            },
            // {
            //     $Type: 'UI.DataField',
            //     Value: progress
            // },
            {
                $Type: 'UI.DataField',
                Value: starDate
            },
            {
                $Type: 'UI.DataField',
                Value: endDate
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
            Value: client_ID
        },
        // {
        //     $Type: 'UI.DataField',
        //     Value: workGroups_ID
        // },
        {
            $Type: 'UI.DataField',
            Value: progress
        }
    ],
    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GeneralInfo',
            Label : 'información general',
            ID    : 'GeneralInfo'
        },
        {
            $Type        : 'UI.ReferenceFacet',
            Target       : 'workGroups/@UI.LineItem#intermediate2',
            Label        : 'Grupos de trabajo asignados',
            ID           : 'WorkGroupInfo',
            ![@UI.Hidden]: {$edmJson: {$If: [

                {$Eq: [
                    {$Path: 'HasActiveEntity'},
                    true
                ]},
                true,
                false
            ]}},
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'objetive/@UI.LineItem#objetives',
            Label : 'Objetivos',
            ID    : 'ObjetiveInfo'
        },
    ]
});


//terminar esto y hacer la tabla intermedia
annotate call.objetive with {
    project @(Common: {
        Text           : project.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
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
    })
};

annotate call.objetive with @(UI: {LineItem #objetives: [
    {
        $Type: 'UI.DataField',
        Value: name
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
    {
        $Type                  : 'UI.DataField',
        Value                  : project_ID,
        Label                  : 'Proyecto',
        ![@Common.FieldControl]: {$edmJson: {$If: [

            {$Eq: [
                {$Path: 'HasActiveEntity'},
                true
            ]},
            1,
            3
        ]}},
    }
]});
