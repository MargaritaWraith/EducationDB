using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EducationDB.Lib;
using Console = System.Console;

namespace EducationDB.TestConsole
{
    class Program
    {
        class StudentInfo
        {
            public string Surname { get; set; }
            public string Name { get; set; }
            public int Order { get; set; }

            public string LaboratoryWork { get; set; }

            public string Course { get; set; }
        }

        static void Main(string[] args)
        {
            using (var db = new Lib.EducationDBContext())
            {
                //Console.WriteLine(db.Students.Count());
                db.Database.Log = Console.WriteLine;
                Console.WriteLine("---------------------------");
                Console.Clear();
                Console.WriteLine("==========================");

                var larionov_works = db.Database
                    .SqlQuery<StudentInfo>("[dbo].[GetStudLabResults] @surname", 
                        new SqlParameter("@surname", "Ларионов"));

                foreach (var student in larionov_works)
                {
                    Console.WriteLine("{0} {1}", student.Name, student.Surname);
                }

                foreach (var student in db.Students.Where( s=>s.LaboratoryWorkExecutions.Any()))
                {
                    Console.WriteLine(student.Surname + " " + student.Name);
                }

                Console.ReadLine();

                //var lecturers = db.Lecturers.Where(l => l.Courses.Count > 1).Select(l => l.Surname).ToArray();
                //var lecturers = from lecturer in db.Lecturers
                //                where lecturer.Courses.Count() > 1
                //                select lecturer.Surname;


                //foreach (var lecturer in lecturers)
                //{
                //    Console.WriteLine(lecturer);
                //}

                //Console.WriteLine("Students count: {0}", db.Students.Count());

                //var lecturers2 = db.Database.SqlQuery<Lecturer>("SELECT * FROM Lecturers").ToArrayAsync().Result;

                //var bad_teachers = from lecturer in db.Lecturers
                //                   let courses_average_orders = from course in lecturer.Courses
                //                                                select course.LaboratoryWorks
                //                   select lecturer;
                //Console.WriteLine(db.Students.First(s => s.Surname == "Ларионов").LaboratoryWorkExecutions.Average(s => s.Order));

                //foreach (var student in db.Students.Where(s=>s.LaboratoryWorkExecutions.Average(l=>l.Order)>4))
                //{
                //    Console.WriteLine(student.Surname);
                //}



            }

            Console.ReadLine();
        }
    }
}
