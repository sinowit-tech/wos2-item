// Define custom types for the service if needed in future

public type ServiceResponse record {
    string message;
    int timestamp?;
};

public type HealthStatus record {
    string status;
    string message;
};