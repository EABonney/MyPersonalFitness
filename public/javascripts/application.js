// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function changePlanType()
{
    var AUTH_TOKEN = window._token;
    var plan_type;

    if( document.getElementById && (plan_type = document.getElementById('plan_type_id')) )
    {
         var indexPlanType = plan_type.selectedIndex;
         var selPlanType = plan_type[indexPlanType].value;
         var arrPlanType = new Array();
         arrPlanType["type"] = selPlanType;

         var e = document.getElementById('workoutsummary');
         var parent = e.parentNode;
         parent.removeChild(e);
        
         // Send the request to the server to update the workouts displayed.
         new Ajax.Request('/change_workouts_display'+'?authenticity_token='+AUTH_TOKEN,
            {method: 'put',
                parameters: arrPlanType,
                onComplete: function(request)
                {
                    // parse the result to JSON by eval-ing it
                    result = eval( "(" + request.responseText + ")" );

                    // check to see if it was an error or success
                   if(!result.success)
                   {
                        alert( 'AJAX.Request FAILED!' + result.content );
                   }
                   else
                   {
                        // everything went right so redirect back to the routes index page.
                        fillInWorkouts(result.content);
                   }
                }
            }); // end of the Ajax request
    }
}

function changeRaceType()
{
    var AUTH_TOKEN = window._token;
    var race_type;

    if( document.getElementById && (race_type = document.getElementById('race_race_type')) )
    {
         var indexRaceType = race_type.selectedIndex;
         var selRaceType = race_type[indexRaceType].value;
         var arrRaceType = new Array();
         arrRaceType["value"] = selRaceType;

         //var e = document.getElementById('race_distance');
         //var parent = e.parentNode;
         //parent.removeChild(e);

         // Send the request to the server to update the workouts displayed.
         new Ajax.Request('/races/new.urd'+'?authenticity_token='+AUTH_TOKEN,
            {method: 'get',
                parameters: arrRaceType,
                onComplete: function(request)
                {
                    // parse the result to JSON by eval-ing it
                    result = eval( "(" + request.responseText + ")" );

                    // check to see if it was an error or success
                   if(!result.success)
                   {
                        alert( 'AJAX.Request FAILED!' + result.content );
                   }
                   else
                   {
                        // everything went right so redirect back to the routes index page.
                        fillInDistances(result.content);
                   }
                }
            }); // end of the Ajax request
    }
}

