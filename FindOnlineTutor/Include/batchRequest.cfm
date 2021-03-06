<!---Request Section start from here--->
<div class="col-md-8 p-1 mb-4">
    <div class="p-3 shadow  rounded">
        <div  class="overflow-auto" style="height: 409px;">
            <!---displaying the batch requests--->
            <h3 class=" text-dark d-inline">Batch Requests</h3>
            <hr>
            <!---if no request available a blank msg while be diplayed--->
            <table class="table table-striped">
                <thead>
                    <tr  class="bg-info">
                    <th class="text-light" scope="col">ID</th>
                    <th class="text-light" scope="col">Date</th>
                    <th class="text-light" scope="col">Time</th>
                    <th class="text-light" scope="col">Student</th>
                    <th class="text-light" scope="col">Status</th>
                    <th class="text-light text-center" scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="local.batchInfo.request">
                        <tr>
                            <th>#batchRequestId#.</th>
                            <td>#dateFormat(requestDateTime)#</td>
                            <td>#timeFormat(requestDateTime)#</td>
                            <td><a class="text-dark" href="userDetails.cfm?user=#userId#">#student#</a></td>
                            <td>
                                <cfif requestStatus EQ 'Pending'>
                                    <p class="alert alert-warning p-1 text-center">
                                <cfelseif requestStatus EQ 'Approved'>
                                    <p class="alert alert-success p-1 text-center">
                                <cfelseif requestStatus EQ 'Rejected'>
                                    <p class="alert alert-danger p-1  text-center">
                                </cfif>
                                #requestStatus#
                                    </p>
                            </td>
                            <cfif requestStatus EQ 'Pending'>
                                <td class="text-center">
                                    <button class="btn btn-info m-1" onclick="updateRequest(#batchRequestId#, this)">Approve</button>
                                    <button class="btn btn-danger m-1" onclick="updateRequest(#batchRequestId#, this)">Reject</button>
                                </td>
                            <cfelse>
                                <td><p class="text-center  p-1">Action been taken</p></td>
                            </cfif>
                            
                        </tr>
                </cfoutput>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!---Request Section ends here--->