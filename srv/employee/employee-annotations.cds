using {testService as call} from '../services';

annotate call.employee with {
    name                 @title: '{i18n>name}';
    lastName             @title: '{i18n>lastname}';
    age                  @title: '{i18n>age}';
    email                @title: '{i18n>email}';
    genre                @title: '{i18n>genre}';
    cellphone            @title: '{i18n>cellphone}';
    principal_address;
    socialSecurityNumber @title: '{i18n>SCN}';
    position             @title: '{i18n>position}'  @Common.ValueListWithFixedValues: true;
    rank                 @title: '{i18n>rank}'      @Common.ValueListWithFixedValues: true;
    salary               @title: '{i18n>salary}';
    status               @title: '{i18n>status}';
    ID                   @UI.Hidden;

}

annotate call.employee with {
    status @Common.ValueListWithFixedValues: true;
    genre  @Common.ValueListWithFixedValues: true;
}

annotate call.employee with  @odata.draft.enabled  @(UI: {
    HeaderInfo              : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>employee}',
        TypeNamePlural: '{i18n>employees}',
        Title         : {
            $Type: 'UI.DataField',
            Value: name
        }
    },

    SelectionFields         : [
        status_code,
        rank_code,
        position_code
    ],

    FieldGroup #PersonalInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: lastName
            },
            {
                $Type: 'UI.DataField',
                Value: age
            },
            {
                $Type: 'UI.DataField',
                Value: email
            },
            {
                $Type: 'UI.DataField',
                Value: genre_code
            },
            {
                $Type: 'UI.DataField',
                Value: cellphone
            },
            {
                $Type: 'UI.DataField',
                Value: socialSecurityNumber
            }
        ]
    },

    FieldGroup #AddressInfo : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: principal_address_street
            },
            {
                $Type: 'UI.DataField',
                Value: principal_address_city
            },
            {
                $Type: 'UI.DataField',
                Value: principal_address_state
            },
            {
                $Type: 'UI.DataField',
                Value: principal_address_zip
            },
            {
                $Type: 'UI.DataField',
                Value: position_code
            },
            {
                $Type: 'UI.DataField',
                Value: rank_code
            },
            {
                $Type: 'UI.DataField',
                Value: salary
            },
            {
                $Type: 'UI.DataField',
                Value: status_code
            }
        ]
    },

    LineItem                : [
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: lastName
        },
        {
            $Type: 'UI.DataField',
            Value: age
        },
        {
            $Type: 'UI.DataField',
            Value: email
        },
        {
            $Type: 'UI.DataField',
            Value: genre_code
        },
        {
            $Type: 'UI.DataField',
            Value: cellphone
        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_street,
        // Label: 'C'
        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_city,

        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_state,

        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_zip,

        },
        {
            $Type: 'UI.DataField',
            Value: socialSecurityNumber
        },
        {
            $Type: 'UI.DataField',
            Value: position_code
        },
        {
            $Type: 'UI.DataField',
            Value: rank_code
        },
        {
            $Type: 'UI.DataField',
            Value: salary
        },
        {
            $Type: 'UI.DataField',
            Value: status_code
        }
    ],

    Facets                  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#PersonalInfo',
            Label : '{i18n>employee.label1}',
            ID    : 'PersonalInfoId'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#AddressInfo',
            Label : '{i18n>employee.label2}',
            ID    : 'AddressInfoId'
        },
        {
            $Type        : 'UI.ReferenceFacet',
            Target       : 'workGroups/@UI.LineItem#tablaIntermedia',
            Label        : '{i18n>WxE.label1}',
            ID           : 'LineItemId',
            ![@UI.Hidden]: {$edmJson: {$If: [
                {$Eq: [
                    {$Path: 'HasActiveEntity'},
                    true
                ]},
                true,
                false
            ]}}
        }
    ]
});

annotate call.workGroup_employee with @(UI: {LineItem #tablaIntermedia: [{
    $Type: 'UI.DataField',
    Value: workGroup.name,
    //Criticality: #Information,
    Label: 'Grupo de trabajo'
}, ]});

annotate call.workGroup_employee with {
    workGroup @(Common: {
        Text                    : workGroup.name,
        TextArrangement         : #TextOnly,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            Label         : 'Grupos de trabajos',
            CollectionPath: 'workGroup',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: workGroup_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                }
            ]
        },
        ValueListWithFixedValues: false,
    })
}
