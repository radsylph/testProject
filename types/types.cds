type Address {
    street : String  @title: '{i18n>address.street}';
    city   : String  @title: '{i18n>address.city}';
    state  : String  @title: '{i18n>address.state}';
    zip    : Integer @title: '{i18n>address.zip}';
}
