-- Add profile_pic column to Users table if it doesn't exist
-- This script will create the field automatically for profile picture storage

IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Users' 
    AND COLUMN_NAME = 'profile_pic'
)
BEGIN
    PRINT 'Adding profile_pic column to Users table...'
    
    ALTER TABLE Users 
    ADD profile_pic VARCHAR(MAX) NULL
    
    PRINT 'profile_pic column added successfully!'
END
ELSE
BEGIN
    PRINT 'profile_pic column already exists in Users table.'
END

-- Verify the column was added
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users' 
AND COLUMN_NAME = 'profile_pic'
