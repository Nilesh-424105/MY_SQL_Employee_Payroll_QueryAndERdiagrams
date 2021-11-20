#UC1: Ability to Create a Payroll Service Database, show database and use database
create database employee_payroll_service;
show databases;
use employee_payroll_service;
SELECT database();
#=========================================================================#
#UC2: Ability to Create Employee Payroll Table
CREATE TABLE employee_payroll (
id int unsigned not null AUTO_INCREMENT,
name varchar(150) not null,
salary double not null,
start date not null,
PRIMARY KEY (id)
);
#=========================================================================#
#UC3: Insert values in employee_payroll table
insert into employee_payroll (name, salary, start) values
('Raj', 1000000.00, '2018-01-03'),
('Terissa', 2000000.00, '2019-11-13'),
('Charlie', 3000000.00, '2020-05-21');
#=========================================================================#
#UC4: Ability to retrieve all employee payroll data
SELECT * from employee_payroll;
#=========================================================================#
#UC5: Ability to retrieve salary data for particular employee
SELECT salary from employee_payroll where name= 'Raj';
SELECT * from employee_payroll
	where start between cast('2018-01-01' as date) and date(now());
#=========================================================================#
# UC6: Ability to add Gender to the Employee Payroll Table
ALTER TABLE employee_payroll add gender char(1) after name;
SELECT * from employee_payroll;
update employee_payroll set gender = 'M' where name = 'Bill';
update employee_payroll set gender = 'M' where name = 'Charlie';
update employee_payroll set gender = 'F' where name = 'Mark';
SELECT * from employee_payroll;
#=========================================================================#
# UC7: Ability to find sum, avg, min, max and number of male and female employees
SELECT gender, sum(salary) from employee_payroll where gender = 'F' group by gender;
SELECT gender, avg(salary) from employee_payroll where gender = 'M' group by gender;
SELECT gender,  min(salary) from employee_payroll where gender = 'M' group by gender;
SELECT gender, max(salary) from employee_payroll where gender = 'F' group by gender;
SELECT count(*) from employee_payroll where gender = 'M' group by gender;
#=========================================================================#
# UC8: Ability to Extend employee_payroll data to store employee information like employee phone, address and Department
ALTER TABLE employee_payroll add phone_number char(12) after name;
ALTER TABLE employee_payroll add address char(150) after phone_number;
ALTER TABLE employee_payroll add department char(150) after address;
SELECT * from employee_payroll;
#=========================================================================#
# UC 9: Ability to extend employee_payroll table to have Basic Pay, Deductions, Taxable pay, Income tax, Net pay
ALTER table employee_payroll add basic_pay char(12) after gender;
ALTER table employee_payroll add deductions double after basic_pay;
ALTER table employee_payroll add taxable_pay double after deductions;
ALTER table employee_payroll add tax double after taxable_pay;
ALTER table employee_payroll add net_pay double after tax;
select * from employee_payroll;
#=========================================================================#
# UC10: Ability to make Terissa as part of Sales and Marketing Department
insert into employee_payroll
(name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) values
('Terisa', 'Marketing', 'F', 3000000.00, 1000000.00, 2000000.00, 500000.00, 1500000.00, '2019-11-13');
insert into employee_payroll
(name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) values
('Terisa', 'Sales', 'F', 3000000.00, 0.00, 0.00, 0.00, 0.00, '2019-11-13');
select * from employee_payroll;
#=========================================================================#
#UC11---- Implement the ER Diagram into Payroll Service DB
describe employee_payroll;
ALTER TABLE employee_payroll 
drop column department,drop column basic_pay, drop column  Deductions,
drop column  Taxable_pay,drop column  Income_tax,drop column  Net_Pay, drop column start;
SELECT * from employee_payroll;
ALTER TABLE employee_payroll
  RENAME TO employee_payroll_details;
SELECT * from employee_payroll_details;
ALTER TABLE employee_payroll_details 
RENAME COLUMN id TO empId;

create table employee_department
(
empId int, 
department_id int,
PRIMARY KEY(empId),
foreign key(empId) references employee_payroll_details(empId),
foreign key(department_id) references department(department_id)
);

create table company
(company_id int not null ,
company_name varchar(150),
PRIMARY KEY(company_id));
insert into company(company_id, company_name) values
(501,'Capgemini'),(404,'Facebbok');
SELECT * from company;

ALTER TABLE employee_payroll_details add company_id int first;
update employee_payroll_details set company_id =501 where eId = 1;
update employee_payroll_details set company_id =501 where eId = 2;
update employee_payroll_details set company_id =501 where eId = 3;
SELECT * from employee_payroll_details;
describe employee_payroll_details;
ALTER TABLE employee_payroll_details add foreign key(company_id) references company(company_id);

CREATE TABLE employee_department
(
empId int unsigned, 
department_id int,
PRIMARY KEY(empId),
foreign key(empId) references employee_payroll_details(empId)
);
describe employee_department;
CREATE TABLE department 
(
department_id int not null auto_increment,
department_name varchar(60) not null,
PRIMARY KEY(department_id)
);
describe department;

drop table department;
insert into department(department_name)values
('Sales'),
('Marketing'),
('Hr');
SELECT * from department;
ALTER TABLE employee_department add foreign key(department_id) references department(department_id);
update employee_department set department_id = 3 where empId = 1;
update employee_department set department_id = 2 where empId = 2;
update employee_department set department_id = 1 where empId = 3;

CREATE TABLE employee_payroll_salary
(
empId int unsigned not null,
basic_pay double,
deductions double default 0,
taxable_pay double default 0,
tax double default 0,
net_pay double default 0
 );
 insert into employee_payroll_salary (empId, basic_pay)values
 (1,400000);
 
 ALTER TABLE employee_payroll_salary add foreign key (empId) references employee_payroll_details (empId);

SELECT * from employee_payroll_details;
update employee_payroll_details set phone_no =7777852369 where empId = 1;
update employee_payroll_details set phone_no =8452365214 where empId = 2;
update employee_payroll_details set phone_no =9852365214 where empId = 3;