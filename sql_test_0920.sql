
--查看现有数据
SELECT *
FROM T_college

SELECT *
FROM T_course

SELECT *
FROM T_stuCourse

SELECT *
FROM T_student

--第一次作业

--1.
SELECT s.stuname AS 姓名, s.age AS 年龄, c.collegeName 学院名
FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId

--2.
SELECT COUNT(*) AS 人数
FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
WHERE c.collegeName='理学院'

--3.
SELECT DISTINCT s.address
FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
WHERE c.collegeName='理学院'

--4.
SELECT AVG(s.age) 平均年龄
FROM T_student s INNER JOIN T_college c ON s.collegeId = c.collegeId
WHERE c.collegeName='理学院' AND s.gender='女'

--5.
SELECT stuname 姓名
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE courseName='数据库原理'

--6.
SELECT MAX(score) 最高分
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE courseName='C++设计'

--7.
SELECT AVG(score) 平均分
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId INNER JOIN
    dbo.T_college ON dbo.T_student.collegeId = dbo.T_college.collegeId
WHERE collegeName='理学院' AND courseName='数据库原理'

--8.
SELECT stuname AS 姓名, score AS 成绩
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE courseName='C++设计'

--9.
SELECT COUNT(*) AS 人数
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE courseName='C++设计' AND score < 60

--10.
SELECT stuname AS 姓名, courseName AS 课程名, score AS 成绩
FROM dbo.T_course INNER JOIN
    dbo.T_stuCourse ON dbo.T_course.courseId = dbo.T_stuCourse.courseId INNER JOIN
    dbo.T_student ON dbo.T_stuCourse.stuId = dbo.T_student.stuId
WHERE stuname='张三'
