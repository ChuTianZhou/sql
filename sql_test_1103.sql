--question 1 
CREATE TRIGGER trig_deleteStudent
ON T_student
FOR DELETE
AS
    BEGIN
        DECLARE @stuId INT
        SET @stuId = (SELECT stuId FROM deleted)
        DELETE FROM T_stuCourse WHERE stuId = @stuId
    END

--question 2
GO

CREATE TRIGGER trig_calcTotal
ON T_teacher
FOR INSERT
AS
    BEGIN
        DECLARE @total INT
        DECLARE @tname CHAR(10)
        SET @tname = (SELECT tname FROM inserted)
        EXEC proc_geTotal @tname,@total output
        UPDATE T_teacher SET total = @total + salary WHERE tname = @tname
    END


GO
CREATE PROCEDURE [dbo].[proc_geTotal]
    @tname nchar(10),	
    @total int OUTPUT
AS
    BEGIN   
        DECLARE @X int;
        DECLARE @Y int;
        DECLARE @grade int;
        DECLARE @level int;
        SELECT  @grade = t1.grade , @level = t1.level , @X = t2.X , @Y = t2.Y 
		from T_teacher t1 inner join T_teacherParam t2 
						on t1.grade = t2.grade and t1.level = t2.level
        WHERE t1.tname = @tname
        set @total = @X * @grade + @Y * @level
    END


insert T_teacher(tId,tname,[level],grade,salary) VALUES(1,'张老师',3,2,100)