using {overViewService as call} from '../services';

annotate call.category with {
    ID      @UI.Hidden;
    nam_cat @title: '{i18n>cat_name}';
    des_cat @title: '{i18n>cat_des}';
}

annotate call.category with  @odata.draft.enabled  @(UI: {
    HeaderInfo            : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>cat_header1}',
        TypeNamePlural: '{i18n>cat_header2}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>cat_title}'
        }
    },

    FieldGroup #CategoryFG: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: nam_cat
            },
            {
                $Type: 'UI.DataField',
                Value: des_cat
            }
        ]
    },

    LineItem              : [
        {
            $Type: 'UI.DataField',
            Value: nam_cat
        },
        {
            $Type: 'UI.DataField',
            Value: des_cat
        }
    ],

    Facets                : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#CategoryFG',
        Label : '{i18n>cat_fac}',
        ID    : 'FieldGroupCategory'
    }],
});
