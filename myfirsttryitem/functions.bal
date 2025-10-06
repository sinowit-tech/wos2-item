import ballerina/time;

// Utility functions for the service

// Validate item request
public function validateItemRequest(ItemRequest request) returns boolean {
    return request.message.trim().length() > 0;
}

// Format timestamp to readable string
public function formatTimestamp(int timestamp) returns string {
    time:Utc utcTime = [timestamp, 0];
    string|error timeString = time:utcToString(utcTime);
    if timeString is string {
        return timeString;
    }
    return "Invalid timestamp";
}

// Get current timestamp
public function getCurrentTimestamp() returns int {
    return time:utcNow()[0];
}

// Generate response with timestamp
public function createServiceResponse(string message) returns ServiceResponse {
    return {
        message: message,
        timestamp: getCurrentTimestamp()
    };
}