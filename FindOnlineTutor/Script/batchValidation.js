/*
Project Name: FindOnlineTutor.
File Name: batchValidation.js.
Created In: 16th Apr 2020
Created By: Rajendra Mishra.
Functionality: This javascript file helps the batch page to validate and create a new batch for teachers
*/

//Initiatization of credential
var inputFields=new Map();
var batchTag = Array();
//pattern variable declared here
var patternName=/^[A-Za-z ]+$/;
var patternTag = /^[A-Za-z0-9 ]+$/;
var patternNumber=/^[0-9]+$/;
var patternText=/^[ A-Za-z0-9_@./&+:-]*$/;
var tagId = 1;

$(document).ready(function()
{
    //adding login button..
    inputFields.set("inputBatchName",{id:"inputBatchName", errorMsg:"Enter your batch name", value:""});
    inputFields.set("inputBatchType",{id:"inputBatchType", errorMsg:"", value:""});
    inputFields.set("inputBatchDetails",{id:"inputBatchDetails", errorMsg:"Enter some details of this batch", value:""});
    inputFields.set("inputBatchStartDate",{id:"inputBatchStartDate", errorMsg:"Select a start date", value:""});
    inputFields.set("inputBatchEndDate",{id:"inputBatchEndDate", errorMsg:"Select a end date", value:""});
    inputFields.set("inputBatchCapacity",{id:"inputBatchCapacity", errorMsg:"Enter the batch capacity", value:""});
    inputFields.set("inputBatchFee",{id:"inputBatchFee", errorMsg:"Enter the batch fee", value:""});
    inputFields.set("inputBatchTag", {id:"inputBatchTag", errorMsg:''})
    
    $("#newBatch").submit(function(e){
        e.preventDefault();
        var successfullyValidated=true;
        // console.log($('input[name="batchType"]:checked').val());
        //client-side validation starts here
        for(var key of inputFields.keys())
        {
            if(inputFields.get(key).errorMsg)
            {
                setErrorBorder(inputFields.get(key));
                successfullyValidated=false;
                console.log(inputFields.get(key).errorMsg)
            }
        }
        console.log(successfullyValidated)
        //if successfully validated data is send to the server for creating batch
        if(successfullyValidated)
        {
            $.ajax({
                type:"POST",
                async: "true",
                url:"../Components/batchService.cfc?method=createBatch",
                cache: false,
                timeout: 2000,
                error: function(){
                    swal({
                        title: "Error",
                        text: "Some server error occurred. Please try after sometimes while we fix it.",
                        icon: "error",
                        button: "Ok",
                    });
                },
                data:{
                        "batchName":$("#inputBatchName").val(),
                        "batchType": $('input[name="inputBatchType"]:checked').val(),
                        "batchDetails": $("#inputBatchDetails").val(),
                        "batchStartDate": $("#inputBatchStartDate").val(),
                        "batchEndDate": $("#inputBatchEndDate").val(),
                        "batchCapacity": $("#inputBatchCapacity").val(),
                        "batchFee": $("#inputBatchFee").val(),
                        "batchTag": JSON.stringify(batchTag)
                    },
                success: function(error) {
                    errorMsgs=JSON.parse(error);
                    if(errorMsgs.hasOwnProperty("error"))
                    {
                        swal({
                            title: "Error",
                            text: errorMsgs.error,
                            icon: "error",
                            button: "Ok",
                        });
                    }
                    else if(errorMsgs.hasOwnProperty("key"))
                    {
                        swal({
                            title: "Successfully Created",
                            text: "Batch: "+$("#batchName").val(),
                            icon: "success",
                            buttons: false,
                        })
                        setTimeout(function(){window.location.reload(true)},2000)
                        
                    }
                    else if(errorMsgs["validatedSuccessfully"]==false)
                    {
                        delete errorMsgs['validatedSuccessfully'];
                        for(var key in errorMsgs) 
                        {
                            if(errorMsgs[key].hasOwnProperty("MSG"))
                            {
                                inputFields.get(key).errorMsg=errorMsgs[key]["MSG"];
                                setErrorBorder(inputFields.get(key));
                            } 
                        }
                        swal({
                            title: "Failed to create a BATCH!!",
                            text: "Some fields fails to validate they are marked red with respective reason's. Try to MODIFY and TRY AGAIN",
                            icon: "error",
                            button: "Ok",
                        });
                    }
                }
            });
        }
    });

});

