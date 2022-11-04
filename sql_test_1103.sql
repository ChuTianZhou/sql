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

GO

CREATE TRIGGER trig_updateTotal
ON T_teacher
FOR UPDATE
AS
BEGIN
    DECLARE @tname INT
    DECLARE @grade INT
    DECLARE @level INT
    DECLARE @total INT
    SELECT tname = @tname,grade=@grade,[level]=@level FROM inserted
    EXEC proc_geTotal @tname,@total OUTPUT
    UPDATE T_teacher SET total = @total + salary WHERE tname = @tname
END


GO
CREATE FUNCTION getRemaingDays(@year INT,@month INT)
RETURNS INT
AS
BEGIN
    DECLARE @flag INT
    DECLARE @remaindays INT
    IF @year % 4 = 0 AND @year % 100 != 0 OR @year % 400 = 0 
        SET @flag = 1 
    ELSE
        SET @flag = 0 
    IF @month in (1,3,5,7,8,10,12) 
        SET @remaindays = 31 
    ELSE IF @month IN (4,6,9,11)
        SET @remaindays = 30
    ELSE IF @flag = 1
        SET @remaindays = 29
    ELSE
        SET @remaindays = 28
    RETURN @remaindays
END

GO
PRINT(dbo.getRemaingDays(1952,2))

GO
CREATE FUNCTION getCourseInf(@collogeId INT,@courseId INT)
RETURNS @CourseInf TABLE
(stuname nvarchar(10),gender nchar(2),level nchar(1),memo nchar(10))
AS
BEGIN
    DECLARE @stuname NVARCHAR(10)
    DECLARE @gender NCHAR(1)
    DECLARE @gender_inf NCHAR(2)
    DECLARE @score INT
    DECLARE @level NCHAR(1)
    DECLARE @memo NCHAR(10)
    DECLARE cur_stuInf CURSOR
    FOR SELECT t1.stuname,t1.gender,t2.score
        FROM T_student t1 inner join T_stuCourse t2 on t1.stuId = t2.stuId
                        inner join T_college t3 on t1.collegeId = t3.collegeId
        WHERE t2.courseId = @courseId AND t4.collegeId = @collogeId
    OPEN cur_stuInf
    FETCH NEXT FROM cur_stuInf INTO @stuname,@gender,@score
    WHILE @@FETCH_STATUS = 0 
    BEGIN
        SET @gender_inf = 
        CASE @gender
           WHEN '男' THEN '帅哥'
           WHEN '女' THEN '美女' 
        END
        SET @level =
        CASE 
            WHEN @score >= 90 THEN '优秀'
            WHEN @score >= 80 THEN '良好'
            WHEN @score >= 60 THEN '可以'
        END
        SET @memo =
        CASE 
            WHEN @score >= 90 THEN '厉害呀，保持'
            WHEN @score >= 80 THEN '努力啊'
            WHEN @score >= 60 THEN '加油'
        END
        INSERT INTO @CourseInf VALUES(@stuname,@gender_inf,@level,@memo)
        FETCH NEXT FROM cur_stuInf INTO @stuname,@gender,@score
    END
    CLOSE cur_stuInf
    DEALLOCATE cur_stuInf
    RETURN
END

GO
select * from dbo.getCourseInf(1,1)