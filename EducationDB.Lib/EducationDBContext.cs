using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EducationDB.Lib
{
    public partial class EducationDBContext
    {
        //static EducationDBContext() => Database.SetInitializer(new MigrateDatabaseToLatestVersion<>());
        //static EducationDBContext() => Database.SetInitializer(new EducationDBContextInitializer());
    }

    internal class EducationDBContextInitializer :
    //CreateDatabaseIfNotExists<EducationDBContext>
    //DropCreateDatabaseIfModelChanges<EducationDBContext>
    DropCreateDatabaseAlways<EducationDBContext>
    {
        protected override void Seed(EducationDBContext db)
        {
            if (!db.StudentGroups.Any())
            {
                for (int i = 1; i <= 6; i++)
                    db.StudentGroups.AddOrUpdate(
                        new StudentGroup { Name = $"04-{i}07" },
                        new StudentGroup { Name = $"04-{i}06" },
                        new StudentGroup { Name = $"04-{i}08" },
                        new StudentGroup { Name = $"04-{i}15" },
                        new StudentGroup { Name = $"04-{i}01" },
                        new StudentGroup { Name = $"04-{i}03" }
                      );
                db.SaveChanges();
            }

            if (!db.Students.Any())
            {
                var groups = db.StudentGroups.ToArray();
                var rnd = new Random();
                using (var reader = File.OpenText("names2.txt"))
                {
                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine();
                        var components = line.Split(' ');
                        var student = new Student();
                        student.Surname = components[0];
                        student.Name = components[1];
                        student.StudentGroup = rnd.Next(groups);
                        db.Students.Add(student);
                    }
                }

                #region 
                //db.Students.AddOrUpdate(
                //    new Student { Name = "Иван", Surname = "Иванов", StudentGroup = db.StudentGroups.First(g => g.Name == "04-107") },
                //    new Student { Name = "Борис", Surname = "Петров", StudentGroup = db.StudentGroups.First(g => g.Name == "04-207") },
                //    new Student { Name = "Евгений", Surname = "Сидоров", StudentGroup = db.StudentGroups.First(g => g.Name == "04-107") },
                //    new Student { Name = "Олег", Surname = "Ленский", StudentGroup = db.StudentGroups.First(g => g.Name == "04-207") },
                //    new Student { Name = "Тимофей", Surname = "Шумилов", StudentGroup = db.StudentGroups.First(g => g.Name == "04-107") },
                //    new Student { Name = "Борис", Surname = "Казбеков", StudentGroup = db.StudentGroups.First(g => g.Name == "04-307") },
                //    new Student { Name = "Евгений", Surname = "Онегин", StudentGroup = db.StudentGroups.First(g => g.Name == "04-307") },
                //    new Student { Name = "Андрей", Surname = "Петросян", StudentGroup = db.StudentGroups.First(g => g.Name == "04-407") },
                //    new Student { Name = "Павел", Surname = "Иванов", StudentGroup = db.StudentGroups.First(g => g.Name == "04-107") },
                //    new Student { Name = "Сергей", Surname = "Иванов", StudentGroup = db.StudentGroups.First(g => g.Name == "04-407") },
                //    new Student { Name = "Григорий", Surname = "Радомский", StudentGroup = db.StudentGroups.First(g => g.Name == "04-507") },
                //    new Student { Name = "Олег", Surname = "Акинфеев", StudentGroup = db.StudentGroups.First(g => g.Name == "04-607") },
                //    new Student { Name = "Иван", Surname = "Дзюба", StudentGroup = db.StudentGroups.First(g => g.Name == "04-407") },
                //    new Student { Name = "Борис", Surname = "Воскресенский", StudentGroup = db.StudentGroups.First(g => g.Name == "04-207") },
                //    new Student { Name = "Ольга", Surname = "Сидорова", StudentGroup = db.StudentGroups.First(g => g.Name == "04-107") },
                //    new Student { Name = "Инга", Surname = "Шевченко", StudentGroup = db.StudentGroups.First(g => g.Name == "04-307") }
                //    ); 
                #endregion
                db.SaveChanges();
            }

            if (!db.Courses.Any())
            {
                db.Courses.AddOrUpdate(
                    new Course { Name = "РПУ" },
                    new Course { Name = "АФУ" },
                    new Course { Name = "Электродинамика" },
                    new Course { Name = "Введение в специальность" },
                    new Course { Name = "ЭМС" },
                    new Course { Name = "Проектирование ФАР и АФАР" }
                );
                db.SaveChanges();

                var students = db.Students.ToArray();
                var courses = db.Courses.ToArray();
                var rnd = new Random();
                for (int i = 0; i < students.Length; i++)
                {
                    var stud = rnd.Next(students);
                    var crs = rnd.Next(courses);
                    if (stud.Courses.Contains(crs))
                        continue;
                    stud.Courses.Add(crs);

                }
                db.SaveChanges();
            }

            if (!db.Lecturers.Any())
            {
                db.Lecturers.AddOrUpdate(
                    new Lecturer
                    {
                        Name = "Андрей",
                        Surname = "Щербачёв",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "РПУ"),
                        }
                    },
                    new Lecturer
                    {
                        Name = "Олег",
                        Surname = "Терёхин",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "АФУ"),
                            db.Courses.First(c => c.Name == "ЭМС")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Антон",
                        Surname = "Васин",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "РПУ"),
                            db.Courses.First(c => c.Name == "ЭМС")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Павел",
                        Surname = "Шмачинлин",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "АФУ"),
                            db.Courses.First(c => c.Name == "Введение в специальность"),
                            db.Courses.First(c => c.Name == "РПУ")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Александр",
                        Surname = "Гринёв",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "Электродинамика")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Леонид",
                        Surname = "Пономарёв",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "АФУ"),
                            db.Courses.First(c => c.Name == "ЭМС")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Дмитрий",
                        Surname = "Воскресенский",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "АФУ"),
                            db.Courses.First(c => c.Name == "Проектирование ФАР и АФАР")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Елена",
                        Surname = "Добычина",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "РПУ")
                        }
                    },
                    new Lecturer
                    {
                        Name = "Елена",
                        Surname = "Овчинникова",
                        Courses =
                        {
                            db.Courses.First(c => c.Name == "АФУ"),
                            db.Courses.First(c => c.Name == "Электродинамика")
                        }
                    }
                );
                db.SaveChanges();
            }

            if (!db.LaboratoryWorks.Any())
            {
                db.LaboratoryWorks.AddOrUpdate(
                    new LaboratoryWork { Name = "Длинная линия", Course = db.Courses.First(g => g.Name == "АФУ") },
                    new LaboratoryWork { Name = "Симметричный вибратор", Course = db.Courses.First(g => g.Name == "АФУ") },
                    new LaboratoryWork { Name = "Умножитель частоты", Course = db.Courses.First(g => g.Name == "РПУ") },
                    new LaboratoryWork { Name = "Автогенератор", Course = db.Courses.First(g => g.Name == "РПУ") },
                    new LaboratoryWork { Name = "Падение плоской волны на границу раздела двух сред", Course = db.Courses.First(g => g.Name == "Электродинамика") },
                    new LaboratoryWork { Name = "Зеркальная антенна", Course = db.Courses.First(g => g.Name == "АФУ") }
               );
                db.SaveChanges();
            }

            if (!db.LaboratoryWorkExecutions.Any())
            {
                var students = db.Students.ToArray();
                var labs = db.LaboratoryWorks.ToArray();
                var rnd = new Random();
                for (int i = 0; i < students.Length * 5; i++)
                {
                    var stud = rnd.Next(students);
                    var lbw = rnd.Next(labs);
                    if (stud.Courses.Contains(lbw.Course))
                        stud.LaboratoryWorkExecutions.Add(new LaboratoryWorkExecution
                        {
                            Order = rnd.Next(1, 6),
                            LaboratoryWork = lbw
                        });

                }
                db.SaveChanges();
            }
        }
    }
}
