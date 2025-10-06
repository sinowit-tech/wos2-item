import ballerina/http;

configurable int servicePort = 8080;

service / on new http:Listener(servicePort) {
    
    resource function get greeting() returns string {
        return "Hello! Welcome to sinwit first Ballerina service.";
    }
    
    resource function get health() returns json {
        return {
            "status": "UP",
            "message": "sinowit-Service is running successfully"
        };
    }
}