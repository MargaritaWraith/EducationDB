
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/16/2018 18:05:21
-- Generated from EDMX file: C:\Users\Kondr\source\MAI\DataBases\EducationDB\EducationDB.Lib\EducationDB.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [EducationDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_LecturerCourse_Lecturer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LecturerCourse] DROP CONSTRAINT [FK_LecturerCourse_Lecturer];
GO
IF OBJECT_ID(N'[dbo].[FK_LecturerCourse_Course]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LecturerCourse] DROP CONSTRAINT [FK_LecturerCourse_Course];
GO
IF OBJECT_ID(N'[dbo].[FK_LaboratoryWorkCourse]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LaboratoryWorkSet] DROP CONSTRAINT [FK_LaboratoryWorkCourse];
GO
IF OBJECT_ID(N'[dbo].[FK_StudentGroupStudent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentSet] DROP CONSTRAINT [FK_StudentGroupStudent];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[StudentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentSet];
GO
IF OBJECT_ID(N'[dbo].[CourseSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CourseSet];
GO
IF OBJECT_ID(N'[dbo].[LecturerSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LecturerSet];
GO
IF OBJECT_ID(N'[dbo].[LaboratoryWorkSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LaboratoryWorkSet];
GO
IF OBJECT_ID(N'[dbo].[StudentGroupSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentGroupSet];
GO
IF OBJECT_ID(N'[dbo].[LecturerCourse]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LecturerCourse];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Students'
CREATE TABLE [dbo].[Students] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Surname] nvarchar(max)  NOT NULL,
    [StudentGroup_Id] int  NOT NULL
);
GO

-- Creating table 'Courses'
CREATE TABLE [dbo].[Courses] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Lecturers'
CREATE TABLE [dbo].[Lecturers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Surname] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'LaboratoryWorks'
CREATE TABLE [dbo].[LaboratoryWorks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Course_Id] int  NOT NULL
);
GO

-- Creating table 'StudentGroups'
CREATE TABLE [dbo].[StudentGroups] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'LaboratoryWorkExecutions'
CREATE TABLE [dbo].[LaboratoryWorkExecutions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Order] int  NULL,
    [Student_Id] int  NOT NULL,
    [LaboratoryWork_Id] int  NOT NULL
);
GO

-- Creating table 'LecturerCourse'
CREATE TABLE [dbo].[LecturerCourse] (
    [Lecturers_Id] int  NOT NULL,
    [Courses_Id] int  NOT NULL
);
GO

-- Creating table 'StudentCourse'
CREATE TABLE [dbo].[StudentCourse] (
    [Students_Id] int  NOT NULL,
    [Courses_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Students'
ALTER TABLE [dbo].[Students]
ADD CONSTRAINT [PK_Students]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Courses'
ALTER TABLE [dbo].[Courses]
ADD CONSTRAINT [PK_Courses]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Lecturers'
ALTER TABLE [dbo].[Lecturers]
ADD CONSTRAINT [PK_Lecturers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LaboratoryWorks'
ALTER TABLE [dbo].[LaboratoryWorks]
ADD CONSTRAINT [PK_LaboratoryWorks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'StudentGroups'
ALTER TABLE [dbo].[StudentGroups]
ADD CONSTRAINT [PK_StudentGroups]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LaboratoryWorkExecutions'
ALTER TABLE [dbo].[LaboratoryWorkExecutions]
ADD CONSTRAINT [PK_LaboratoryWorkExecutions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Lecturers_Id], [Courses_Id] in table 'LecturerCourse'
ALTER TABLE [dbo].[LecturerCourse]
ADD CONSTRAINT [PK_LecturerCourse]
    PRIMARY KEY CLUSTERED ([Lecturers_Id], [Courses_Id] ASC);
GO

-- Creating primary key on [Students_Id], [Courses_Id] in table 'StudentCourse'
ALTER TABLE [dbo].[StudentCourse]
ADD CONSTRAINT [PK_StudentCourse]
    PRIMARY KEY CLUSTERED ([Students_Id], [Courses_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Lecturers_Id] in table 'LecturerCourse'
ALTER TABLE [dbo].[LecturerCourse]
ADD CONSTRAINT [FK_LecturerCourse_Lecturer]
    FOREIGN KEY ([Lecturers_Id])
    REFERENCES [dbo].[Lecturers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Courses_Id] in table 'LecturerCourse'
ALTER TABLE [dbo].[LecturerCourse]
ADD CONSTRAINT [FK_LecturerCourse_Course]
    FOREIGN KEY ([Courses_Id])
    REFERENCES [dbo].[Courses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LecturerCourse_Course'
CREATE INDEX [IX_FK_LecturerCourse_Course]
ON [dbo].[LecturerCourse]
    ([Courses_Id]);
GO

-- Creating foreign key on [Course_Id] in table 'LaboratoryWorks'
ALTER TABLE [dbo].[LaboratoryWorks]
ADD CONSTRAINT [FK_LaboratoryWorkCourse]
    FOREIGN KEY ([Course_Id])
    REFERENCES [dbo].[Courses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LaboratoryWorkCourse'
CREATE INDEX [IX_FK_LaboratoryWorkCourse]
ON [dbo].[LaboratoryWorks]
    ([Course_Id]);
GO

-- Creating foreign key on [StudentGroup_Id] in table 'Students'
ALTER TABLE [dbo].[Students]
ADD CONSTRAINT [FK_StudentGroupStudent]
    FOREIGN KEY ([StudentGroup_Id])
    REFERENCES [dbo].[StudentGroups]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StudentGroupStudent'
CREATE INDEX [IX_FK_StudentGroupStudent]
ON [dbo].[Students]
    ([StudentGroup_Id]);
GO

-- Creating foreign key on [Student_Id] in table 'LaboratoryWorkExecutions'
ALTER TABLE [dbo].[LaboratoryWorkExecutions]
ADD CONSTRAINT [FK_StudentLaboratoryWorkExecution]
    FOREIGN KEY ([Student_Id])
    REFERENCES [dbo].[Students]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StudentLaboratoryWorkExecution'
CREATE INDEX [IX_FK_StudentLaboratoryWorkExecution]
ON [dbo].[LaboratoryWorkExecutions]
    ([Student_Id]);
GO

-- Creating foreign key on [LaboratoryWork_Id] in table 'LaboratoryWorkExecutions'
ALTER TABLE [dbo].[LaboratoryWorkExecutions]
ADD CONSTRAINT [FK_LaboratoryWorkLaboratoryWorkExecution]
    FOREIGN KEY ([LaboratoryWork_Id])
    REFERENCES [dbo].[LaboratoryWorks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LaboratoryWorkLaboratoryWorkExecution'
CREATE INDEX [IX_FK_LaboratoryWorkLaboratoryWorkExecution]
ON [dbo].[LaboratoryWorkExecutions]
    ([LaboratoryWork_Id]);
GO

-- Creating foreign key on [Students_Id] in table 'StudentCourse'
ALTER TABLE [dbo].[StudentCourse]
ADD CONSTRAINT [FK_StudentCourse_Student]
    FOREIGN KEY ([Students_Id])
    REFERENCES [dbo].[Students]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Courses_Id] in table 'StudentCourse'
ALTER TABLE [dbo].[StudentCourse]
ADD CONSTRAINT [FK_StudentCourse_Course]
    FOREIGN KEY ([Courses_Id])
    REFERENCES [dbo].[Courses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StudentCourse_Course'
CREATE INDEX [IX_FK_StudentCourse_Course]
ON [dbo].[StudentCourse]
    ([Courses_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------