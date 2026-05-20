sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"showcase/ui/showcaseui/test/integration/pages/IncidentsList",
	"showcase/ui/showcaseui/test/integration/pages/IncidentsObjectPage"
], function (JourneyRunner, IncidentsList, IncidentsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('showcase/ui/showcaseui') + '/test/flp.html#app-preview',
        pages: {
			onTheIncidentsList: IncidentsList,
			onTheIncidentsObjectPage: IncidentsObjectPage
        },
        async: true
    });

    return runner;
});

