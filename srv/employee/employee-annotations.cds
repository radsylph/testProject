using {testService as call} from '../services';

annotate call.employee with {
    name                 @title: 'Nombre';
    lastName             @title: 'Apellido';
    age                  @title: 'Edad';
    email                @title: 'Correo';
    genre                @title: 'Genero';
    cellphone            @title: 'Celular';
    principal_address;
    socialSecurityNumber @title: 'Numero de Seguro Social';
    position             @title: 'Posicion'  @Common.ValueListWithFixedValues: true;
    rank                 @title: 'Rango'     @Common.ValueListWithFixedValues: true;
    salary               @title: 'Salario';
    status               @title: 'Estado';
    ID                   @UI.Hidden;

}

annotate call.employee with {
    status @Common.ValueListWithFixedValues: true;
    genre  @Common.ValueListWithFixedValues: true;
}

annotate call.employee with  @odata.draft.enabled  @(UI: {
    HeaderInfo              : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Empleado',
        TypeNamePlural: 'Empleados',
        Title         : {
            $Type: 'UI.DataField',
            Value: 'prueba header title'
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
            Label: 'Calle'
        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_city,
            Label: 'ciudad'
        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_state,
            Label: 'Estado'
        },
        {
            $Type: 'UI.DataField',
            Value: principal_address_zip,
            Label: 'zipCode'
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
            Label : 'Información Personal',
            ID    : 'PersonalInfoId'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#AddressInfo',
            Label : 'Información de Dirección',
            ID    : 'AddressInfoId'
        },
        {
            $Type        : 'UI.ReferenceFacet',
            Target       : 'workGroups/@UI.LineItem#tablaIntermedia',
            Label        : 'Grupos de trabajo',
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
