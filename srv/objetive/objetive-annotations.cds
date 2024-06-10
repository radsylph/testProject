// using {testService as call} from '../services';


// annotate call.objetive with {
//     project @(Common: {
//         Text           : project.name,
//         TextArrangement: #TextOnly,
//         ValueList      : {
//             $Type         : 'Common.ValueListType',
//             CollectionPath: 'project',
//             Parameters    : [
//                 {
//                     $Type            : 'Common.ValueListParameterInOut',
//                     LocalDataProperty: project_ID,
//                     ValueListProperty: 'ID'
//                 },
//                 {
//                     $Type            : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty: 'name'
//                 }
//             ]

//         },
//     })
// };

// // annotate call.objetive with  @odata.draft.enabled  @(UI: {
// //     HeaderInfo              : {
// //         $Type         : 'UI.HeaderInfoType',
// //         TypeName      : 'Objetivo',
// //         TypeNamePlural: 'Objetivos',
// //         Title         : {
// //             $Type: 'UI.DataField',
// //             Value: 'test objetivo'
// //         }
// //     },
// //     SelectionFields         : [

// //     ],

// //     FieldGroup #TestObjetive: {
// //         $Type: 'UI.FieldGroupType',
// //         Data : [

// //         ]
// //     },

// // });

// // annotate call.objetive with @(UI: {LineItem #objetives: [
// //     {
// //         $Type: 'UI.DataField',
// //         Value: name
// //     },
// //     {
// //         $Type: 'UI.DataField',
// //         Value: description
// //     },
// //     {
// //         $Type: 'UI.DataField',
// //         Value: project_ID,
// //         Label: 'Proyecto',
// //     // ![@Common.FieldControl]: {$edmJson: {$If: [

// //     //     {$Eq: [
// //     //         {$Path: 'HasActiveEntity'},
// //     //         true
// //     //     ]},
// //     //     1,
// //     //     3
// //     // ]}},
// //     }
// // ]});
