using {testService as call} from '../services';

annotate call.client with {
    name      @title: 'Nombre';
    lastName  @title: 'Apellido';
    age       @title: 'Edad';
    email     @title: 'Correo';
    genre     @title: 'Genero';
    cellphone @title: 'Celular';
    principal_address;
    rfc       @title: 'RFC';
}

annotate call.client with {
    genre @Common.ValueListWithFixedValues: true;
}


annotate call.client with  @odata.draft.enabled  @(UI: {
    HeaderInfo              : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Cliente',
        TypeNamePlural: 'Clientes',
        Title         : {
            $Type: 'UI.DataField',
            Value: 'prueba header title cliente'
        }
    },

    SelectionFields         : [rfc

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
                Value: rfc
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
        }
    ],

    Facets                  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#PersonalInfo',
            Label : 'Informacion personal',
            ID    : 'PersonalInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#AddressInfo',
            Label : 'Informacion de direccion',
            ID    : 'AddressInfo'
        }
    ],
});
