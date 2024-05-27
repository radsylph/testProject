using {testService as call} from '../../services';
using from '../workGroup-annotations';
using from '../../project/project-annotations';

annotate call.workGroup_project with {
    workGroup  @title: 'Grupo de trabajo'  @Common.ValueListWithFixedValues: true;
    project    @title: 'Proyecto'          @Common.ValueListWithFixedValues: true;
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
        },
    })
}

annotate call.workGroup_project with {
    project @(Common: {
        Text           : project.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'project',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'project_ID',
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

annotate call.workGroup_project with  @odata.draft.enabled  @(UI: {
    HeaderInfo               : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Administración de proyectos por grupo de trabajo',
        TypeNamePlural: 'Administración de proyectos por grupo de trabajo',
        Title         : {
            $Type: 'UI.DataField',
            Value: workGroup_ID
        }
    },


    SelectionFields          : [],
    FieldGroup #GeneralInfo  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: workGroup_ID
            },
            {
                $Type: 'UI.DataField',
                Value: project_ID
            }
        ]

    },
    LineItem #GeneralViewInfo: [
        {

            $Type: 'UI.DataField',
            Value: workGroup_ID
        },
        {
            $Type: 'UI.DataField',
            Value: project_ID
        }
    ],

    Facets                   : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#GeneralInfo ',
            Label : 'Grupo de trabajo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.LineItem#GeneralViewInfo',
            Label : 'Proyecto'
        }
    ]
});
