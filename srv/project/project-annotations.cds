using {testService as call} from '../services';
using from '../client/client-annotations';
using from '../employee/employee-annotations';

annotate call.project with {
    name        @title: 'Nombre del proyecto';
    description @title: 'Descripción del proyecto';
    client      @title: 'Cliente del proyecto'  @Common.ValueListWithFixedValues: true;
    //workGroups  @title: 'Grupo de trabajo asignado'  @Common.ValueListWithFixedValues: true;
    progress    @title: 'Progreso del proyecto';
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
                    LocalDataProperty: 'client_ID',
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
                    LocalDataProperty: 'workGroup_ID',
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
            //     Value: workGroups_ID,
            //     Label: 'Grupo de trabajo asignado'
            // },
            {
                $Type: 'UI.DataField',
                Value: progress
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
    Facets                 : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#GeneralInfo',
        Label : 'información general',
        ID    : 'GeneralInfo'
    }]
});

// annotate call.objetive with @(UI: {
// })


//terminar esto y hacer la tabla intermedia
