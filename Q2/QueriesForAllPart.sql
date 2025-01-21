CREATE DATABASE BusBookingDB;
USE BusBookingDB;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Address TEXT
);

CREATE TABLE BusOperators (
    OperatorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    ContactDetails VARCHAR(100) NOT NULL
);

CREATE TABLE Buses (
    BusID INT PRIMARY KEY AUTO_INCREMENT,
    OperatorID INT,
    BusNumber VARCHAR(20) UNIQUE NOT NULL,
    BusType ENUM('Sleeper', 'AC', 'Non-AC', 'Seater') NOT NULL,
    TotalSeats INT CHECK (TotalSeats > 0),
    Amenities TEXT,
    FOREIGN KEY (OperatorID) REFERENCES BusOperators(OperatorID) ON DELETE CASCADE
);


CREATE TABLE Routes (
    RouteID INT PRIMARY KEY AUTO_INCREMENT,
    Source VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    TotalDistance DECIMAL(5,2) CHECK (TotalDistance > 0),
    Duration INT CHECK (Duration > 0) -- Duration in minutes
);

CREATE TABLE Trips (
    TripID INT PRIMARY KEY AUTO_INCREMENT,
    BusID INT,
    RouteID INT,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    CurrentStatus ENUM('Scheduled', 'Ongoing', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (BusID) REFERENCES Buses(BusID) ON DELETE CASCADE,
    FOREIGN KEY (RouteID) REFERENCES Routes(RouteID) ON DELETE CASCADE
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TripID INT,
    SeatNumber INT CHECK (SeatNumber > 0),
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    BookingStatus ENUM('Confirmed', 'Cancelled', 'Pending') DEFAULT 'Confirmed',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID) ON DELETE CASCADE
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT UNIQUE,
    PaymentMethod ENUM('Card', 'UPI', 'Wallet', 'Cash') NOT NULL,
    PaymentStatus ENUM('Success', 'Failed', 'Pending') DEFAULT 'Pending',
    TransactionID VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE
);

CREATE TABLE CheckIns (
    CheckInID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT UNIQUE,
    TripID INT,
    CheckInTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    BoardingPoint VARCHAR(100) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID) ON DELETE CASCADE
);

CREATE TABLE BusTracking (
    TrackingID INT PRIMARY KEY AUTO_INCREMENT,
    TripID INT UNIQUE,
    CurrentLocation VARCHAR(100) NOT NULL,
    LastUpdatedTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    EstimatedArrivalTime DATETIME NOT NULL,
    FOREIGN KEY (TripID) REFERENCES Trips(TripID) ON DELETE CASCADE
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OperatorID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (OperatorID) REFERENCES BusOperators(OperatorID) ON DELETE CASCADE
);

-- part- B Insert data
INSERT INTO Users (Name, Email, PhoneNumber, Address) VALUES
('Sonali Sharma', 'sonali@gmail.com', '9876543210', 'Raipur, India'),
('Amit Verma', 'amit@gmail.com', '9876543211', 'Delhi, India');

INSERT INTO BusOperators (Name, CompanyName, ContactDetails) VALUES
('Sharma Travels', 'Sharma Bus Services', '9876543219'),
('Verma Transport', 'Verma Travels', '9876543220');


INSERT INTO Buses (OperatorID, BusNumber, BusType, TotalSeats, Amenities) VALUES
(1, 'CG1234', 'Sleeper', 40, 'WiFi, Charging Ports'),
(2, 'DL5678', 'AC', 50, 'Water Bottle, Reclining Seats');


INSERT INTO Routes (Source, Destination, TotalDistance, Duration) VALUES
('Raipur', 'Bhilai', 30.5, 45),
('Delhi', 'Agra', 230.0, 180);


INSERT INTO Trips (BusID, RouteID, DepartureTime, ArrivalTime) VALUES
(1, 1, '2025-01-21 08:00:00', '2025-01-21 08:45:00'),
(2, 2, '2025-01-21 10:00:00', '2025-01-21 13:00:00');


INSERT INTO Bookings (UserID, TripID, SeatNumber) VALUES
(1, 1, 12),
(2, 2, 25);


INSERT INTO Payments (BookingID, PaymentMethod, PaymentStatus, TransactionID) VALUES
(1, 'UPI', 'Success', 'TXN12345'),
(2, 'Card', 'Success', 'TXN67890');


INSERT INTO CheckIns (BookingID, TripID, BoardingPoint) VALUES
(1, 1, 'Raipur Bus Stand'),
(2, 2, 'Delhi ISBT');


INSERT INTO BusTracking (TripID, CurrentLocation, EstimatedArrivalTime) VALUES
(1, 'Near Bhilai', '2025-01-21 08:45:00');


INSERT INTO Reviews (UserID, OperatorID, Rating, Comment) VALUES
(1, 1, 5, 'Great journey, very comfortable.'),
(2, 2, 4, 'Smooth ride, but AC was not working well.');

-- Part C - queries to show benefit from this design

-- To get real-time bus tracking:
SELECT CurrentLocation, EstimatedArrivalTime FROM BusTracking WHERE TripID = 1;


-- To get all confirmed bookings for a trip:
SELECT U.Name, B.SeatNumber FROM Bookings B
JOIN Users U ON B.UserID = U.UserID
WHERE B.TripID = 1;



