-- transcantion sql is micoresoft creat to solve special question belove is some question to protect this
-- question 1
select s1.stuname as 姓名,
    case
    when s2.score >= 90 then '优秀'
    when s2.score >= 80 then '良好'
    when s2.score >= 60 then '可以'
    else '挂科'
end as 等级
from T_student s1 inner join T_stuCourse s2 on s1.collegeId = s2.courseId
    inner join T_course s3 on s2.courseId =s3.courseId
where s2.courseId = 2 AND s1.stuname is not null

-- question 2

DECLARE @chicken_num int
set @chicken_num = 1
WHILE @chicken_num <= 35
BEGIN
    if @chicken_num*2+(35-@chicken_num)*4 = 94
    BEGIN
        PRINT('鸡的数量是'+CAST(@chicken_num AS VARCHAR))
        PRINT('鸭的数量是'+CAST(35-@chicken_num AS VARCHAR))
        BREAK
    END
    SET @chicken_num += 1
END
IF @chicken_num = 36
BEGIN
    PRINT('条件不成立')
END


-- question 3

DECLARE @num INT
set @num = 0
WHILE 1 = 1
BEGIN
    IF @num%5=1 and @num%6=5 and @num%7=4 and @num%11=10
    BEGIN
        PRINT('兵数量是'+CAST(@num AS VARCHAR))
        BREAK
    END
    SET @num += 1
END

--question 4

GO
CREATE PROCEDURE proc_collegeStu
AS
    BEGIN
        SELECT c.collegeName AS 学院, s.age AS 年龄, COUNT(*) AS 人数
        FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
        GROUP BY s.age,c.collegeName
    END
GO

EXECUTE proc_collegeStu

GO
CREATE PROCEDURE proc_stuCourseScore
AS
    BEGIN     
        select s3.courseName 课程,s1.stuname as 姓名,
        case
            when s2.score >= 90 then '优秀'
            when s2.score >= 80 then '良好'
            when s2.score >= 60 then '可以'
            else '挂科'
        end as 等级,
        CASE s1.gender
            WHEN '男' THEN '帅哥'
            WHEN '女' THEN '美女'
        END
        from T_student s1 inner join T_stuCourse s2 on s1.stuId = s2.stuId
                           inner join T_course s3 on s2.courseId =s3.courseId
        where s1.stuname is not null
    END
GO

EXECUTE proc_stuCourseScore

--question5
GO
CREATE PROCEDURE proc_getSalary
    @tname nchar(10),
    @salary int OUTPUT
AS
    BEGIN   
        DECLARE @grade int;
        DECLARE @level int;
        SELECT  @grade = grade,@level = level
        FROM T_teacher
        WHERE tname = @tname
        set @salary = 30*@grade+40*@level
    END
GO

DECLARE @salary int 
EXEC proc_getSalary '张老师',@salary output
print(@salary)

SELECT * from T_teacher

