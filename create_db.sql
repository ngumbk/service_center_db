CREATE DATABASE service_db;

/* Creating tables 
   21 tables in total */

CREATE TABLE Client (
    client_id int NOT NULL AUTO_INCREMENT,
    client_name varchar(255),
    client_email varchar(255),
    client_phone_number varchar(255),
    PRIMARY KEY (client_id)
);
CREATE TABLE Role (
    role_id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255),
    role_description varchar(255),
    PRIMARY KEY (role_id)
);
CREATE TABLE Employee (
    employee_id int NOT NULL AUTO_INCREMENT,
    employee_name varchar(255),
    employee_email varchar(255),
    employee_phone_number varchar(255),
    role_id int,
    employee_experience int,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);
CREATE TABLE Work (
    work_id int NOT NULL AUTO_INCREMENT,
    work_name varchar(255),
    work_description varchar(255),
    work_cost int,
    PRIMARY KEY (work_id)
);
CREATE TABLE Currency (
    currency_id int NOT NULL AUTO_INCREMENT,
    currency_name varchar(255),
    PRIMARY KEY (currency_id)
);
CREATE TABLE Supplier (
    supplier_id int NOT NULL AUTO_INCREMENT,
    supplier_name varchar(255),
    supplier_email varchar(255),
    supplier_phone_number varchar(255),
    supplier_website varchar(255),
    supplier_address varchar(255),
    supplier_comment varchar(255),
    currency_id int,
    PRIMARY KEY (supplier_id),
    FOREIGN KEY (currency_id) REFERENCES Currency(currency_id)
); 
CREATE TABLE Company (
    company_id int NOT NULL AUTO_INCREMENT,
    company_name varchar(255),
    company_website varchar(255),
    company_phone_number varchar(255)
);
CREATE TABLE DeviceType (
    device_type_id int NOT NULL AUTO_INCREMENT,
    device_type_name varchar(255),
    PRIMARY KEY (device_type_id)
);
CREATE TABLE Device (
    device_id int NOT NULL AUTO_INCREMENT,
    device_model varchar(255),
    company_id int,
    device_type_id int,
    PRIMARY KEY (device_id),
    FOREIGN KEY (company_id) REFERENCES Company(company_id),
    FOREIGN KEY (device_type_id) REFERENCES DeviceType(device_type_id)
);
CREATE TABLE Component (
    component_id int NOT NULL AUTO_INCREMENT,
    component_name varchar(255),
    component_description varchar(255),
    device_id int,
    company_id int,
    supplier_id int,
    component_cost int,
    component_quantity int,
    PRIMARY KEY (component_id),
    FOREIGN KEY (device_id) REFERENCES Device(device_id),
    FOREIGN KEY (company_id) REFERENCES Company(company_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);
CREATE TABLE BatteryType (
    battery_type_id int NOT NULL AUTO_INCREMENT,
    battery_type_name varchar(255),
    PRIMARY KEY (battery_id)
);
CREATE TABLE CableType (
    cable_type_id int NOT NULL AUTO_INCREMENT,
    cable_type_name varchar(255),
    PRIMARY KEY (cable_id)
);
CREATE TABLE DisplayType (
    display_type_id int NOT NULL AUTO_INCREMENT,
    display_type_name varchar(255),
    PRIMARY KEY (display_id)
);
CREATE TABLE Battery (
    battery_id int NOT NULL,
    battery_capacity int,
    battery_voltage float,
    battery_type_id int,
    PRIMARY KEY (battery_id),
    FOREIGN KEY (battery_id) REFERENCES Component(component_id),
    FOREIGN KEY (battery_type_id) REFERENCES BatteryType(battery_type_id)
);
CREATE TABLE Display (
    display_id int NOT NULL,
    display_size float,
    display_resolution varchar(255),
    display_type_id int,
    PRIMARY KEY (display_id),
    FOREIGN KEY (display_id) REFERENCES Component(component_id),
    FOREIGN KEY (display_type_id) REFERENCES DisplayType(display_type_id)
);
CREATE TABLE Cable (
    cable_id int NOT NULL,
    cable_type_id int,
    cable_length float,
    PRIMARY KEY (cable_id),
    FOREIGN KEY (cable_id) REFERENCES Component(component_id),
    FOREIGN KEY (cable_type_id) REFERENCES CableType(cable_type_id)
);
CREATE TABLE OrderStatus (
    order_status_id int NOT NULL AUTO_INCREMENT,
    order_status_name varchar(255),
    PRIMARY KEY (order_status_id)
);
CREATE TABLE Order (
    order_id int NOT NULL AUTO_INCREMENT,
    employee_id int,
    client_id int,
    device_id int,
    order_date timestamp,
    order_status_id int,
    order_total_cost int,
    PRIMARY KEY (order_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (device_id) REFERENCES Device(device_id),
    FOREIGN KEY (order_status_id) REFERENCES OrderStatus(order_status_id),
);
CREATE TABLE Feedback (
    feedback_id int NOT NULL AUTO_INCREMENT,
    order_id int,
    feedback_rating int,
    feedback_text varchar(255),
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (order_id) REFERENCES Order(order_id)
);
CREATE TABLE WorksInOrders (
    order_id int,
    work_id int,
    PRIMARY KEY (order_id, work_id),
    FOREIGN KEY (order_id) REFERENCES Order(order_id),
    FOREIGN KEY (work_id) REFERENCES Work(work_id)
);
CREATE TABLE ComponentsInWork (
    work_id int,
    component_id int,
    PRIMARY KEY (work_id, component_id),
    FOREIGN KEY (work_id) REFERENCES Work(work_id),
    FOREIGN KEY (component_id) REFERENCES Component(component_id)
);