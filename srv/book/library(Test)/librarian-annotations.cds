using {libraryService as call} from '../../services';


annotate call.book with {
    title       @title: '{i18n>book.title}';
    stock       @title: '{i18n>book.stock}';
    category1   @title: '{i18n>book.category1}';
    category2   @title: '{i18n>book.category2}';
    publishedAt @title: '{i18n>book.publishedAt}';
};

annotate call.book with  @odata.draft.enabled  @( // Smart Chart

    SelectionFields                : [
        title,
        category1,
        category2,
        publishedAt
    ],

    UI.Chart #primary              : {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Stock',
        ChartType          : #Column,
        Dimensions         : [
            category1,
            category2
        ],
        DimensionAttributes: [
            {
                $Type    : 'UI.ChartDimensionAttributeType',
                Dimension: category1,
                Role     : #Category
            },
            {
                $Type    : 'UI.ChartDimensionAttributeType',
                Dimension: category2,
                Role     : #Category2
            }
        ],

        DynamicMeasures    : [ ![@Analytics.AggregatedProperty#totalStock] ],

        MeasureAttributes  : [{
            $Type         : 'UI.ChartMeasureAttributeType',
            DynamicMeasure: ![@Analytics.AggregatedProperty#totalStock],
            Role          : #Axis1
        }]
    },
    UI.PresentationVariant         : {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#primary']
    },

    UI.SelectionVariant            : {
        Parameters   : [{
            $Type        : 'UI.Parameter',
            PropertyName : 'category1',
            PropertyValue: category1
        },
        // {
        //     $Type        : 'UI.Parameter',
        //     PropertyName : category2,
        //     PropertyValue: 'test'
        // }
        ],
        SelectOptions: [
            {
                $Type       : 'UI.SelectOptionType',
                PropertyName: category1,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #E,
                    Option: #EQ,
                    Low   : 'test'
                }]
            },
            {
                $Type       : 'UI.SelectOptionType',
                PropertyName: category2,
                Ranges      : [{
                    $Type : 'UI.SelectionRangeType',
                    Sign  : #E,
                    Option: #EQ,
                    Low   : 'test'
                }]
            }
        ]
    },

    UI.SelectionPresentationVariant: {
        Text               : 'test SelectionPresentationVariant',
        SelectionVariant   : ![@UI.SelectionVariant],
        PresentationVariant: ![@UI.PresentationVariant]
    }

);

annotate call.book with @( //visual filters for category 1
    UI.Chart #secondary                  : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [category1],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalStock] ]
    },

    UI.PresentationVariant #prevCategory1: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#secondary']
    }
) {
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
}

annotate call.book with @( //visual filters for category 2
    UI.Chart #tertiary                   : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [category2],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalStock], ]
    },

    UI.PresentationVariant #prevCategory2: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#tertiary']
    }
) {
    category2 @Common.ValueList #vlCategory2: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'book',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'category2',
            LocalDataProperty: category2
        }],
        PresentationVariantQualifier: 'prevCategory2'
    }
}

annotate call.book with @(
    UI.Chart #quaternary                   : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Line,
        Dimensions     : [publishedAt],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalStock] ]
    },

    UI.PresentationVariant #prevPublishedAt: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#quaternary']
    }
) {
    publishedAt @Common.ValueList #vlPublishedAt: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'book',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'publishedAt',
            LocalDataProperty: publishedAt
        }],
        PresentationVariantQualifier: 'prevPublishedAt'
    }
}

annotate call.book with @( //KPI thign IDK
    Aggregation.CustomAggregate #stock: 'Edm.Decimal',
    Common.SemanticKey                : [ID],
) {
    stock @Aggregation.default: #SUM;
}

annotate call.book with @( //KPI
    // UI.DataPoint #KPI1    : {
    //     $Type      : 'UI.DataPointType',
    //     Title      : 'TKP',
    //     Description: 'test description value',
    //     Value      : stock
    // },

    // UI.SelectionVariant   : {
    //     Parameters   : [{
    //         $Type        : 'UI.Parameter',
    //         PropertyName : stock,
    //         PropertyValue: 'STC'
    //     }],
    //     SelectOptions: [{
    //         $Type       : 'UI.SelectOptionType',
    //         PropertyName: category1,
    //         Ranges      : [{
    //             $Type : 'UI.SelectionRangeType',
    //             Sign  : #E,
    //             Option: #EQ,
    //             Low   : 'test'
    //         }]
    //     }]
    // },

    // UI.PresentationVariant: {Visualizations: ['@UI.DataPoint#KPI1']},

    // UI.Chart #testKPI4    : {
    //     ChartType          : #Line,
    //     Measures           : [stock],
    //     Dimensions         : [publishedAt],
    //     MeasureAttributes  : [{
    //         Measure: stock,
    //         Role   : #Axis1
    //     }],
    //     DimensionAttributes: [{
    //         Dimension: publishedAt,
    //         Role     : #Category
    //     }]
    // },

    // UI.KPI #myTestKPI     : {
    //     $Type           : 'UI.KPIType',
    //     DataPoint       : ![@UI.DataPoint#KPI1],
    //     SelectionVariant: ![@UI.SelectionVariant],
    //     ID              : 'Testing KPI',
    //     Detail          : {DefaultPresentationVariant: ![@UI.PresentationVariant]}
    // }

    UI.KPI #myKPI1: {
        DataPoint       : {
            Value      : stock,
            Title      : 'TEST',
            Description: '{i18n>Numero de Examenes}',
        // CriticalityCalculation: {
        //     ImprovementDirection   : #Maximize,
        //     AcceptanceRangeLowValue: 1000000000, //valor minimo Aceptable (verde)
        //     ToleranceRangeLowValue : 28000000, //valor minimo tolerable (naranja)
        //     DeviationRangeLowValue : 5000000 //valor minimo critico (rojo)
        // }
        },
        Detail          : {DefaultPresentationVariant: {Visualizations: ['@UI.Chart#kpi1'], }, },
        SelectionVariant: {SelectOptions: [{
            PropertyName: stock,
            Ranges      : [{
                Sign  : #E,
                Option: #EQ,
                Low   : 0,
            }, ],
        }], }
    },
    UI.Chart #kpi1: {
        ChartType          : #Line,
        Measures           : [stock],
        Dimensions         : [publishedAt],
        MeasureAttributes  : [{
            Measure: stock,
            Role   : #Axis1
        }],
        DimensionAttributes: [{
            Dimension: publishedAt,
            Role     : #Category
        }]
    },

);

annotate call.book with @(UI: { //LineItem
    SelectionFields        : [
        category1,
        category2,
        publishedAt
    ],
    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: ID,
        },
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
        },
    ],

    FieldGroup #generalInfo: {
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
            },
        ]
    },

    Facets                 : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#generalInfo',
    }]
});