function fillInWorkouts( results )
{
    var createDayBlock = false;
    var addDailyWorkout = false;
    var blockNumber = 0;
    results = results.substring(1,results.length-1);
    var workouts = new Array();
    var msg;

    workouts = parseJSON( results );
    var divWrkSum = document.createElement('div');
    divWrkSum.setAttribute( 'id', 'workoutsummary' );
    
    var divDayBlck;
    var h3;
    for(var i=1; i<=workouts.length; i++)
    {
        if( i== 1 )
        {
            createDayBlock = true;
            blockNumber += 1;
        }
        else if( i == workouts.length )
            createDayBlock = false;
        else if(workouts[i-2]["date"] != workouts[i-1]["date"])
        {
            createDayBlock = true;
            blockNumber += 1;
        }
        else
            createDayBlock = false;

        // Create the Daily header
        if (createDayBlock)
        {
            divDayBlck = document.createElement('div');
            divDayBlck.setAttribute('id', 'dayblock'+blockNumber);
            h3 = document.createElement('h3');
            h3.appendChild(document.createTextNode(workouts[i-1]["date"]));
        }

        var divWkType;
        var divActivityIcon;
        var Img;
        var divDurDisPace;
        var divLinkEdit;
        var divLinkDelete;
        var divWorkoutRoute;
        var divWorkoutNotes;
        divLinkEdit = document.createElement('div');
        divLinkEdit.setAttribute('id', 'linkedit');
        divLinkDelete = document.createElement('div');
        divLinkDelete.setAttribute('id', 'linkdelete');
        var hrefEdit = document.createElement('a');
        hrefEdit.appendChild( document.createTextNode( "Edit") );
        var hrefDel = document.createElement('a');
        hrefDel.appendChild( document.createTextNode( "Delete" ) );
        divWorkoutRoute = document.createElement('div');
        divWorkoutRoute.setAttribute('id', 'workoutroute');
        divWorkoutNotes = document.createElement('div');
        divWorkoutNotes.setAttribute('id', 'workoutnotes');
        switch( workouts[i-1]["type"])
        {
            case "SwimWorkout":
                divWkType = document.createElement('div');
                divWkType.setAttribute('id', 'displayswim');
                divActivityIcon = document.createElement('div');
                divActivityIcon.setAttribute('id', 'activityicon');
                Img = document.createElement('img');
                Img.setAttribute('src', '/images/swimming-icon64x64.png');
                Img.setAttribute('alt', 'Swimming-icon64x64');
                msg = workouts[i-1]['duration'] + ' | ' + workouts[i-1]['distance']
                    + ' yds | ' + workouts[i-1]['pace'] + ' min/100';
                hrefEdit.setAttribute( 'href', '/swim_workouts/' + workouts[i-1]['id'] + '/edit');
                hrefDel.setAttribute( 'href', '/swim_workouts/' + workouts[i-1]['id']  );
                break;
            case "BikeWorkout":
                divWkType = document.createElement('div');
                divWkType.setAttribute('id', 'displaybike');
                divActivityIcon = document.createElement('div');
                divActivityIcon.setAttribute('id', 'activityicon');
                Img = document.createElement('img');
                Img.setAttribute('src', '/images/cycling-icon64x64.png');
                Img.setAttribute('alt', 'Biking-icon64x64');
                msg = workouts[i-1]['duration'] + ' | ' + workouts[i-1]['distance']
                    + ' mi | ' + workouts[i-1]['pace'] + ' mi/hr';
                hrefEdit.setAttribute( 'href', '/bike_workouts/' + workouts[i-1]['id'] + '/edit');
                hrefDel.setAttribute( 'href', '/bike_workouts/' + workouts[i-1]['id']  );
                break;
            case "RunWorkout":
                divWkType = document.createElement('div');
                divWkType.setAttribute('id', 'displaybike');
                divActivityIcon = document.createElement('div');
                divActivityIcon.setAttribute('id', 'activityicon');
                Img = document.createElement('img');
                Img.setAttribute('src', '/images/running-icon64x64.png');
                Img.setAttribute('alt', 'Running-icon64x64');
                msg = workouts[i-1]['duration'] + ' | ' + workouts[i-1]['distance']
                    + ' mi | ' + workouts[i-1]['pace'] + ' min/mi';
                hrefEdit.setAttribute( 'href', '/run_workouts/' + workouts[i-1]['id'] + '/edit');
                hrefDel.setAttribute( 'href', '/run_workouts/' + workouts[i-1]['id']  );
                break;
            case "OtherWorkout":
                divWkType = document.createElement('div');
                divWkType.setAttribute('id', 'displayother');
                divActivityIcon = document.createElement('div');
                divActivityIcon.setAttribute('id', 'activityicon');
                Img = document.createElement('img');
                Img.setAttribute('src', '/images/bag-64x64.png');
                Img.setAttribute('alt', 'Bag-64x64');
                msg = workouts[i-1]['duration'] + ' | ' + workouts[i-1]['distance']
                    + ' mi | ' + workouts[i-1]['pace'] + ' min/mi';
                hrefEdit.setAttribute( 'href', '/other_workouts/' + workouts[i-1]['id'] + '/edit');
                hrefDel.setAttribute( 'href', '/other_workouts/' + workouts[i-1]['id'] );
                break;
        }
        if( h3 != 0)
            divDayBlck.appendChild(h3);
        divDurDisPace = document.createElement('div');
        divDurDisPace.setAttribute('id', 'durationdistancepace');
        divDurDisPace.appendChild(document.createTextNode(msg));
        divLinkEdit.appendChild(hrefEdit);
        divLinkDelete.appendChild(hrefDel);
        divDurDisPace.appendChild(divLinkEdit);
        divDurDisPace.appendChild(divLinkDelete);
        divActivityIcon.appendChild(Img);
        divWkType.appendChild(divActivityIcon);
        var txt = workouts[i-1]['notes'].split('\r\n');
        for( var line=0; line<txt.length; line++)
        {
            divWorkoutNotes.appendChild( document.createTextNode( txt[line] ) );
            divWorkoutNotes.appendChild( document.createElement('br') );
        }
        if( workouts[i-1]['route_id'] != "" )
        {
            var routeHref = document.createElement('a');
            routeHref.setAttribute( 'href', '/routes/' + workouts[i-1]['route_id'] );
            routeHref.appendChild( document.createTextNode( 'Route' ) );
            divWorkoutRoute.appendChild(routeHref);
            divWkType.appendChild(divWorkoutRoute);
        }
        divWkType.appendChild(divDurDisPace);
        divWkType.appendChild(divWorkoutNotes);
        divDayBlck.appendChild(divWkType);
        divWrkSum.appendChild(divDayBlck);
        h3 = 0;
    }
    document.getElementById('bodycontent').appendChild(divWrkSum);
}

function fillInDistances( results )
{
    results = results.substring(1,results.length-1);
    var distances = new Array();
    var msg;

    distances = parseJSON( results );

    $('race_race_distance').options.length = 0;
    var opt = document.createElement('option');
    opt.text = "- Select a distance -";
    opt.value = "- Select a distance -";
    $('race_race_distance').options.add( opt );

    for(var i=0; i<distances.length; i++)
    {
        opt = document.createElement('option');
        opt.text = distances[i]['distance'];
        opt.value = distances[i]['distance'];
        $('race_race_distance').options.add(opt)
    }
}

function parseJSON( jsonData )
{
    // remove the '[' and ']' from the first and last records.
    jsonData = jsonData.substring(1,jsonData.length-1);
    var jsonSplit = jsonData.split("},");
    var jsonObjects = new Array();

    for (var i=0; i<jsonSplit.length; i++)
    {
        var objects = new Array();
        var tmp = jsonSplit[i].split(',"');
        for( var j=0; j<tmp.length; j++ )
        {
            var str = tmp[j];
            // if we are on the first element we need to remove the '{'
            if (j == 0)
                str = str.substring(2);

            // We need to see if we are on the very last element, if so we need to remove the '}'
            if( (i == jsonSplit.length-1) && (j == tmp.length-1) )
                str = str.substring(0, str.length-1);
            
            str = str.split('":');
            objects[str[0]] = str[1];
        }
        jsonObjects.push(objects);
        objects.length = 0;
    }
    return jsonObjects;
}