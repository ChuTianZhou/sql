-- 以下为表初始化部分--
DROP TABLE [dbo].[T_student]

CREATE TABLE [dbo].[T_student](
	[stuname] [nvarchar](10) NULL,
	[gender] [nchar](1) NULL,
	[age] [int] NULL,
    [address] [nvarchar](50) NULL,
    [math] [int] NULL,
    [eng] [int] NULL,
) ON [PRIMARY]

--设置自增主键
ALTER TABLE dbo.T_student ADD stuId BIGINT IDENTITY ( 1, 1 ) NOT NULL
ALTER TABLE dbo.T_student ADD CONSTRAINT prim_Id PRIMARY KEY ( stuId )

--清除表中原有数据
DELETE T_student

-- 初始化数据
INSERT INTO T_student VALUES ('张三','男',21,'石家庄',90,80)
INSERT INTO T_student VALUES ('李四','男',19,'唐山',100,80)
INSERT INTO T_student VALUES ('王五','女',20,'廊坊',90,95)
INSERT INTO T_student VALUES ('赵六','女',21,'石家庄',50,70)
INSERT INTO T_student VALUES ('周七','男',21,'唐山',45,55)
INSERT INTO T_student VALUES ('马八','女',23,'石家庄',95,98)
INSERT INTO T_student VALUES ('钱九','男',22,'张家口',70,82)
INSERT INTO T_student VALUES ('张明','女',22,'秦皇岛',90,98)
INSERT INTO T_student VALUES ('张武','男',26,'廊坊',100,90)
INSERT INTO T_student(stuname,gender,age,address) VALUES ('测试3','男',26,'廊坊')

SELECT * 
FROM T_student

DELETE T_student
WHERE stuname='测试2'
-- 以下为作业部分 --

-- 1.
SELECT stuname 姓名, age 年龄, address 籍贯
FROM T_student 

-- 2.
SELECT stuname 姓名
FROM T_student
WHERE address = '石家庄'

-- 3.
SELECT stuname 姓名, age 年龄
FROM T_student
WHERE address = '石家庄' AND gender = '男'

-- 4.
SELECT stuname 姓名, age 年龄
FROM T_student
WHERE address = '唐山'
ORDER BY age DESC

--5.
SELECT stuname as 姓名, (math+eng) as total 
FROM T_student
ORDER BY total DESC

--6.
SELECT DISTINCT address
FROM T_student

--7.
DELETE T_student 
WHERE age >25

--8.
UPDATE T_student
SET eng = eng - 5 
WHERE gender ='女'

--9.
SELECT stuname as 姓名
FROM T_student t
WHERE (t.math + t.eng) BETWEEN 150 and 180

--10.
SELECT top 3 stuname as 姓名, math , eng
FROM T_student
ORDER BY (math+eng) DESC

--11.
SELECT COUNT(*) as 人数
FROM T_student
WHERE math < 60

--12.
SELECT COUNT(*) as 人数
FROM T_student
WHERE math >90

--13.
SELECT Max(math) as 最高,MIN(math) as 最低, AVG(math) as 平均 
FROM T_student

--14.
SELECT COUNT(*) as 人数
FROM T_student
WHERE (math + eng) >180

--15.
SELECT COUNT(*) as 人数
FROM T_student
WHERE stuname LIKE '张%'

--16.
SELECT *
FROM T_student
WHERE age in (19,21,23)

select * from T_student
SELECT * from T_college

select * from T_student s inner join T_college c on s.collegeId = c.collegeId

