DECLARE @name VARCHAR(50)
DECLARE @age INT
DECLARE cur_stu CURSOR
FOR SELECT stuname,age FROM T_student

OPEN cur_stu

FETCH NEXT FROM cur_stu INTO @name,@age
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT(@name + ' ' + CAST(@age AS VARCHAR))
    FETCH NEXT FROM cur_stu INTO @name , @age
END 

CLOSE cur_stu
DEALLOCATE cur_stu


IF OBJECT_ID('T_device', 'U') IS NOT NULL
DROP TABLE T_device
GO
CREATE TABLE T_device
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    deviceName [NVARCHAR](50) NOT NULL,
    deviceNO [char](10) NOT NULL,
    deviceState [char](1) ,

);
GO

INSERT INTO T_device(id,deviceName,deviceNO) VALUES (1,'微机','0011223344')
INSERT INTO T_device(id,deviceName,deviceNO) VALUES (2,'微机','1234887432')
SELECT * FROM T_device

DECLARE @deviceNO CHAR(10)
DECLARE @id int
DECLARE cur_stu CURSOR
FOR SELECT deviceNO,id FROM T_device
OPEN cur_stu

FETCH NEXT FROM cur_stu INTO @deviceNO,@id
WHILE @@FETCH_STATUS = 0
BEGIN
    if ((CAST(SUBSTRING(@deviceNO,1,1) AS INT)+CAST(SUBSTRING(@deviceNO,3,1) AS INT))%2=0)
    BEGIN
        UPDATE T_device SET deviceState = 0 WHERE id = @id
    END
    ELSE
    BEGIN
        UPDATE T_device SET deviceState = 1 WHERE id = @id
    END
    FETCH NEXT FROM cur_stu INTO @deviceNO ,@id
END 

CLOSE cur_stu
DEALLOCATE cur_stu
SELECT * FROM T_device

SELECT * from T_Effect

SELECT  dbo.T_Medicine.medicineId, dbo.T_Medicine.medicineName, dbo.T_Symptom.sDetail, dbo.T_Effect.edetail
FROM     dbo.T_Effect INNER JOIN
               dbo.T_Medicine ON dbo.T_Effect.eId = dbo.T_Medicine.effect INNER JOIN
               dbo.T_Symptom ON dbo.T_Medicine.symptom = dbo.T_Symptom.sId