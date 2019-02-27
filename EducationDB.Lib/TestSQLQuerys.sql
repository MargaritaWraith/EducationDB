----вывести фамилии лекторов и соответствующие названия курсов из таблиц (Лекторы объединённые с курсами) и отсортировать по фамилиям лекторов 
--SELECT Lecturers.Surname, Courses.Name 
--FROM Lecturers 
--JOIN LecturerCourse
--ON Lecturers.Id = LecturerCourse.Lecturers_Id
--JOIN Courses
--ON LecturerCourse.Courses_Id = Courses.Id
--ORDER BY Lecturers.Surname;

--/* Вывести Фамилии лекторов, названия их курсов, фамилии и имена студентов с оценками по курсу и названием лабораторной работы */
--SELECT Lecturers.Surname, Courses.Name, Students.Surname, Students.Name, LaboratoryWorkExecutions.[Order], LaboratoryWorks.Name
--FROM Lecturers 
--JOIN LecturerCourse
--ON Lecturers.Id = LecturerCourse.Lecturers_Id
--JOIN Courses
--ON LecturerCourse.Courses_Id = Courses.Id
--JOIN LaboratoryWorks
--ON Courses.Id = LaboratoryWorks.Course_Id
--JOIN LaboratoryWorkExecutions
--ON LaboratoryWorks.Id = LaboratoryWorkExecutions.LaboratoryWork_Id
--JOIN Students
--ON LaboratoryWorkExecutions.Student_Id = Students.Id;

--/* Вывести фамилии и имена студентов с оценкой по лабораторной работе курса  */
--SELECT Students.Surname, Students.Name, [Order], LaboratoryWorks.Name, Courses.Name
--FROM Students
--JOIN LaboratoryWorkExecutions
--ON LaboratoryWorkExecutions.Student_Id = Students.Id
--JOIN LaboratoryWorks
--ON LaboratoryWorks.Id = LaboratoryWorkExecutions.LaboratoryWork_Id
--JOIN Courses
--ON Courses.Id = LaboratoryWorks.Course_Id
--WHERE Surname LIKE N'Ларионов'; --где фамилия студента Ларионов


--/* Вывести средний балл (AVG) в формате с плавающей точкой CAST([Order] AS FLOAT */
--SELECT AVG(CAST([Order] AS FLOAT)) -- Order экранируется [], так это системное слово
--FROM Students
--JOIN LaboratoryWorkExecutions
--ON LaboratoryWorkExecutions.Student_Id = Students.Id
--JOIN LaboratoryWorks
--ON LaboratoryWorks.Id = LaboratoryWorkExecutions.LaboratoryWork_Id
--JOIN Courses
--ON Courses.Id = LaboratoryWorks.Course_Id
--WHERE Students.Surname LIKE N'Ларионов'; 


--/* Вывести средний балл (AVG) в формате с плавающей точкой CAST([Order] AS FLOAT */
SELECT Students.Surname, AVG(CAST([Order] AS FLOAT)) -- Order экранируется [], так это системное слово
FROM Students
JOIN LaboratoryWorkExecutions
ON LaboratoryWorkExecutions.Student_Id = Students.Id
JOIN LaboratoryWorks
ON LaboratoryWorks.Id = LaboratoryWorkExecutions.LaboratoryWork_Id
JOIN Courses
ON Courses.Id = LaboratoryWorks.Course_Id
GROUP BY Students.Surname;


SELECT Courses.Name, AVG(CAST([Order] AS FLOAT)) -- Order экранируется [], так это системное слово
FROM Students
JOIN LaboratoryWorkExecutions
ON LaboratoryWorkExecutions.Student_Id = Students.Id
JOIN LaboratoryWorks
ON LaboratoryWorks.Id = LaboratoryWorkExecutions.LaboratoryWork_Id
JOIN Courses
ON Courses.Id = LaboratoryWorks.Course_Id
GROUP BY Courses.Name;


SELECT  StudentGroups.Name, Students.Surname
FROM Students
JOIN StudentGroups
ON Students.StudentGroup_Id = StudentGroups.Id
WHERE StudentGroups.Name IN('04-307', '04-206')
ORDER BY StudentGroups.Name;

SELECT Students.Surname, Students.Name
FROM Students

ORDER BY Surname;