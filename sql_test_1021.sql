
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
        end as 等级
        from T_student s1 inner join T_stuCourse s2 on s1.stuId = s2.stuId
                           inner join T_course s3 on s2.courseId =s3.courseId
        where s1.stuname is not null
    END
GO

EXECUTE proc_stuCourseScore

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

