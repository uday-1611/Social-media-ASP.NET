-- Create UserActivity table with foreign key relationship
-- This table will track all user activities (posts, stories, reels)

IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'UserActivity'
)
BEGIN
    PRINT 'Creating UserActivity table...'
    
    CREATE TABLE UserActivity (
        ActivityID INT IDENTITY(1,1) PRIMARY KEY,
        UserID INT NOT NULL,
        ActivityType NVARCHAR(50) NOT NULL, -- 'post', 'story', 'reel'
        ActionType NVARCHAR(50) NOT NULL, -- 'create', 'upload', 'delete', 'like', 'comment'
        Content NVARCHAR(MAX) NULL, -- post content, story caption, reel caption
        MediaUrl NVARCHAR(500) NULL, -- URL to uploaded media (image/video)
        CreatedAt DATETIME DEFAULT GETDATE(),
        UpdatedAt DATETIME DEFAULT GETDATE(),
        IsActive BIT DEFAULT 1,
        
        -- Foreign Key constraint to Users table
        CONSTRAINT FK_UserActivity_Users FOREIGN KEY (UserID)
            REFERENCES Users(Id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );
    
    PRINT 'UserActivity table created successfully!'
END
ELSE
BEGIN
    PRINT 'UserActivity table already exists.'
END

-- Create indexes for better performance
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_UserActivity_UserID' 
    AND object_id = OBJECT_ID('UserActivity')
)
BEGIN
    CREATE INDEX IX_UserActivity_UserID ON UserActivity(UserID);
    PRINT 'Index IX_UserActivity_UserID created.'
END

IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_UserActivity_ActivityType' 
    AND object_id = OBJECT_ID('UserActivity')
)
BEGIN
    CREATE INDEX IX_UserActivity_ActivityType ON UserActivity(ActivityType);
    PRINT 'Index IX_UserActivity_ActivityType created.'
END

IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_UserActivity_CreatedAt' 
    AND object_id = OBJECT_ID('UserActivity')
)
BEGIN
    CREATE INDEX IX_UserActivity_CreatedAt ON UserActivity(CreatedAt DESC);
    PRINT 'Index IX_UserActivity_CreatedAt created.'
END

-- Verify table structure
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'UserActivity' 
ORDER BY ORDINAL_POSITION;

-- Show foreign key relationships
SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables AS tp ON fkc.parent_object_id = tp.object_id
INNER JOIN sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.tables AS tr ON fkc.referenced_object_id = tr.object_id
INNER JOIN sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE tp.name = 'UserActivity';
