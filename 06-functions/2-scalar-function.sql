-- Create the scalar function
CREATE FUNCTION dbo.GetFullNames
(
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName
END;
GO  -- Batch ends here

-- Test the function
SELECT dbo.GetFullNames('John','Doe') AS FullName;
