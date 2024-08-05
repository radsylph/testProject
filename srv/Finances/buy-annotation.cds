using {overViewService as call} from '../services';

annotate call.buy_receipt with {
    ID          @UI.Hidden;
    dat_receipt @title: '{i18n>rec_date}';
    tot_receipt @title: '{i18n>rec_tot}';
    rec_type    @title: '{i18n>rec_type}'  @Common.ValueListWithFixedValues: true;
    movements   @title: '{i18n>}';
}

//movimientos

annotate call.buy_movement with {
    mat_id @(Common: {
        Text                    : mat_id.nam_mat,
        TextArrangement         : #TextOnly,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'material',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: mat_id_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'nam_mat'
                }
            ]
        },
        ValueListWithFixedValues: true,
    });
}

annotate call.buy_movement with {
    cur_id @(Common: {
        Text                    : cur_id.nam_cur,
        TextArrangement         : #TextOnly,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'currency',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: cur_id_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'nam_cur'
                }
            ]
        },
        ValueListWithFixedValues: true,
    });
}

annotate call.buy_movement with @(UI: {LineItem #BuyReceiptMovements: [
    {
        $Type: 'UI.DataField',
        Value: rec_id_ID,
        Label: '{i18n>rec_mov}'
    },
    {
        $Type: 'UI.DataField',
        Value: mat_id_ID,
        Label: '{i18n>mov_ite}'
    },
    {
        $Type: 'UI.DataField',
        Value: cur_id_ID,
        Label: '{i18n>mov_cur}'
    },
    {
        $Type: 'UI.DataField',
        Value: qua_movement,
        Label: '{i18n>mov_qua}'
    }
], });

annotate call.buy_receipt with  @odata.draft.enabled  @(UI: {
    HeaderInfo              : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>rec_header1}',
        TypeNamePlural: '{i18n>rec_header2}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>rec_buy}'
        }
    },

    FieldGroup #BuyReceiptFG: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: dat_receipt
            },
            {
                $Type: 'UI.DataField',
                Value: rec_type_code
            }
        ]
    },

    LineItem                : [
        {
            $Type: 'UI.DataField',
            Value: dat_receipt
        },
        {
            $Type: 'UI.DataField',
            Value: tot_receipt
        },
        {
            $Type: 'UI.DataField',
            Value: rec_type_code
        }
    ],

    Facets                  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#BuyReceiptFG',
            Label : '{i18n>rec_fac}',
            ID    : 'BuyReceiptFGF',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'movements/@UI.LineItem#BuyReceiptMovements',
            Label : '{i18n>mov_fac}',
            ID    : 'BuyMovementsFacet'
        }
    ]
});

//overview cards

//Line
