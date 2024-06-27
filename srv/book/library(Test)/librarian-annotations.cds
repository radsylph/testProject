using {libraryService as call} from '../../services';

annotate call.book with {
    title       @title: '{i18n>book.title}';
    stock       @title: '{i18n>book.stock}';
    category1   @title: '{i18n>book.category1}';
    category2   @title: '{i18n>book.category2}';
    publishedAt @title: '{i18n>book.publishedAt}';
};

annotate call.book with  @odata.draft.enabled  @(UI: {
    HeaderInfo          : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'create book',
        TypeNamePlural: 'create books',
        Title         : {
            $Type: 'UI.DataField',
            Value: 'Adding new books'
        }
    },

    SelectionFields     : [
        title,
        category1,
        category2
    ],

    LineItem            : [
        {
            $Type: 'UI.DataField',
            Value: title,
        //Label: 'Title'
        },
        {
            $Type: 'UI.DataField',
            Value: category1,
        //Label: 'Category1'
        },
        {
            $Type: 'UI.DataField',
            Value: category2,
        //Label: 'Category2'
        },
        {
            $Type: 'UI.DataField',
            Value: stock,
        //Label: 'Stock'
        },
        {
            $Type: 'UI.DataField',
            Value: publishedAt,
        //Label: 'PublishedAt'
        },
    ],

    Chart #category1    : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [category1],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalStock] ],
    },

    PresentationVariant : {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [ ![@UI.Chart#category1] ]
    },

    FieldGroup #bookInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Value: category1,
            },
            {
                $Type: 'UI.DataField',
                Value: category2,
            },
            {
                $Type: 'UI.DataField',
                Value: stock,
            },
            {
                $Type: 'UI.DataField',
                Value: publishedAt,
            }
        ]
    },

    Facets              : [
        {
            $Type        : 'UI.ReferenceFacet',
            Target       : '@UI.LineItem',
            //Label : 'test line Item',
            ID           : 'cd1',
            ![@UI.Hidden]: {$edmJson: {$If: [
                {$Or: [
                    {$Eq: [
                        {$Path: 'HasActiveEntity'},
                        true
                    ]},
                    {$Eq: [
                        {$Path: 'HasActiveEntity'},
                        false
                    ]},
                ]},
                true,
                false
            ]}},

        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#bookInfo',
            //Label : 'fieldGroup',
            ID    : 'cd2'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.PresentationVariant',
            //Label : 'chart',
            ID    : 'cd3'
        }
    ]

});
