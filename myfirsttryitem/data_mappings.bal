// Data mapping and transformation functions

// Transform ServiceResponse to JSON format
public function serviceResponseToJson(ServiceResponse response) returns json {
    json responseJson = {
        "message": response.message
    };
    
    int? timestamp = response.timestamp;
    if timestamp is int {
        responseJson = {
            "message": response.message,
            "timestamp": timestamp,
            "formattedTime": formatTimestamp(timestamp)
        };
    }
    
    return responseJson;
}

// Transform array of ServiceResponse to JSON array
public function serviceResponseArrayToJson(ServiceResponse[] responses) returns json[] {
    json[] jsonArray = [];
    
    foreach ServiceResponse response in responses {
        json responseJson = serviceResponseToJson(response);
        jsonArray.push(responseJson);
    }
    
    return jsonArray;
}

// Create error response
public function createErrorResponse(string errorMessage, int errorCode) returns ErrorResponse {
    return {
        errorMessage: errorMessage,
        errorCode: errorCode
    };
}