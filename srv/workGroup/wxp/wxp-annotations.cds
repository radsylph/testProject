using {testService as call} from '../../services';
using from '../../workGroup/workGroup-annotations';
using from '../../project/project-annotations';
using from '../../objective/objective-annotations';

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

annotate call.workGroup_project with @(UI: {
    HeaderInfo     : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Administración de proyectos por grupo de trabajo',
        TypeNamePlural: 'Administración de proyectos por grupos de trabajos',
        Title         : {
            $Type: 'UI.DataField',
            Value: workGroup_ID
        }
    },

    SelectionFields: [workGroup_ID],

    Facets         : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'project/@UI.FieldGroup#GeneralInfo',
            Label : 'Projecto asignado',
            ID    : 'GeneralInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'project/objective/@UI.LineItem#objetives',
            Label : 'Objetivos',
            ID    : 'objetiveList'
        },
    // {
    //     $Type : 'UI.ReferenceFacet',
    //     Target: 'workGroup/@UI.LineItem#testTask',
    //     Label : 'Tareas asignadas',
    //     ID    : 'testTask'
    // }
    ]
});


// annotate call.workGroup with {
//     task @(Common: {
//         Text           : task.name,
//         TextArrangement: #TextOnly,
//         ValueList      : {
//             $Type         : 'Common.ValueListType',
//             CollectionPath: 'task',
//             Parameters    : [
//                 {
//                     $Type            : 'Common.ValueListParameterInOut',
//                     LocalDataProperty: task_ID,
//                     ValueListProperty: 'ID'
//                 },
//                 {
//                     $Type            : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty: 'name'
//                 }
//             ]
//         },
//     })
// }

// annotate call.workGroup with @(UI: {LineItem #testTask: [{
//     $Type: 'UI.DataField',
//     Value: task_ID,
//     Label: 'Nombre'

// }]});
