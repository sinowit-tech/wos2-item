// Define custom types for the service

public type ServiceResponse record {
    string message;
    int timestamp?;
};

public type HealthStatus record {
    string status;
    string message;
};

public type ItemRequest record {
    string message;
};

public type ServiceInfo record {
    string serviceName;
    string version;
    int totalItems;
    string uptime;
};

public type ErrorResponse record {
    string errorMessage;
    int errorCode;
};