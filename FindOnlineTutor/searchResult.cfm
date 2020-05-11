<!---
Project Name: FindOnlineTutor.
File Name: searchResult.cfm.
Created In: 23rd Apr 2020
Created By: Rajendra Mishra.
Functionality: This file show the search result of teachers for batches.
--->
<cfif structKeyExists(session, "stLoggedInUser") AND session.stLoggedInUser.role EQ 'Teacher'>
    <cflocation  url="/assignments_mindfire/FindOnlineTutor">
</cfif>
<cfset isStudent = false>
<!---creating objects of batch service component--->
<cfset batchServiceObj  = createObject("component","FindOnlineTutor.Components.batchService")/>
<cfset databaseServiceObj  = createObject("component","FindOnlineTutor.Components.databaseService")/>

<cf_header homeLink="index.cfm" logoPath="Images/logo.png" stylePath="Styles/style.css" profilePath="profile.cfm" scriptPath="Script/searchBatch.js">

<cfinclude  template="Include/searchForm.cfm">

<div class="container">

    <cfset searchQuery = ''/>
	<cfif structKeyExists(url, "query") AND url.query NEQ ''>
		<cfset searchQuery = url.QUERY/>
		<cfset searchedBatches = batchServiceObj.getSearchBatches(url.query)>

		<cfif structIsEmpty(searchedBatches)>
			<p class='w-100 p-5 mx-3 alert alert-info'>Sorry no batches found</p>
		<cfelse>
			<cfloop array="#searchedBatches.rankedBatchId#" index="batchId">
				<cfdump var = '#searchedBatches[batchId]#'>
			</cfloop>
		</cfif>
    <cfelse>
        <!---display the users near by batches--->
        <cfset myNearBatches = batchServiceObj.getNearByBatch(country='' , state='')/>
    </cfif>

    
    <!---if user is a student then we will provide the additional information about enrollment--->
    <cfif structKeyExists(session, "stLoggedInUser") AND session.stLoggedInUser.role EQ 'Student'>
        <cfset isStudent = true/>
        <cfset myRequest = batchServiceObj.getMyRequests()/>
        <!---if successfully batches are retrieved then those will be displayed here--->
        <cfset requestIds = {}>
        <!---looping through the requests and storing it into the structure for further use--->
        <cfloop query="myRequest.Requests">
            <cfset requestIds['#batchId#'] = '#requestStatus#'>
        </cfloop>
    </cfif>

    <!---filter options will be displayed--->
    <div id="filterDiv" class="row p-3 mt-4">
        <div class="col-md-3">
            <label class="text-primary" >Filter Options :</label>
        </div>
        <div class="col-md-3">
            <input class="form-check-input" type="radio" name="filterOption" id="nearBy" value="batchesNearMe" checked>
            <label class="form-check-label" for="nearBy">
                Batches Near You
            </label>
        </div>
        <div class="col-md-3">
            <input class="form-check-input" type="radio" name="filterOption" id="country" value="batchesInCountry">
            <label class="form-check-label" for="country">
                Filter by Country
            </label>
            <select id="batchCountry" name="currentCountry" class="form-control w-75 hidden">
                <option value="">-select country-</option>
            </select>
        </div>
        <div id="batchStateDiv" class="col-md-3 hidden">
            <input class="form-check-input" type="radio" name="filterOption" id="state" value="batchesInState">
            <label class="form-check-label" for="state">
                Filter By State
            </label>
            <select id="batchState" name="currentState" class="form-control w-75 hidden">
                <option value="">-select state-</option>
            </select>
        </div>
        <p class="hidden"><cfoutput>#isStudent#</cfoutput></p>
    </div>
    
    <cfif NOT structKeyExists(url, "query") OR url.query EQ ''>
        <cfif structKeyExists(myNearBatches, "batch") >
            <div id="batchesDiv">
                <cfoutput query="myNearBatches.batch">
                    <div class="row m-3 p-3 shadow rounded">
                        <div class="col-md-12 border-bottom pb-2">
                            <h3 id="batchName" class=" text-dark d-inline">#batchName#</h3>
                            <span id="batchType" class="text-info h6 ml-2">#batchType#</span>
                            <div id="requestStatus" class="d-inline">
                                <cfif NOT isStudent>
                                    <small class="alert alert-danger mt-2 d-inline float-right p-1 px-2">Please, LogIn to enroll</small>
                                <cfelseif structKeyExists(requestIds, "#batchId#") AND requestIds["#batchId#"] EQ 'Pending'>
                                    <button class="btn btn-success float-right d-inline rounded text-light shadow mx-1 disabled">Pending...</button> 
                                <cfelseif structKeyExists(requestIds, "#batchId#") AND requestIds["#batchId#"] EQ 'Approved'>
                                    <small class="alert alert-success mt-2 text-success d-inline float-right p-1 px-2">Enrolled</small> 
                                <cfelse>
                                    <button class="btn btn-success float-right d-inline rounded text-light shadow mx-1" onclick="enrollStudent(this)">Enroll</button> 
                                </cfif>
                            </div>
                            <a href="batchDetails.cfm?batch=#batchId#" class="btn btn-info float-right d-inline rounded text-light shadow mx-1">Details</a> 
                        </div>
                        <div class="col-md-12 py-2">
                            <span class="text-info h6 mr-2">Description: </span>
                            <p id="batchDetails" class="d-inline text-dark m-2">#batchDetails#</p>
                        </div> 
                        <div class="col-md-4 py-2">
                            <span class="text-info h6 mr-2">Start Date: </span>
                            <p id="batchStartDate" class="d-inline text-dark m-2">#startDate#</p>
                        </div> 
                        <div class="col-md-4 py-2">
                            <span class="text-info h6 mr-2">End Date: </span>
                            <p id="batchEndDate" class="d-inline text-dark m-2">#endDate#</p>
                        </div> 
                        <div class="col-md-4 py-2">
                            <span class="text-info h6 mr-2">Batch Capacity: </span>
                            <p id="batchCapacity" class="d-inline text-dark m-2">#capacity#</p>
                        </div> 
                        <div class="col-md-4 py-2">
                            <span class="text-info h6 mr-2">Enrolled: </span>
                            <p id="batchEnrolled" class="d-inline text-dark m-2">#enrolled#</p>
                        </div> 
                        <div class="col-md-4 py-2">
                            <span class="text-info h6 mr-2">Fee: </span>
                            <p id="batchFee" class="d-inline text-dark m-2">#fee#</p>
                        </div> 
                        <div class="col-md-12 py-2">
                            <span class="text-info h6 mr-2">Address: </span>
                            <cfif batchType EQ 'online'>
                                <p id="batchAddress" class="d-inline text-dark m-2">Online</p>
                            <cfelse>
                                <p id="batchAddress" class="d-inline text-dark m-2">#address#, #city#, #state#, #country#-#pincode#</p>
                            </cfif>
                            
                        </div> 
                    </div>
                </cfoutput>
            </div>
        
        <cfelseif structKeyExists(myNearBatches, "error") OR structKeyExists(myNearBatches.batch, "error")>
            <!---if some error occurred while retrieving the data error msg will be displayed--->
            <div class="alert alert-danger pt-3 pb-3 rounded-top">
                <p class="text-danger text-center">Some error occured while retrieving your batches. Please, try after sometime.</p>
            </div>
        </cfif>
    </cfif>
        
</div>

</cf_header>