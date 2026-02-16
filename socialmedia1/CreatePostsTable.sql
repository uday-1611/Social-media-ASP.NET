-- Create new Posts table with specified column names
-- First drop the old UserActivity table if it exists

IF EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'UserActivity'
)
BEGIN
    PRINT 'Dropping existing UserActivity table...'
    
    -- Drop the old table
    DROP TABLE UserActivity
    
    PRINT 'UserActivity table dropped.'
END

-- Create new Posts table with specified column names
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = 'Posts'
)
BEGIN
    PRINT 'Creating Posts table with new structure...'
    
    CREATE TABLE Posts (
        post_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        content NVARCHAR(MAX) NULL,
        media_url NVARCHAR(500) NULL,
        created_at DATETIME DEFAULT GETDATE()
    );
    
    PRINT 'Posts table created successfully!'
END
ELSE
BEGIN
    PRINT 'Posts table already exists.'
END

-- Create foreign key constraint to Users table
IF NOT EXISTS (
    SELECT 1 
    FROM sys.foreign_keys 
    WHERE name = 'FK_Posts_Users'
    AND parent_object_id = OBJECT_ID('Posts')
)
BEGIN
    PRINT 'Creating foreign key constraint...'
    
    ALTER TABLE Posts
    ADD CONSTRAINT FK_Posts_Users FOREIGN KEY (user_id)
        REFERENCES Users(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    
    PRINT 'Foreign key constraint created.'
END

-- Create index for better performance
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_Posts_user_id' 
    AND object_id = OBJECT_ID('Posts')
)
BEGIN
    CREATE INDEX IX_Posts_user_id ON Posts(user_id);
    PRINT 'Index IX_Posts_user_id created.'
END

-- Create index for created_at for ordering
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_Posts_created_at' 
    AND object_id = OBJECT_ID('Posts')
)
BEGIN
    CREATE INDEX IX_Posts_created_at ON Posts(created_at DESC);
    PRINT 'Index IX_Posts_created_at created.'
END

-- Verify table structure
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Posts' 
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
WHERE tp.name = 'Posts';
