--question 1
-- init table and value
IF OBJECT_ID('T_device', 'U') IS NOT NULL
DROP TABLE T_device
GO
CREATE TABLE T_device
(
	id INT NOT NULL PRIMARY KEY,
	-- primary key column
	deviceName [NVARCHAR](50) NOT NULL,
	deviceNO [char](10) NOT NULL,
	deviceState [nchar](10)
	,

);
GO
INSERT INTO T_device
	(id,deviceName,deviceNO)
VALUES
	(1, '微机', '0020123344')
INSERT INTO T_device
	(id,deviceName,deviceNO)
VALUES
	(2, '微机', '1220187432')
SELECT *
FROM T_device

    --store proc

GO
CREATE PROCEDURE proc_updataScarp
	@year INT,
	@totol INT OUTPUT
AS
BEGIN
	DECLARE @deviceNO CHAR(10)
	DECLARE @id int
	DECLARE @totolScarp INT
	SET @totolScarp = 0
	DECLARE cur_stu CURSOR
        FOR SELECT deviceNO, id
	FROM T_device
	OPEN cur_stu

	FETCH NEXT FROM cur_stu INTO @deviceNO,@id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF( YEAR(GETDATE())-CAST(SUBSTRING(@deviceNO,3,4) AS INT)) > @year
		BEGIN
			UPDATE T_device SET deviceState = '报废' WHERE id = @id
			SET @totolScarp = @totolScarp + 1
		END
		ELSE
		BEGIN
			UPDATE T_device SET deviceState = '正常' WHERE id = @id
		END
		FETCH NEXT FROM cur_stu INTO @deviceNO,@id
	END
	set @totol = @totolScarp
	CLOSE cur_stu
	DEALLOCATE cur_stu
END
GO
-- test question 1
DECLARE @totol int
EXEC proc_updataScarp 7,@totol output
PRINT(@totol)
select * from T_device

--question 2	
--init table and value
IF OBJECT_ID('T_teacher_grade', 'U') IS NOT NULL
DROP TABLE T_teacher_grade
GO
CREATE TABLE T_teacher_grade
(
	tId INT NOT NULL PRIMARY KEY,
	tname	[nchar](10) NOT NULL,
	level	[INT],
	grade	[INT],
	salary	[INT],
	totol	[int]

);
GO
INSERT INTO T_teacher_grade(tid,tname,level,grade,salary) VALUES(1, '张老师', 3,2,6000)
INSERT INTO T_teacher_grade(tid,tname,level,grade,salary) VALUES(2, '王老师', 1,4,8000)
SELECT *FROM T_teacher_grade
	--tore proc
GO
CREATE PROCEDURE proc_CalcTotol
AS
    BEGIN   
        DECLARE @grade int;
        DECLARE @level int;
		DECLARE @tId int;
		-- define local var
		DECLARE @salary int;
		DECLARE cur_slary CURSOR
		FOR SELECT grade,level,tId,salary
        FROM T_teacher_grade
		OPEN cur_slary
		FETCH NEXT FROM cur_slary INTO @grade,@level,@tId,@salary
		WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE T_teacher_grade SET totol = 30 * @grade + 40 * @level + @salary WHERE tId = @tId
			FETCH NEXT FROM cur_slary INTO @grade,@level,@tId,@salary
		END
        CLOSE cur_slary
		DEALLOCATE cur_slary
    END
GO
EXEC proc_CalcTotol
SELECT *FROM T_teacher_grad

--question3
	--init table struct
ALTER TABLE T_student ADD phone VARCHAR(11)
ALTER TABLE T_student ADD type NCHAR(10)
select * FROM T_student

GO
alter PROCEDURE proc_judgeOpera
AS
    BEGIN   
		DECLARE @phone VARCHAR(11)
		DECLARE @stuId int
		DECLARE cur_Opera CURSOR
		FOR SELECT phone,stuId
        FROM T_student
		OPEN cur_Opera
		FETCH NEXT FROM cur_Opera INTO @phone,@stuId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF SUBSTRING(@phone,1,3) in (150,186,188)
			BEGIN
				UPDATE T_student SET type = '移动' WHERE stuId = @stuId
			END
			ELSE IF SUBSTRING(@phone,1,3) in (130,136,139)
			BEGIN
				UPDATE T_student SET type = '联通' WHERE stuId = @stuId
			END
			ELSE
			BEGIN
				UPDATE T_student SET type = '其他' WHERE stuId = @stuId
			END
			FETCH NEXT FROM cur_Opera INTO @phone,@stuId
		END
        CLOSE cur_Opera
		DEALLOCATE cur_Opera
    END
GO
EXEC proc_judgeOpera
select phone ,type from T_student