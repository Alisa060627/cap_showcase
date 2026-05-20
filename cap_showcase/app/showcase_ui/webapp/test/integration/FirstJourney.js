sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheIncidentsList.iSeeThisPage();
            Then.onTheIncidentsList.onTable().iCheckColumns(4, {"customer_ID":{"header":"customer_ID"},"title":{"header":"Title"},"urgency_code":{"header":"urgency_code"},"status_code":{"header":"status_code"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheIncidentsList.onFilterBar().iExecuteSearch();
            
            Then.onTheIncidentsList.onTable().iCheckRows();

            When.onTheIncidentsList.onTable().iPressRow(0);
            Then.onTheIncidentsObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});