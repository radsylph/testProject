sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'project1/test/integration/FirstJourney',
		'project1/test/integration/pages/bookList',
		'project1/test/integration/pages/bookObjectPage'
    ],
    function(JourneyRunner, opaJourney, bookList, bookObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('project1') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThebookList: bookList,
					onThebookObjectPage: bookObjectPage
                }
            },
            opaJourney.run
        );
    }
);