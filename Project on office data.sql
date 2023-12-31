select * from employee;

CREATE TABLE branch(
branch_id INT PRIMARY KEY ,
branch_name VARCHAR(20),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL 
);


ALTER TABLE employee
ADD FOREIGN KEY (branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL; 

ALTER TABLE employee 
ADD FOREIGN KEY (super_id)
REFERENCES employee (emp_id)
ON DELETE SET NULL;

DESCRIBE employee;

 CREATE TABLE client(
     client_id INT PRIMARY KEY,
     client_name VARCHAR(20),
     branch_id INT,
     FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
 );

 DESCRIBE client;

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE ,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
 );

 CREATE TABLE branch_supplier (
     branch_id  INT,
     supplier_id VARCHAR(40),
     supply_type VARCHAR(40),
     PRIMARY KEY (branch_id,supplier_id),
     FOREIGN KEY (branch_id) REFERENCES branch (branch_id) ON DELETE CASCADE

 );

 INSERT INTO employee VALUES(100,'David','Wallace','1967-11-17','M',250000,NULL,Null);
 INSERT INTO branch VALUES (1,'Corporate',100,'2006-02-09');
UPDATE employee 
SET branch_id=1
WHERE emp_id = 100;
INSERT INTO employee VALUES (101,'Jan','Levinson','1961-05-11','F',110000,100,1);

INSERT INTO employee VALUES (102,'Michael','Scott','1964-06-15','M',75000,100,NULL);
INSERT INTO branch VALUES(2,'Scarnton',102,'1992-04-06');
UPDATE employee 
SET branch_id = 2 
WHERE emp_id= 102;
INSERT INTO employee VALUES(103,'Angela',' Martin','1971-06-25','F',63000,102,2);
INSERT INTO employee VALUES(104,'Kelly',' Kapoor','1980-02-05','F',55000,102,2);
INSERT INTO employee VALUES(105,'Stanley',' Hudson','1958-02-19','M',69000,102,2);

DESCRIBE employee;
SELECT * FROM employee;

INSERT INTO employee VALUES(106,'Josh','Porter','1969-09-05','M',78000,100,NULL);
INSERT INTO branch VALUES(3,'Stamford',106,'1998-04-06');
UPDATE employee 
SET branch_id = 3
WHERE emp_id = 106;
INSERT INTO branch VALUES(3,'Stamford',106,'1998-04-06');
INSERT INTO employee VALUES(107,'Andy','Bernard','1973-07-22','M',65000,106,3);
INSERT INTO employee VALUES(108,'Jim','Halpert','1978-10-01','M',71000,106,3);

INSERT INTO client VALUES(400,'Dunmore Highschool',2);
INSERT INTO client VALUES(401,'Lackawana Country',2);
INSERT INTO client VALUES(402,'FedEx',3);
INSERT INTO client VALUES(403,'John Daly Law,LLC',3);
INSERT INTO client VALUES(404,'Scranton Whitepages',2);
INSERT INTO client VALUES(405,'Times Newspaper',3);
INSERT INTO client VALUES(406,'FedEx',2);


INSERT INTO works_with VALUES(105,400,55000);
INSERT INTO works_with VALUES(102,401,267000);
INSERT INTO works_with VALUES(108,402,22500);
INSERT INTO works_with VALUES(107,403,5000);
INSERT INTO works_with VALUES(108,403,12000);
INSERT INTO works_with VALUES(105,404,33000);
INSERT INTO works_with VALUES(107,405,26000);
INSERT INTO works_with VALUES(102,406,15000);
INSERT INTO works_with VALUES(105,406,130000);

INSERT INTO branch_supplier VALUES(2,'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(2,'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3,'Patriot','Paper');
INSERT INTO branch_supplier VALUES(2,'J.T. Forms & Lables','Customs Forms');
INSERT INTO branch_supplier VALUES(3,'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3,'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(3,'Stamford Lables','Customs Form');

SELECT * FROM branch_supplier;

SELECT * 
FROM client 
WHERE client_name LIKE '%LLC';

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

--Find any employee born in Octuber
SELECT * FROM employee
WHERE birth_date LIKE '____-10%';

--NESTED QUESRY
-- Find names of all employees who have sold over 30000 to a single client 

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
FROM works_with
WHERE works_with.total_sales > 30000
);

