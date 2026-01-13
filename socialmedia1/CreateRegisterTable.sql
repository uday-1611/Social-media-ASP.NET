-- Create Users table for registration system
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Phone NVARCHAR(20),
    Password NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Create stored procedure for user registration
CREATE PROCEDURE sp_RegisterUser
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Username NVARCHAR(50),
    @Phone NVARCHAR(20),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Check if email already exists
        IF EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
        BEGIN
            SELECT -1 AS Status, 'Email already exists' AS Message
            RETURN
        END
        
        -- Check if username already exists
        IF EXISTS (SELECT 1 FROM Users WHERE Username = @Username)
        BEGIN
            SELECT -2 AS Status, 'Username already exists' AS Message
            RETURN
        END
        
        -- Insert new user
        INSERT INTO Users (FirstName, LastName, Email, Username, Phone, Password)
        VALUES (@FirstName, @LastName, @Email, @Username, @Phone, @Password)
        
        SELECT SCOPE_IDENTITY() AS Status, 'Registration successful' AS Message
    END TRY
    BEGIN CATCH
        SELECT -3 AS Status, ERROR_MESSAGE() AS Message
    END CATCH
END;
