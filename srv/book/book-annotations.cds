using {libraryService as call} from '../services';

annotate call.book with {
    title       @title: '{i18n>book.title}';
    stock       @title: '{i18n>book.stock}';
    category1   @title: '{i18n>book.category1}';
    category2   @title: '{i18n>book.category2}';
    publishedAt @title: '{i18n>book.publishedAt}';
}

annotate call.book with  @odata.draft.enabled  @(UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>book}',
        TypeNamePlural: '{i18n>books}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>book.title}'
        }
    },
    SelectionFields    : [
        category1,
        category2,
        publishedAt
    ],

    Chart #category1   : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [category1],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalStock] ],
    },

    PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [ ![@UI.Chart#category1] ]

    },

    LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: category1
        },
    ],

});

annotate call.book with {
    category1 @Common.ValueList #vlCategory1: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'book',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'category1',
            LocalDataProperty: category1
        }],
        PresentationVariantQualifier: 'prevCategory1'
    }
};
// {
//     category1 @Common.ValueList #vlCategory1: {
//         $Type                       : 'Common.ValueListType',
//         CollectionPath              : 'book',
//         Parameters                  : [{
//             $Type            : 'Common.ValueListParameterInOut',
//             ValueListProperty: 'category1',
//             LocalDataProperty: category1
//         }],
//         PresentationVariantQualifier: 'prevCategory1'
//     }
// };
