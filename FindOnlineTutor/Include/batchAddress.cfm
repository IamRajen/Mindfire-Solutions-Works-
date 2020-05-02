<div class="row m-3 p-3 shadow rounded  text-center">
    <div class="col-md-3">
        <h3 class="text-dark">Batch Address</h3>
    </div>
    
    <!---if the batch type is online--->
    <cfif batchInfo.overview.batch.batchType EQ 'online'>
        <div class="col-md-6">
            <input type="text" id="addressLink" name="addressLink" placeholder="Batch link address" class="form-control d-block" value="<cfoutput>#batchInfo.overview.batch.addressLink#</cfoutput>">
            <span></span>
        </div>
        <cfif structKeyExists(session, "stLoggedInUser") AND session.stLoggedInUser.role EQ 'Teacher'>
            <div class="col-md-3">
                <button class="btn button-color  d-inline px-3 py-1" onclick="updateBatchAddress('addressLink')">Update</button>
            </div>
        </cfif>
    </cfif>

    <!---if the batch type is home--->
    <cfif batchInfo.overview.batch.batchType EQ 'home'>
        <!---display the user current address here--->
        <p class="p-3 bg-white">
            <cfoutput>#batchInfo.address.Address.Address[1]#, #batchInfo.address.Address.city[1]#, #batchInfo.address.Address.state[1]#,
                #batchInfo.address.Address.country[1]#, #batchInfo.address.Address.pincode[1]#
            </cfoutput>
        </p>
    </cfif>

    <!---if the batch type is coaching--->
    <cfif batchInfo.overview.batch.batchType EQ 'coaching'>
        <!---populating the options address field of user--->
        <div class="col-md-6">
            <select id="addressId" name="addressId" class="form-control d-block">
                <cfoutput query="batchInfo.address.ADDRESS">
                    <option value="#userAddressId#" 
                    <cfif batchInfo.overview.batch.addressId EQ userAddressId> 
                        selected="selected"
                    </cfif>>#address#, #city#, #state#, #country# - #pincode#
                    </option>
                </cfoutput>
            </select>
        </div>
        <div class="col-md-3">
            <button class="btn button-color shadow d-inline px-3 py-1" onclick="updateBatchAddress('addressId')">Update</button>
        </div>
    </cfif>
</div>