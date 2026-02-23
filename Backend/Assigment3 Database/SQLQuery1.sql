create table students (
student_id bigint primary key,
name varchar(32),
email varchar(30) unique,
age int,
join_date date,
active_flag bit default 0
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(30),
    fee DECIMAL(10, 2)
);

DROP TABLE enrollments;


CREATE TABLE enrollments (
    enroll_id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    course_id INT NOT NULL,
    enrollment_timestamp DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    
        FOREIGN KEY (student_id) REFERENCES students(student_id),
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, name, email, age, join_date, active_flag) VALUES
(1000000001, 'Ram Kumar', 'ram.kumar@gmail.com', 20, '2023-06-15', 1),
(1000000002, 'Ravi Teja', 'ravi.teja@gmail.com', 21, '2023-07-10', 1),
(1000000003, 'Sita Devi', 'sita.devi@gmail.com', 19, '2023-08-05', 1),
(1000000004, 'Aman Singh', 'aman.singh@gmail.com', 22, '2022-06-01', 1),
(1000000005, 'Neha Sharma', 'neha.sharma@gmail.com', 20, '2023-01-20', 1),
(1000000006, 'John Paul', 'john.paul@gmail.com', 23, '2022-11-11', 0),
(1000000007, 'Anjali Rao', 'anjali.rao@gmail.com', 21, '2023-02-14', 1),
(1000000008, 'Vikram Patel', 'vikram.patel@gmail.com', 24, '2021-12-09', 1),
(1000000009, 'Kiran Das', 'kiran.das@gmail.com', 19, '2023-09-01', 1),
(1000000010, 'Meena Iyer', 'meena.iyer@gmail.com', 22, '2022-08-18', 0);


INSERT INTO courses (course_id, course_name, fee) VALUES
(201, 'Computer Science', 75000.50),
(202, 'Data Science', 90000.00),
(203, 'Artificial Intelligence', 120000.75),
(204, 'Cyber Security', 85000.25),
(205, 'Cloud Computing', 95000.00);

drop table enrollments;
INSERT INTO enrollments (enroll_id, student_id, course_id, enrollment_timestamp) VALUES
(5000000001, 1000000001, 201, '2023-06-20 10:30:00'),
(5000000002, 1000000001, 202, '2023-06-25 14:15:00'),
(5000000003, 1000000002, 201, '2023-07-12 09:45:00'),
(5000000004, 1000000002, 203, '2023-07-18 16:00:00'),
(5000000005, 1000000003, 202, '2023-08-07 11:20:00'),
(5000000006, 1000000004, 204, '2022-06-05 13:10:00'),
(5000000007, 1000000004, 205, '2022-06-10 15:45:00'),
(5000000008, 1000000005, 201, '2023-01-25 10:00:00'),
(5000000009, 1000000005, 203, '2023-02-01 17:30:00'),
(5000000010, 1000000006, 204, '2022-11-15 12:40:00'),
(5000000011, 1000000007, 202, '2023-02-18 09:10:00'),
(5000000012, 1000000008, 205, '2021-12-15 14:55:00'),
(5000000013, 1000000009, 201, '2023-09-03 11:00:00'),
(5000000014, 1000000009, 202, '2023-09-05 16:20:00'),
(5000000015, 1000000010, 203, '2022-08-20 10:35:00');


select * from enrollments;
select * from students;
select * from courses;

ALTER TABLE students
ALTER COLUMN email varchar(50);

ALTER TABLE courses
ALTER COLUMN fee decimal(10,2);

alter table enrollments
alter column enrollment_timestamp datetime2 default sysdatetime();


insert into students (student_id, name, email, age, join_date, active_flag) values 
(1000000011, 'Jaisimha K', 'jaisimha.kothari@innovatechs.com', 20, '2022-12-01', 1 ),
(1000000012, 'Preetham Adepu', 'preetham.adepu@innovatechs.com', 23, '2021-12-08', 0),
(1000000013, 'Sushanth', 'sushanth.das@innovatechs.com', 21, '2023-09-11', 1);


