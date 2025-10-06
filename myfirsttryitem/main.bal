import ballerina/http;
import ballerina/time;

configurable int servicePort = 8080;

// In-memory storage for demonstration
map<ServiceResponse> dataStore = {};

service / on new http:Listener(servicePort) {
    
    resource function get greeting() returns string {
        return "Hello! Welcome to sinwit first Ballerina service.";
    }
    
    resource function get health() returns HealthStatus {
        return {
            status: "UP",
            message: "sinowit-Service is running successfully"
        };
    }

    // Get all items
    resource function get items() returns ServiceResponse[] {
        return dataStore.toArray();
    }

    // Get specific item by ID
    resource function get items/[string itemId]() returns ServiceResponse|http:NotFound {
        ServiceResponse? item = dataStore[itemId];
        if item is ServiceResponse {
            return item;
        }
        return http:NOT_FOUND;
    }

    // Create new item
    resource function post items(@http:Payload ItemRequest itemRequest) returns ServiceResponse|http:BadRequest {
        if itemRequest.message.trim().length() == 0 {
            return http:BAD_REQUEST;
        }
        
        string itemId = generateItemId();
        ServiceResponse newItem = {
            message: itemRequest.message,
            timestamp: time:utcNow()[0]
        };
        
        dataStore[itemId] = newItem;
        return newItem;
    }

    // Update existing item
    resource function put items/[string itemId](@http:Payload ItemRequest itemRequest) returns ServiceResponse|http:NotFound|http:BadRequest {
        if !dataStore.hasKey(itemId) {
            return http:NOT_FOUND;
        }
        
        if itemRequest.message.trim().length() == 0 {
            return http:BAD_REQUEST;
        }
        
        ServiceResponse updatedItem = {
            message: itemRequest.message,
            timestamp: time:utcNow()[0]
        };
        
        dataStore[itemId] = updatedItem;
        return updatedItem;
    }

    // Delete item
    resource function delete items/[string itemId]() returns http:Ok|http:NotFound {
        if !dataStore.hasKey(itemId) {
            return http:NOT_FOUND;
        }
        
        ServiceResponse removedItem = dataStore.remove(itemId);
        return http:OK;
    }

    // Get service information
    resource function get info() returns ServiceInfo {
        return {
            serviceName: serviceName,
            version: version,
            totalItems: dataStore.length(),
            uptime: "Service is running"
        };
    }
}

// Helper function to generate unique item IDs
function generateItemId() returns string {
    int currentTime = time:utcNow()[0];
    return string `item_${currentTime}`;
}