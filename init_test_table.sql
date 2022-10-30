--创建表与数据
GO
IF  EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[T_student]') AND type in (N'U'))
DROP TABLE [dbo].[T_student]
GO

IF  EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[T_stuCourse]') AND type in (N'U'))
DROP TABLE [dbo].[T_stuCourse]
GO

IF  EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[T_course]') AND type in (N'U'))
DROP TABLE [dbo].[T_course]
GO

IF  EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[T_college]') AND type in (N'U'))
DROP TABLE [dbo].[T_college]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_college]
(
    [collegeId] [int] IDENTITY(1,1) NOT NULL,
    [collegeName] [nvarchar](50) NULL,
    CONSTRAINT [PK_T_college] PRIMARY KEY CLUSTERED 
(
	[collegeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_course]
(
    [courseId] [int] IDENTITY(1,1) NOT NULL,
    [courseName] [nvarchar](50) NULL,
    [credit] [decimal](3, 1) NULL,
    CONSTRAINT [PK_T_course] PRIMARY KEY CLUSTERED 
(
	[courseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_stuCourse]
(
    [id] [int] IDENTITY(1,1) NOT NULL,
    [stuId] [int] NULL,
    [courseId] [int] NULL,
    [score] [int] NULL,
    CONSTRAINT [PK_T_stuCourse] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_student]
(
    [stuname] [nvarchar](10) NULL,
    [gender] [nchar](1) NULL,
    [age] [int] NULL,
    [address] [nvarchar](50) NULL,
    [math] [int] NULL,
    [eng] [int] NULL,
    [stuId] [int] IDENTITY(1,1) NOT NULL,
    [collegeId] [int] NULL,
    CONSTRAINT [prim_Id] PRIMARY KEY CLUSTERED 
(
	[stuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_college] ON 
GO
INSERT [dbo].[T_college]
    ([collegeId], [collegeName])
VALUES
    (1, N'理学院')
GO
INSERT [dbo].[T_college]
    ([collegeId], [collegeName])
VALUES
    (2, N'信息学院')
GO
SET IDENTITY_INSERT [dbo].[T_college] OFF
GO
SET IDENTITY_INSERT [dbo].[T_course] ON 
GO
INSERT [dbo].[T_course]
    ([courseId], [courseName], [credit])
VALUES
    (1, N'C++设计', CAST(4.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[T_course]
    ([courseId], [courseName], [credit])
VALUES
    (2, N'数据库原理', CAST(3.0 AS Decimal(3, 1)))
GO
INSERT [dbo].[T_course]
    ([courseId], [courseName], [credit])
VALUES
    (3, N'数学分析', CAST(4.5 AS Decimal(3, 1)))
GO
SET IDENTITY_INSERT [dbo].[T_course] OFF
GO
SET IDENTITY_INSERT [dbo].[T_stuCourse] ON 
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (1, 1, 1, 90)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (2, 1, 2, 95)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (3, 1, 3, 88)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (4, 2, 1, 91)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (5, 2, 2, 75)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (6, 2, 3, 69)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (7, 3, 1, 76)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (8, 4, 1, 87)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (9, 5, 1, 65)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (10, 6, 1, 92)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (11, 7, 1, 43)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (12, 8, 1, 100)
GO
INSERT [dbo].[T_stuCourse]
    ([id], [stuId], [courseId], [score])
VALUES
    (13, 9, 1, 92)
GO
SET IDENTITY_INSERT [dbo].[T_stuCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[T_student] ON 
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'张三', N'男', 21, N'石家庄', 90, 80, 1, 1)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'李四', N'男', 19, N'唐山', 100, 80, 2, 2)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'王五', N'女', 20, N'廊坊', 90, 95, 3, 1)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'赵六', N'女', 21, N'石家庄', 50, 70, 4, 1)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'周七', N'男', 21, N'唐山', 45, 55, 5, 2)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'马八', N'女', 23, N'石家庄', 95, 98, 6, 2)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'钱九', N'男', 22, N'张家口', 70, 82, 7, 1)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'张明', N'女', 22, N'秦皇岛', 90, 98, 8, 2)
GO
INSERT [dbo].[T_student]
    ([stuname], [gender], [age], [address], [math], [eng], [stuId], [collegeId])
VALUES
    (N'张武', N'男', 26, N'廊坊', 100, 90, 9, 2)
GO
SET IDENTITY_INSERT [dbo].[T_student] OFF
GO