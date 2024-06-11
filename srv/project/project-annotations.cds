using {testService as call} from '../services';
using from '../client/client-annotations';
using from '../employee/employee-annotations';
using from '../workGroup/workGroup-annotations';

annotate call.project with {
    name        @title: '{i18n>project.name}';
    description @title: '{i18n>project.description}';
    client      @title: '{i18n>project.client}'  @Common.ValueListWithFixedValues: true;
    //workGroups  @title: 'Grupo de trabajo asignado'  @Common.ValueListWithFixedValues: true;
    progress    @title: '{i18n>project.progress}';
    status      @title: '{i18n>project.status}'  @Common.ValueListWithFixedValues;
    starDate    @title: '{i18n>project.starDate}';
    endDate     @title: '{i18n>project.endDate}';
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
        TypeName      : '{i18n>project}',
        TypeNamePlural: '{i18n>projects}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>project.label1}'
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
                Value: name,
                Label: '{i18n>project.name}'
            },
            {
                $Type: 'UI.DataField',
                Value: description,
                Label: '{i18n>project.description}'
            },
            {
                $Type: 'UI.DataField',
                Value: client_ID,
                Label: '{i18n>project.client}'
            },
            {
                $Type: 'UI.DataField',
                Value: progress,
                Label: '{i18n>project.progress}',
            // ![@Common.FieldControl]: {$edmJson: {$If: [

            //     {$Eq: [
            //         {$Path: 'HasActiveEntity'},
            //         true
            //     ]},
            //     1,
            //     3
            // ]}},
            },
            {
                $Type: 'UI.DataField',
                Value: starDate,
                Label: '{i18n>project.startDate}'
            },
            {
                $Type: 'UI.DataField',
                Value: endDate,
                Label: '{i18n>project.endDate}'
            },
            {
                $Type: 'UI.DataField',
                Value: status_code,
                Label: '{i18n>project.status}'
            }
        ]
    },
    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: '{i18n>project.name}'
        },
        {
            $Type: 'UI.DataField',
            Value: description,
            Label: '{i18n>project.description}'
        },
        {
            $Type: 'UI.DataField',
            Value: client_ID,
            Label: '{i18n>project.client}'
        },
        // {
        //     $Type: 'UI.DataField',
        //     Value: workGroups_ID
        // },
        {
            $Type: 'UI.DataField',
            Value: progress,
            Label: '{i18n>project.progress}'
        }
    ],
    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GeneralInfo',
            Label : '{i18n>project.label1}',
            ID    : 'GeneralInfo'
        },
        {
            $Type        : 'UI.ReferenceFacet',
            Target       : 'workGroups/@UI.LineItem#intermediate2',
            Label        : '{i18n>project.groups}',
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
            Target: 'objective/@UI.LineItem#objetives',
            Label : '{i18n>project.label4}',
            ID    : 'ObjetiveInfo'
        },
    ]
});


//terminar esto y hacer la tabla intermedia
annotate call.objective with {
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

annotate call.objective with @(UI: {LineItem #objetives: [
    {
        $Type: 'UI.DataField',
        Value: name,
        Label: '{i18n>objetive.name}'

    },
    {
        $Type: 'UI.DataField',
        Value: description,
        Label: '{i18n>objetive.description}'
    },
    {
        $Type: 'UI.DataField',
        Value: progress,
        Label: '{i18n>objetive.progress}'
    },
    {
        $Type: 'UI.DataField',
        Value: status,
        Label: '{i18n>objetive.status}'
    },
// {
//     $Type                  : 'UI.DataField',
//     Value                  : project_ID,
//     Label                  : '{i18n>project}',
//     ![@Common.FieldControl]: {$edmJson: {$If: [

//         {$Eq: [
//             {$Path: 'HasActiveEntity'},
//             true
//         ]},
//         1,
//         3
//     ]}},
// }
]});