INSERT INTO courses (course_id, course_name, fee) VALUES
(206, 'Machine Learning', 750000.50);

INSERT INTO enrollments (enroll_id, student_id, course_id, enrollment_timestamp) VALUES
(5000000016, 1000000011, 206, '2023-06-20 10:30:00'),
(5000000017, 1000000012, 206, '2023-06-25 14:15:00'),
(5000000018, 1000000013, 206, '2023-07-12 09:45:00');

Exec sp_rename 'students.name','names','column';

Exec sp_rename 'students.age','ages','column';

select * from students;

update students set active_flag = 0 where email like '%@gmail.com';

update students set registration_date = GETDATE() , active_flag = 1, phone_number = '9618690117'  where ages > 20; 


select count(ages) as no_of_times_repeating, ages from students group by ages having count(ages)>1; 

select max(ages) from students where ages < (select max(ages) from students where ages < (select max(ages) from students));

with ages_filter as(
	select names, ages , dense_rank() over (order by ages desc) as rn
	from students
)


select names,ages from ages_filter where rn = 3; 

select * from students order by age desc;

select top 5 * from students order by join_date desc;

select distinct(ages) from students order by ages desc;

select distinct(course_name) from courses;

update students set age=25 where age=21;
update students set age=21 where age=25;

update students set active_flag = 0 where age=20;

select * from enrollments;


update courses set fee = fee + (fee * (0.1));

delete from students where student_id = 1000000001; 

INSERT INTO students VALUES
(1000000001, 'Ram Kumar', 'ram.kumar@gmail.com', 20, '2023-06-15', 1);

delete from courses where fee<=1000;
truncate table enrollments;
delete from enrollments where [enrollment_timestamp] < '2023-06-21';

alter table students
alter column name varchar(40);

EXEC sp_rename 'students.join_date', 'registration_date', 'COLUMN';


select * from students where age<21;

select * from students where active_flag = 1;

select * from courses where fee>50000 and fee<100000;

select * from students where age in (20,22,25);


select * from students where age>21 and active_flag=1;
select * from students where age<20 and active_flag=1;

select * from courses where fee>50000 and course_name like '%DATA%';

select * from students where email like  '%gmail.com';

select * from courses where course_name like '%DATA%';

select * from students where name like '%k%';

INSERT INTO students VALUES
(1000000001, 'Ram Kumar', 'ram.kumar@gmail.com', null ,'2023-06-15', 1);

select * from students where age is null;

select * from students where age is not null;


select count(*) as total_students from students;


select count(*) as total_students from students where active_flag=1;

select sum(fee) as Total_fees_sum, round(avg(fee),2) as avg_fee, count(*) as course_fees from courses where fee > 20000;

select min(age) as minimun_age, max(age) as maximum_age from students;

select top 1* from students order by registration_date desc;


select top 1* from students order by registration_date;

select count(*) as active_members from students group by active_flag having active_flag=1;

select count(*) as age_20_members from students group by age having age=20;


select * from enrollments;

SELECT SUM(c.fee) AS Total_fee_per_course, c.course_name,c.course_id FROM enrollments e JOIN courses c ON e.course_id = c.course_id GROUP BY c.course_name, c.course_id;

select course_id, count(course_id) as no_of_enrollments from enrollments group by course_id having count(course_id)>=3;

select avg(s.age) as Avg_of_students_enrolled_in_each_course, e.course_id from enrollments e join students s on s.student_id=e.student_id join courses c on c.course_id = e.course_id  group by e.course_id having avg(s.age)>21; 

select course_id,count(course_id) as no_of_enrollments from enrollments group by course_id having count(course_id) > 2;


select * from students where age>20  order by age desc;

select count(*) from (select * from students where name like '%a%') as new_table;

(select * from courses where fee>50000) 
intersect 
(select * from courses where fee<100000) 
order by fee;

select * from students where age is not null and 
student_id in (select student_id from students where active_flag = 1);

select course_id ,count(course_id) from enrollments group by course_id having count(course_id) > 1;

