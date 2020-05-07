<!---
Project Name: FindOnlineTutor.
File Name: teachersDetails.cfm.
Created In: 4th Apr 2020
Created By: Rajendra Mishra.
Functionality: A teacher page containing the detail information about the teacher
--->

<cfset batchServiceObj = createObject("component","FindOnlineTutor.Components.batchService")/>
<cfset profileServiceObj = createObject("component","FindOnlineTutor.Components.profileService")/>

<cfset userDetails = profileServiceObj.getUserDetails(userId = url.user)>

<cf_header homeLink="../index.cfm" logoPath="../Images/logo.png" stylePath="../Styles/style.css">

<div class="container">
    <cfif structKeyExists(userDetails, "error")>
        <p class="w-100 p-5 my-5 alert alert-secondary text-center">
            <cfoutput>
                #userDetails.error#
            </cfoutput>
        </p>
    <cfelse>
        <cfif structKeyExists(session, "stLoggedInUser") AND session.stLoggedInUser.role EQ 'Student'>
            <cfset myRequest = batchServiceObj.getMyRequests()/>
            <!---if successfully batches are retrieved then those will be displayed here--->
            <cfset requestIds = {}>
            <!---looping through the requests and storing it into the structure for further use--->
            <cfloop query="myRequest.Requests">
                <cfset requestIds['#batchId#'] = '#requestStatus#'>
            </cfloop>
        </cfif>
        
        <div class="p-5">
            <h3 class="text-secondary">Overview:</h3>
            <cfoutput query="userDetails.overview.user">
                <cfinclude  template="../Include/userOverview.cfm">
            </cfoutput>
        </div>

        <div class="p-5">
            <h3 class="text-secondary">Address:</h3>
            <div class="container border shadow rounded p-4">
                <cfset currentRow = 1/>
                <cfoutput query="userDetails.address.address">
                    <small class="text-primary">
                        <cfif currentRow == 1>
                            Current Address : 
                        <cfelse>
                            Alternative Address : 
                        </cfif>
                    </small>
                    <cfinclude  template="../Include/address.cfm">
                </cfoutput>
            </div>
        </div>

        <div class="p-5">
            <h3 class="text-secondary">Batches:</h3>
            <cfoutput query="userDetails.batch.batches">
                <cfinclude  template="../Include/batchOverview.cfm">
            </cfoutput>
        </div>
    </cfif>
</div>
</cf_header>