using {overViewService as call} from '../services';

annotate call.salesOrder with  @odata.draft.enabled  @(UI: {
    SelectionFields        : [
        localCurrency,
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy,
    ],
    SelectionVariant       : {
        $Type        : 'UI.SelectionVariantType',
        SelectOptions: [{
            $Type       : 'UI.SelectOptionType',
            PropertyName: localCurrency,
        }],
    },

    LineItem               : [
        {
            $Type: 'UI.DataField',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Value: revenueInLocalCurrency,
        },
        {
            $Type: 'UI.DataField',
            Value: localCurrency,
        },
        {
            $Type: 'UI.DataField',
            Value: createdAt,
        },
        {
            $Type: 'UI.DataField',
            Value: createdBy,
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedAt,
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedBy,
        },
    ],

    FieldGroup #generalInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Value: revenueInLocalCurrency,
            },
            {
                $Type: 'UI.DataField',
                Value: localCurrency,
            },
        ]
    },

    Facets                 : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#generalInfo'
    }],


});

annotate call.salesOrder with {
    modifiedAt @UI.Hidden;
    modifiedBy @UI.Hidden;
    createdAt  @UI.Hidden;
    createdBy  @UI.Hidden;
};


//Donut Chart
annotate call.salesPerSupplier with @(UI: {

    Chart #donutOverview                   : {
        $Type              : 'UI.ChartDefinitionType',
        ChartType          : #Donut,
        Description        : 'Donut Chart',
        Measures           : [grossAmountInCompanyCurrency],
        MeasureAttributes  : [{
            $Type    : 'UI.ChartMeasureAttributeType',
            Measure  : grossAmountInCompanyCurrency,
            Role     : #Axis1,
            DataPoint: '@UI.DataPoint#GrossAmountInCompanyCurrency'
        }],
        Dimensions         : [supplier],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: supplier,
            Role     : #Category
        }]
    },
    PresentationVariant #donutPreVarOV     : {
        $Type            : 'UI.PresentationVariantType',
        Visualizations   : ['@UI.Chart#donutOverview'],
        MaxItems         : 3,
        IncludeGrandTotal: true,
        SortOrder        : [{
            $Type     : 'Common.SortOrderType',
            Descending: true,
            Property  : grossAmountInCompanyCurrency
        }]
    },
    DataPoint #GrossAmountInCompanyCurrency: {
        $Type                 : 'UI.DataPointType',
        Value                 : grossAmountInCompanyCurrency,
        Title                 : 'Revenue',
        CriticalityCalculation: {
            $Type                  : 'UI.CriticalityCalculationType',
            ImprovementDirection   : #Maximize,
            DeviationRangeHighValue: 1000000,
            DeviationRangeLowValue : 3000000
        },
        TrendCalculation      : {
            $Type               : 'UI.TrendCalculationType',
            ReferenceValue      : 1000,
            UpDifference        : 10,
            StrongUpDifference  : 100,
            DownDifference      : -10,
            StrongDownDifference: -100
        },
    },
    Identification #testOverview           : [
        {
            $Type: 'UI.DataField',
            Value: grossAmountInCompanyCurrency
        },
        {
            $Type: 'UI.DataField',
            Value: supplierName
        }
    ]
});


annotate call.salesHistory with {
    modifiedAt           @UI.Hidden;
    modifiedBy           @UI.Hidden;
    createdAt            @UI.Hidden;
    createdBy            @UI.Hidden;
    companyCurrency      @title: 'Currency'  @Measures.ISOCurrency: 'Currency';
    companyCurrency_Text @title: '';
    creationMonthAsDate  @title: 'Creation Date';
    creationMonth        @title: 'Month';
    creationMonth_Text   @title: 'Month'     @Common.QuickInfo    : 'Month Long text';
    referenceAmount      @title: 'Amount';
};

//Line Chart
annotate call.salesHistory with @(
    UI.Chart #Line                            : {
        $Type              : 'UI.ChartDefinitionType',
        ChartType          : #Line,
        Description        : 'Line Chart',
        Measures           : [grossAmountInCompanyCurrency],
        MeasureAttributes  : [{
            $Type    : 'UI.ChartMeasureAttributeType',
            Measure  : grossAmountInCompanyCurrency,
            Role     : #Axis1,
            DataPoint: '@UI.DataPoint#GrossAmountInCompanyCurrency'
        }],
        Dimensions         : [creationMonth],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: creationMonth,
            Role     : #Category
        }]
    },
    UI.PresentationVariant #Line              : {
        $Type            : 'UI.PresentationVariantType',
        Visualizations   : ['@UI.Chart#Line'],
        MaxItems         : 3,
        IncludeGrandTotal: true,
        SortOrder        : [{
            $Type     : 'Common.SortOrderType',
            Descending: true,
            Property  : creationMonthAsDate
        }]
    },
    UI.DataPoint #GrossAmountInCompanyCurrency: {
        $Type                 : 'UI.DataPointType',
        Value                 : grossAmountInCompanyCurrency,
        Title                 : 'Revenue',
        CriticalityCalculation: {
            $Type                  : 'UI.CriticalityCalculationType',
            ImprovementDirection   : #Maximize,
            DeviationRangeHighValue: 1000000,
            DeviationRangeLowValue : 3000000
        },
        TrendCalculation      : {
            $Type               : 'UI.TrendCalculationType',
            ReferenceValue      : referenceAmount,
            UpDifference        : 10,
            StrongUpDifference  : 100,
            DownDifference      : -10,
            StrongDownDifference: -100
        }
    }
);
