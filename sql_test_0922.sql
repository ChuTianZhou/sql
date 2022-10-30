--这是两种不同的写法，底下这种效率比较高
--1.1.
    SELECT '理学院' AS 学院, s.age AS 年龄 , COUNT(*) AS 人数
    FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
    WHERE c.collegeName='理学院'
    GROUP BY s.age
UNION ALL
    SELECT '信息学院' AS 学院, s.age AS 年龄 , COUNT(*) AS 人数
    FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
    WHERE c.collegeName='信息学院'
    GROUP BY s.age

--1.2.
SELECT c.collegeName AS 学院, s.age AS 年龄, COUNT(*) AS 人数
FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
GROUP BY s.age,c.collegeName

--2..
SELECT courseName AS 课程, AVG(score) AS 平均成绩, COUNT(*) AS 人数
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
GROUP BY courseName

--3.
SELECT age AS 年龄, COUNT(*) AS 人数
FROM T_student s
WHERE s.stuname is not NULL
GROUP BY s.age
HAVING COUNT(*)>2

--4.
SELECT stuname AS 姓名, AVG(score) AS 平均成绩
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
GROUP BY stuname
HAVING AVG(score) >80
ORDER BY 平均成绩 DESC

--5.
SELECT stuname AS 姓名
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE score < 60
GROUP BY stuname
HAVING COUNT(*) > 1

--6.
SELECT s1.stuname AS 姓名
FROM T_student s1
WHERE s1.age>(SELECT AVG(s2.age)
            FROM T_student s2 )

--这是两种不同的写法，底下这种效率比较高,底下这种方法将连接的时间优化成了比较的时间
--7.1.
SELECT stuname AS 姓名,score AS 成绩
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE courseName='数据库原理'

--7.2.
SELECT s.stuname AS 姓名,c.score AS 成绩
FROM T_student s INNER JOIN T_stuCourse c on s.stuId =c.stuId
WHERE c.courseId = (SELECT courseId 
                    FROM T_course
                    WHERE courseName='数据库原理')

--8.
SELECT stuname AS 姓名,dbo.T_student.collegeId AS 学院编号,score AS 成绩
FROM    dbo.T_stuCourse INNER JOIN
        dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId INNER JOIN
        dbo.T_college ON dbo.T_student.collegeId = dbo.T_college.collegeId
WHERE score > (SELECT AVG(score)
FROM T_student s INNER JOIN T_stuCourse c on s.stuId =c.stuId
WHERE c.courseId = 3)

--9.1.
SELECT aa.stuId AS 学号,s1.stuname AS 姓名
FROM (SELECT s2.stuId FROM T_stuCourse s2 GROUP BY s2.stuId HAVING SUM(s2.courseId)=4 or SUM(s2.courseId)=6 ) as aa 
INNER join T_student s1 ON aa.stuId = s1.stuId

--9.2.
SELECT s1.stuId AS 学号, s1.stuname AS 姓名
FROM T_student s1 INNER JOIN T_stuCourse s2 ON s1.stuId = s2.stuId
WHERE s2.courseId = 1
INTERSECT
SELECT s1.stuId AS 学号, s1.stuname AS 姓名
FROM T_student s1 INNER JOIN T_stuCourse s2 ON s1.stuId = s2.stuId
WHERE s2.courseId = 3

--10.
SELECT s.score,c.courseName INTO s FROM T_stuCourse s INNER JOIN T_course c ON s.courseId =c.courseId
SELECT MAX(s.score) 
FROM s
WHERE s.courseName = '数据库原理'
UNION ALL
SELECT AVG(s.score) 
FROM s
WHERE s.courseName = '数据库原理'
UNION ALL
SELECT COUNT(*) 
FROM s
WHERE s.courseName = '数据库原理' AND s.score<60

