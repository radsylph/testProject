using {testService as call} from '../services';
using from '../client/client-annotations';
using from '../employee/employee-annotations';
using from '../workGroup/workGroup-annotations';

annotate call.project with {
    name        @title: '{i18n>project.name}';
    description @title: '{i18n>project.description}';
    client      @title: '{i18n>project.client}'  @Common.ValueListWithFixedValues: true;
    testValue2  @title: 'testValue2';
    testValue3  @title: 'testValue3';
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
    SelectionFields        : [client.name],

    Chart #test2           : {
        Title            : 'test',
        $Type            : 'UI.ChartDefinitionType',
        ChartType        : #Donut,
        ![@UI.Importance]: #High,
        MeasureAttributes: [{
            $Type    : 'UI.ChartMeasureAttributeType',
            DataPoint: '@UI.DataPoint#testDonut',
            Measure  : progress,
        }, ],
        Measures         : [progress],
    },

    Chart #Bullet          : {
        Title            : 'test bullet',
        $Type            : 'UI.ChartDefinitionType',
        ChartType        : #Bullet,
        ![@UI.Importance]: #High,
        MeasureAttributes: [{
            $Type    : 'UI.ChartMeasureAttributeType',
            DataPoint: '@UI.DataPoint#testBullet',
            Measure  : progress,
            Role     : #Axis1,
        }, ],
        Measures         : [progress],
    },

    Chart #Area            : {
        Title            : 'test area',
        $Type            : 'UI.ChartDefinitionType',
        ChartType        : #Area,
        ![@UI.Importance]: #High,
        Dimensions       : [testValue2],
        Measures         : [
            progress,
            testValue3
        ],
        MeasureAttributes: [{
            $Type    : 'UI.ChartMeasureAttributeType',
            DataPoint: '@UI.DataPoint#testArea',
            Measure  : progress,
            Role     : #Axis1,
        }, ],

    },

    DataPoint #testDonut   : {
        $Type        : 'UI.DataPointType',
        Value        : progress,
        TargetValue  : 100,
        Visualization: #Donut
    },

    DataPoint #testBullet  : {
        $Type        : 'UI.DataPointType',
        Title        : 'bulletCharm',
        Value        : progress,
        TargetValue  : 100,
        ForecastValue: 50,
        MinimumValue : 0,
        MaximumValue : 1,
        Visualization: #BulletChart,
    },

    DataPoint #Progress    : {
        $Type        : 'UI.DataPointType',
        Value        : progress,
        TargetValue  : 100,
        Visualization: #Progress
    },

    DataPoint #testArea    : {
        $Type                 : 'UI.DataPointType',
        Value                 : progress,
        TargetValue           : 100,
        CriticalityCalculation: {
            ImprovementDirection   : #Maximize,
            DeviationRangeHighValue: 100,
            DeviationRangeLowValue : 0,
            ToleranceRangeHighValue: 80,
            ToleranceRangeLowValue : 20,
        }

    },

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
                Value: testValue2,
                Label: '{i18n>testValue}'
            },
            {
                $Type: 'UI.DataField',
                Value: testValue3,
                Label: '{i18n>testValue2}'
            },
            {
                $Type                  : 'UI.DataFieldForAnnotation',
                Label                  : '{i18n>project.progress}',
                Target                 : '@UI.DataPoint#Progress',
                ![@Common.FieldControl]: {$edmJson: {$If: [

                    {$Eq: [
                        {$Path: 'HasActiveEntity'},
                        true
                    ]},
                    1,
                    3
                ]}},
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : starDate,
                Label                  : '{i18n>project.startDate}',
                ![@Common.FieldControl]: {$edmJson: {$If: [

                    {$Eq: [
                        {$Path: 'HasActiveEntity'},
                        true
                    ]},
                    1,
                    3
                ]}},
            },
            {
                $Type: 'UI.DataField',
                Value: endDate,
                Label: '{i18n>project.endDate}'
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : status_code,
                Label                  : '{i18n>project.status}',
                ![@Common.FieldControl]: {$edmJson: {$If: [
                    {$Eq: [
                        {$Path: 'status_code'},
                        'COM'
                    ]},
                    1,
                    3
                ]}},
            }
        ]
    },
    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: '{i18n>project.name}'
        },
        // {
        //     $Type: 'UI.DataField',
        //     Value: description,
        //     Label: '{i18n>project.description}'
        // },
        {
            $Type: 'UI.DataField',
            Value: client_ID,
            Label: '{i18n>project.client}'
        },
        // {
        //     $Type: 'UI.DataField',
        //     Value: status_code,
        //     Label: '{i18n>project.status}'
        // },z
        {
            $Type      : 'UI.DataFieldForAnnotation',
            Target     : '@UI.Chart#test2',
            Criticality: progress,
            Label      : '{i18n>project.progress}'
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
                {$Or: [
                    {$Eq: [
                        {$Path: 'HasActiveEntity'},
                        true
                    ]},
                    {$Eq: [
                        {$Path: 'Iscreated'},
                        false
                    ]},
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
        $Type                  : 'UI.DataField',
        Value                  : progress,
        Label                  : '{i18n>objetive.progress}',
        ![@Common.FieldControl]: {$edmJson: {$If: [

            {$Eq: [
                {$Path: 'HasActiveEntity'},
                true
            ]},
            1,
            3
        ]}},

    },
    {
        $Type                  : 'UI.DataField',
        Value                  : status,
        Label                  : '{i18n>objetive.status}',
        ![@Common.FieldControl]: {$edmJson: {$If: [

            {$Eq: [
                {$Path: 'completed'},
                true
            ]},
            1,
            3
        ]}},
    },
// {
//     $Type                  : 'UI.DataField',
//     Value                  : project_ID,
//     Label                  : '{i18n>project}',
// ![@Common.FieldControl]: {$edmJson: {$If: [

//     {$Eq: [
//         {$Path: 'HasActiveEntity'},
//         true
//     ]},
//     1,
//     3
// ]}},
// }
]});
