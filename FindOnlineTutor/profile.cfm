<!---
Project Name: FindOnlineTutor.
File Name: profile.cfm.
Created In: 7th Apr 2020
Created By: Rajendra Mishra.
Functionality: This file show the profile data to user and allows to modify it.
--->

<cf_header homeLink="index.cfm" logoPath="Images/logo.png" stylePath="Styles/style.css" scriptPath="Script/updateProfile.js">
    <div class="container mt-5">
        <!---if the user is loggedIn this if block will get executed--->
        <cfif structKeyExists(session, "stLoggedInUser")>
            <!---if user disables the javascript--->
            <noscript>
                <div class="container  px-5 text-center">
                    <h3 class="mx-5 text-danger">Please enable <strong>JavaScipt</strong> to submit the form!!</h3>
                </div>
            </noscript>
        
            <!---creating a databaseService object for retriving user profile--->
            <cfset local.databaseServiceObj = createObject("Component","FindOnlineTutor/Components/databaseService")/>
            <!---calling the function for profile data--->
            <cfset local.profileInfo = local.databaseServiceObj.getMyProfile(#session.stloggedinuser.userID#)/>
            
            <!---container containing all required user details data--->
            <div class="container-fuild w-100 mx-auto mb-5 shadow rounded bg-light">
                <!---Heading Field--->
                <div class="bg-dark pt-3 pb-3 rounded-top text-center">
                    <p id="headingUserId" class="hidden"><cfoutput>#session.stloggedinuser.userID#</cfoutput></p>
                    <p class="text-light d-inline" >Your Profile</p>
                </div>
                <!---Form Field for user details--->
                <form id="formUserDetail" class="disabledbutton pb-5 mb-5" id="form-update" method="POST" action="profile.cfm">

                    <div class="alert alert-info pt-3">
                        <p class="text-info text-center">
                            If you want to REMOVE the ALTERNATIVE fields just keep it BLANK.
                        </p>
                    </div>

                    <!---Name Field--->
                    <div class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3">
                            <label class="control-label"  for="firstName">Fullname<span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="firstName" name="firstName" placeholder="First Name" class="form-control d-block" onblur="checkName(this)" value="<cfoutput>#local.profileInfo.firstName#</cfoutput>">
                            <span class="text-danger small float-left"></span>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="lastName" name="lastName" placeholder="Last Name" class="form-control d-block" onblur="checkName(this)" value="<cfoutput>#local.profileInfo.lastName#</cfoutput>">
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>


                    <!---Email Address Field--->
                    <div class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3">
                            <label class="control-label"  for="emailAddress">Email ID:<span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <input type="text" id="emailAddress" name="emailAddress" placeholder="Email Address" class="form-control d-block" onblur="checkEmailId(this)" value="<cfoutput>#local.profileInfo.emailId#</cfoutput>">
                            
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>

                    <!---DOB Field--->
                    <div class="row mt-4 mr-2 ml-2 ">
                        <div class="col-md-3">
                            <label class="control-label"  for="dob">D.O.B:<span class="text-danger">*</span></label>
                        </div>
                        <div class="col-md-4">
                            <input type="date" id="dob" name="dob" placeholder="Create Password" class="form-control d-block" onblur="checkDOB(this)" value="<cfoutput>#local.profileInfo.dob#</cfoutput>">
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>

                    <!---Bio field--->
                    <div class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3">
                            <label class="control-label"  for="bio">Bio (optional):</label>
                        </div>
                        <div class="col-md-8">
                            <textarea type="text" id="bio" name="bio" placeholder="" class="form-control d-block" rows="4" onblur="checkBio(this)"><cfoutput>#local.profileInfo.bio#</cfoutput></textarea>
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>


                    
                    <!---Submit Section--->
                    <div class="row mt-5 mr-2 ml-2">
                        <div class="col-md-12" id="buttonUserDetailDiv">
                        </div>
                    </div>
                        
                </form>

            </div>
        
            <div class="row mt-4 mr-2 ml-2 ">
                <div class="col-md-6">
                    <!---container containing all user phone data--->
                    <div class="container-fuild w-100 mx-auto mb-5 shadow-lg rounded bg-light">
                        <!---Heading Field--->
                        <div class="bg-dark pt-3 pb-3 mt-5 rounded-top text-center">
                            <span id="headingUserId" class="hidden"><cfoutput>#session.stloggedinuser.userID#</cfoutput></span>
                            <p class="text-light d-inline" >Your Phone Numbers</p>
                        </div>
                        <!---Form Field for phone details--->
                        <form id="formUserPhoneDetail" class="disabledbutton pb-5 mb-5" id="form-update" method="POST" action="profile.cfm">

                            <div class="alert alert-info pt-3">
                                <p class="text-info text-center">
                                    If you want to REMOVE the ALTERNATIVE fields just keep it BLANK.
                                </p>
                            </div>
                            
                            <!---Phone Number Field--->
                            <div class="row mt-4 mr-2 ml-2 ">
                                <div class="col-md-6">
                                    <label class="control-label"  for="primaryPhoneNumber">Primary Phone Number:<span class="text-danger">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" id="primaryPhoneNumber" name="primaryPhoneNumber" placeholder="Primary Phone Number" class="form-control d-block" onblur="checkPhoneNumber(this)" value="<cfoutput>#local.profileInfo.phoneNumber[1]#</cfoutput>">
                                    <span class="text-danger small float-left"></span>
                                </div>
                            </div>
                            <div class="row mt-4 mr-2 ml-2 ">
                                <div class="col-md-6">
                                    <label class="control-label"  for="primaryPhoneNumber">Alternative Phone Number:<span class="text-danger">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" id="alternativePhoneNumber" name="alternativePhoneNumber" placeholder="Alternative Phone Number" class="form-control d-block" onblur="checkPhoneNumber(this)" value="<cfoutput>#local.profileInfo.phoneNumber[2]#</cfoutput>">
                                    <span class="text-danger small float-left"></span>
                                </div>
                            </div>

                            
                            <!---Submit Section--->
                                <div class="row mt-5 mr-2 ml-2">
                                    <div class="col-md-12" id="buttonUserPhoneDetailDiv">
                                    </div>
                                </div>
                            <!---Interested location field--->
                            
                        </form>
                    </div>
                </div>
        
                <div class="col-md-6">
                    <!---container containing all user Interest or falicities--->
                    <div class="container-fuild w-100 mx-auto mb-5 shadow rounded bg-light">

                        <!---Heading Field--->
                        <div class="bg-dark pt-3 pb-3 mt-5 rounded-top text-center">
                            <span id="headingUserId" class="hidden"><cfoutput>#session.stloggedinuser.userID#</cfoutput></span>
                            <p class="text-light d-inline" >
                                <cfif session.stLoggedInUser.role EQ 'Teacher'>
                                    <cfoutput>Facilities You Provide</cfoutput>
                                <cfelseif session.stLoggedInUser.role EQ 'student'>
                                    <cfoutput>Interest You Provide</cfoutput>
                                </cfif>
                            </p>
                        </div>
                        <!---Form contains all Interest or teaching details--->
                        <form id="formUserInterestDetail" class="disabledbutton pb-5 mb-5" id="form-update" method="POST" action="profile.cfm">
                            <cfset local.homeLocationExists = ''/>
                            <cfset local.otherLocationExists = ''/>
                            <cfset local.onlineLocationExists = ''/>
                            <cfif local.profileInfo.homeLocation EQ 1>
                                <cfset local.homeLocationExists = 'checked'/>
                            </cfif>
                            <cfif local.profileInfo.otherLocation EQ 1>
                                <cfset local.otherLocationExists = 'checked'/>
                            </cfif>
                            <cfif local.profileInfo.online EQ 1>
                                <cfset local.onlineLocationExists = 'checked'/>
                            </cfif>
                            <div class="alert alert-info pt-3">
                                <p class="text-info text-center">
                                    These fields are not mandatory but it helps in recommandation.
                                </p>
                            </div>
                            <div class="form-check ml-5 mb-2 mt-4">
                                <label class="form-check-label">
                                    <input id="otherLocation" type="checkbox" class="form-check-input" <cfoutput>#local.otherLocationExists#</cfoutput> >
                                    <cfif session.stLoggedinUser.role EQ 'Teacher'>
                                        <cfoutput>Having a Coaching Center</cfoutput>
                                    <cfelseif session.stLoggedinUser.role EQ 'Student'>
                                        <cfoutput>Looking for studying at Coaching center</cfoutput>
                                    </cfif>
                                </label>
                            </div>
                            <div class="form-check ml-5 mb-2">
                                <label class="form-check-label">
                                    <input id="homeLocation" type="checkbox" class="form-check-input" <cfoutput>#local.homeLocationExists#</cfoutput>>
                                    <cfif session.stLoggedinUser.role EQ 'Teacher'>
                                        <cfoutput>Can Teach Student at Home</cfoutput>
                                    <cfelseif session.stLoggedinUser.role EQ 'Student'>
                                        <cfoutput>Looking for Home Teacher</cfoutput>
                                    </cfif>
                                </label>
                            </div>
                            <div class="form-check ml-5 mb-2">
                                <label class="form-check-label">
                                    <input id="online" type="checkbox" class="form-check-input" <cfoutput>#local.onlineLocationExists#</cfoutput>>
                                    <cfif session.stLoggedinUser.role EQ 'Teacher'>
                                        <cfoutput>Having a Online Teaching Facility</cfoutput>
                                    <cfelseif session.stLoggedinUser.role EQ 'Student'>
                                        <cfoutput>Looking for teacher having Online teaching facility</cfoutput>
                                    </cfif>
                                </label>
                            </div>
                            <!---Submit Section--->
                            <div class="row mt-5 mr-2 ml-2">
                                <div class="col-md-12" id="buttonUserInterestDetailDiv">
                                </div>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>

            <!---container containing all user address data--->
            <div class="container-fuild w-100 mx-auto mb-5 shadow rounded bg-light">

                <!---Heading Field--->
                <div class="bg-dark pt-3 pb-3 mt-5 rounded-top text-center">
                    <span id="headingUserId" class="hidden"><cfoutput>#session.stloggedinuser.userID#</cfoutput></span>
                    <p class="text-light d-inline" >Your Addresses</p>
                </div>
                <!---Form Field for Address details--->
                <form id="formUserAddressDetail" class="disabledbutton pb-5 mb-5" id="form-update" method="POST" action="profile.cfm">

                    <div class="alert alert-info pt-3">
                        <p class="text-info text-center">
                            If you want to REMOVE the ALTERNATIVE fields just keep it BLANK.
                        </p>
                    </div>
                    
                    <!---Current Address Field--->

                    <div class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3">
                            <label class="control-label"  for="currentAddress">Current Address:<span class="text-danger">*</span></label>
                        </div>

                        <div class="col-md-8">
                            <textarea type="text" id="currentAddress" name="currentAddress" placeholder="Current Adrress" class="form-control d-block" onblur="checkAddress(this)"></textarea>
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                    <div  class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3"></div>
                        <div class="col-md-4">
                            <select id="currentCountry" name="currentCountry" class="form-control d-block" onblur="checkCountry(this)">
                                <option value="">---select your country----</option>
                            </select>
                            <span class="text-danger small float-left"></span>
                        </div>
                        <div  class="col-md-4">
                            <select id="currentState" name="currentState" class="form-control d-block" onblur="checkState(this)">
                                <option value="">---select your state----</option>
                            </select>
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                    <div class="row mt-4 mr-2 ml-2 ">
                        <div class="col-md-3"></div>
                        <div class="col-md-4">
                            <input type="text" id="currentCity" name="currentCity" placeholder="Current City" class="form-control d-block" onblur="checkAddress(this)">
                            <span class="text-danger small float-left"></span>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="currentPincode" name="currentPincode" placeholder="Current Pincode" class="form-control d-block" onblur="checkPincode(this)" >
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                        
                    <!---Alternative Address Field--->
                    <div class="row mt-4 mr-2 ml-2">
                        <div class="col-md-3">
                            <label class="control-label"  for="alternativeAddress">Alternative Address:</label>
                        </div>
                        <div class="col-md-8">
                            <textarea type="text" id="alternativeAddress" name="alternativeAddress" placeholder="Alternative Adrress" class="form-control d-block" onblur="checkAddress(this)"></textarea>
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                    
                    <div class="row mt-4 mr-2 ml-2 ">
                        <div class="col-md-3"></div>
                        <div class="col-md-4">
                            <select id="alternativeCountry" name="alternativeCountry" class="form-control d-block" onblur="checkCountry(this)">
                                <option value="">---select your country----</option>
                            </select>
                            <span class="text-danger small float-left"></span>
                        </div>
                        <div class="col-md-4">
                            <select id="alternativeState" name="alternativeState" class="form-control d-block" onblur="checkState(this)">
                                <option value="">---select your state----</option>
                            </select>
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                    
                    <div class="row mt-4 mr-2 ml-2 ">
                        <div class="col-md-3"></div>
                        <div class="col-md-4">
                            <input type="text" id="alternativeCity" name="alternativeCity" placeholder="Alternative City" class="form-control d-block" onblur="checkAddress(this)">
                            <span class="text-danger small float-left"></span>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="alternativePincode" name="alternativePincode" placeholder="Alternative Pincode" class="form-control d-block" onblur="checkPincode(this)">
                            <span class="text-danger small float-left"></span>
                        </div>
                    </div>
                    
                    <!---Submit Section--->
                        <div class="row mt-5 mr-2 ml-2">
                            <div class="col-md-12" id="buttonUserAddressDetailDiv">
                            </div>
                        </div>
                    <!---Interested location field--->
                    
                </form>
            </div>
            
        <!---if user not logged in he/she will be redirected to homepage--->
        <cfelse>
            <cflocation  url="/assignments_mindfire/FindOnlineTutor"/>
        </cfif>
    </div>
</cf_header>
	