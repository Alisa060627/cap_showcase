using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        TypeImageUrl : 'sap-icon://alert',
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>General Information}',
                    ID : 'i18nGeneralInformation',
                    Target : '@UI.FieldGroup#i18nGeneralInformation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversations}',
            ID : 'i18nConversations',
            Target : 'conversation/@UI.LineItem#i18nConversations',
        },
    ],
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
                Criticality : status.criticality,
            },
        ],
    },
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
        ],
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : status_code,
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency_code,
        },
        {
            $Type : 'UI.DataField',
            Value : title,
        },
    ],
);

annotate service.Incidents with {
    status @Common.Label : '{i18n>Status}'
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    status @Common.Text : status.descr;
    urgency @(
        Common.Text : urgency.descr,
        Common.Text.@UI.TextArrangement : #TextFirst,
    );
};


annotate service.Incidents with {
    customer @(
        Common.Text : customer.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Customers with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Incidents.conversation with @(
    UI.LineItem #i18nConversations : [
        {
            $Type : 'UI.DataField',
            Value : author,
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
        },
    ]
);

