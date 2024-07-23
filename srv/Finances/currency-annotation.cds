using {overViewService as call} from '../services';

annotate call.currency with {
    nam_cur @title: '{i18n>cur_name}';
    des_cur @title: '{i18n>cur_des}';
    sym_cur @title: '{i18n>cur_sym}';
    rat_cur @title: '{i18n>cur_rat}';
}

annotate call.currency with  @odata.draft.enabled  @(UI: {
    HeaderInfo            : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>cur_header1}',
        TypeNamePlural: '{i18n>cur_header2}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>cur_title}'
        }
    },

    SelectionFields       : [sym_cur],

    FieldGroup #CurrencyFG: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: nam_cur
            },
            {
                $Type: 'UI.DataField',
                Value: des_cur
            },
            {
                $Type: 'UI.DataField',
                Value: sym_cur
            },
            {
                $Type: 'UI.DataField',
                Value: rat_cur
            }
        ]
    },

    LineItem              : [
        {
            $Type: 'UI.DataField',
            Value: nam_cur
        },
        {
            $Type: 'UI.DataField',
            Value: des_cur
        },
        {
            $Type: 'UI.DataField',
            Value: sym_cur
        },
        {
            $Type: 'UI.DataField',
            Value: rat_cur
        }
    ],

    Facets                : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#CurrencyFG',
        Label : 'test',
        ID    : 'test'
    }],
});