//border work
function setErrorBorder(object)
{
    $("#"+object.id).css({"border-color": "#CD5C5C", "border-width":"2px"}); 
    $('#'+object.id).next().text(object.errorMsg);
}
function setSuccessBorder(object)
{
    $("#"+object.id).css({"border-color": "#ddd", "border-width":"1px"}); 
    object.errorMsg=""
    $('#'+object.id).next().text(object.errorMsg);
}
function isEmpty(object)
{
    console.log($("#"+object.id).val(), object.id);
    if(!($.trim($("#"+object.id).val())))
    {
        object.errorMsg="Mandatory Fields";
        setErrorBorder(object);
        return true;
    }
    return false;
}
//function for valid pattern..
function isValidPattern(text,pattern)
{
    return pattern.test(text);
}


//validaton fucntions 
function checkBatchName(element)
{
    var object= inputFields.get(element.id);
    if(isEmpty(object))
    {
        return;
    }
    if(!isValidPattern($(element).val(),patternName))
    {
        object.errorMsg="Invalid Pattern. Should contain only alphabets and spaces."
        setErrorBorder(object);
        return;
    }
    if($(element).val().length>20)
    {   
        object.errorMsg="Batch name should be less than 20 characters long.";
        setErrorBorder(object);
        return;
    }
    setSuccessBorder(object);
}

function checkBatchDetails(element)
{
    var object= inputFields.get(element.id);
    if(isEmpty(object))
    {
        return;
    }
    if(!isValidPattern($(element).val(),patternText))
    {
        object.errorMsg="Invalid Pattern. Should contain only alphanumeric characters and [_@./&:+-] symbols."
        setErrorBorder(object);
        return;
    }
    if($(element).val().length>300)
    {   
        object.errorMsg="Batch details should be less than 300 characters long.";
        setErrorBorder(object);
        return;
    }
    setSuccessBorder(object);
}

function checkDate(element)
{
    var object=inputFields.get(element.id);
    if(isEmpty(object))
    {
        return;
    }
    var today = new Date();
    var enteredDate = new Date($(element).val());
    if(enteredDate<today)
    {
        object.errorMsg="Date should be more than today`s date";
        setErrorBorder(object);
        return;
    }    
    if($("#batchStartDate").val()!=null && $("batchEndDate").val()!=null)
    {
        var startDate = new Date($("#batchStartDate").val());
        var endDate = new Date($("#batchEndDate").val());

        if(startDate > endDate)
        {
            inputFields.get("batchEndDate").errorMsg="End Date should not be less than Start Date";
            setErrorBorder(inputFields.get("batchEndDate"));
            return;
        }
        else
        {
            setSuccessBorder(inputFields.get("batchEndDate"));
            return;
        }
    }
    setSuccessBorder(object);
}

function checkCapacityFee(element)
{
    var object=inputFields.get(element.id);
    if(isEmpty(object))
    {
        return;
    }
    if(!isValidPattern($(element).val(), patternNumber))
    {
        object.errorMsg="Should contain only numbers";
        setErrorBorder(object);
        return;
    }
    if(element.id=="batchCapacity" && parseInt($(element).val())>30000 )
    {
        object.errorMsg="Capacity should not exceed 30000";
        setErrorBorder(object);
        return;
    }
    if(element.id=="batchFee" && parseInt($(element).val())>1000000 )
    {
        object.errorMsg="Fee should be less than 10Lacs";
        setErrorBorder(object);
        return;
    }
    setSuccessBorder(object);
}

function addTag()
{
    var tag = $.trim($("#inputBatchTag").val());
    var object = inputFields.get("inputBatchTag");
    if(isEmpty(object))
    {
        setSuccessBorder(object)
        return;
    }
    if(!isValidPattern(tag, patternTag))
    {
        object.errorMsg = "Only alphabets and number allowed";
        setErrorBorder(object);
        return;
    }
    if(tag.length>30)
    {
        object.errorMsg = "Must be only of 30 characters long";
        setErrorBorder(object);
        return;
    }
    if(batchTag.includes(tag))
    {
        object.errorMsg="Value already exists";
        setErrorBorder(object);
        return;
    }
    setSuccessBorder(object);
    batchTag.push(tag);
    var displayTag ='<div class="alert alert-info p-1 m-1">'+
                        '<small class="text-center">'+tag+'</small>'+
                        '<button type="button" class="close ml-1" onclick="deleteTag(this)">&times;</button>'+
                    '</div>'
    $("#tagDiv").append(displayTag);
    $("#inputBatchTag").val('');
}

function deleteTag(button)
{
    var tagSmall = $(button).siblings('small')[0];
    const index = batchTag.indexOf($(tagSmall).text());
    if (index > -1) {
        batchTag.splice(index, 1);
    }
    $(button).parent().remove();
}