Create database Bank
---A. First create tables with primary key*/
---1. Create userlogin table*/
create table UserLogins
(UserLoginID smallint not null, 
UserLogin varchar(15) not null,
UserPassord varchar(20) not null,
constraint pk_UL_UserLoginID primary key(UserLoginID));

--2. Create security Question Table*/
create table UserSecurityQuestions
( UserSecurityQuestionsID tinyint not null,
UserSecurityQuestion varchar(50) not null
Constraint Pk_USQ_UserSecurityQuestionsID primary key(UserSecurityQuestionsID));

---3. Create AccountType table*/
create table AccountType
( AccountTypeID tinyint not null,
AccountTypeDescription varchar(50) not null,
Constraint PK_AT_AccountTypeID primary key(AccountTypeID));

---4. Create SavingsIntersetRates Table*/
create table SavingsInterestRates
( InterestSavingsRateID tinyint not null,
IntersetRateValue numeric(9,9) not null,
InterestRateDescription varchar(20) not null,
constraint Pk_ISR_InterestSavingsRateID primary key(InterestSavingsRateID));

---5. Create AccountStatusType Table*/
create table AccountStatusType
( AccountStatusTypeID tinyint not null,
AccountStatusDescription varchar(30) not null,
constraint Pk_AST_AccountStatusTypeID primary key(AccountStatusTypeID));

--6. Create FailedTransactionErrorType table*/
create table FailedTransactionErrorType
(FailedTransactionErrorTypeID tinyint not null,
FailedTransactionDescription varchar(50) not null,
constraint Pk_FTET_FailedTransactionErrorTypeID primary key(FailedTransactionErrorTypeID));

---7. create LoginErrorLog table*/
Create table LoginErrorLog
( ErrorLogID tinyint not null,
ErrorTime datetime not null,
FailedTransactionXML xml not null,
constraint Pk_EL_ErrorLogID primary key(ErrorLogID));

---8. Create EmployeeTable*/
create table Employee
( EmployeeID int not null,
EmployeeFirstName varchar(25) not null,
EmployeeMiddleInitial char(1) not null,
EmployeeLastName varchar(25) not null,
EmployeeisManager bit not null,
constraint Pk_E_EmployeeID primary key(EmployeeID));

---9. Create TransactionType table */
create table TransactionType
(TransactionTypeID tinyint not null,
TransactionTypeName char(10) not null,
TransactionTypedescription varchar(50) not null,
transactionFeeAmount smallmoney not null,
Constraint Pk_TT_TransactionTypeID primary key(TransactionTypeID));

--B. Create Tables with combination of primary and foreign key

--1. Create  FailedTransactionLog table*/
create table  FailedTransactionLog
( FailedTransactionID int not null,
FailedTransactionErrorTypeID tinyint not null,
FailedTransactionerrorTime datetime not null,
FailedTransactionXML xml not null,
constraint Pk_FT_FailedTransactionID primary key(FailedTransactionID),
constraint fk_FTET_FailedTransactionErrorTypeID foreign key(FailedTransactionErrorTypeID) references FailedTransactionErrorType(FailedTransactionErrorTypeID));

---2. Create UserSecurityAnswers table*/

create table UserSecurityAnswers
( UserLoginID smallint not null,
UserSecurityAnswer varchar(25) not null,
UserSecurityQuestionID tinyint not null,
constraint Pk_USA_UserLoginID primary key(UserLoginID),
constraint Fk_UL_UserLoginID foreign key(UserLoginID) references UserLogins(UserLoginID),
constraint Fk_USQ_UserSecurityQuestionID foreign key(UserSecurityQuestionID) references UserSecurityQuestions(UserSecurityQuestionsID));

--3. Create Account table */

Create table Account
(AccountID int not null,
CurrentBalance int not null,
AccountTypeID tinyint not null,
AccountStatusTypeID tinyint not null,
IntersetSavingsRateID tinyint not null,
constraint Pk_A_AccountID primary key(AccountID),
constraint Fk_AT_AccountTypeID foreign key(AccountTypeID) references AccountType(AccountTypeID),
constraint Fk_ISR_IntersetSavingsRateID foreign key(IntersetSavingsRateID) references SavingsInterestRates(InterestSavingsRateID),
constraint Fk_AST_AccountStatusTypeID foreign key(AccountStatusTypeID) references AccountStatusType(AccountStatusTypeID));

--4. create LoginAccount table*/

create table LoginAccount
(UserLoginID smallint not null,
AccountID int not null,
constraint Fk_UL_UserLogins foreign key(UserLoginID) references UserLogins(UserLoginID),
constraint Fk_A_AccountID foreign key(AccountID) references Account(AccountID));

--5. create Customer Table*/

drop table customer 
create table Customer
( CustomerID int not null,
AccountID int not null,
CustomerAddress1 varchar(30) not null,
CustomerAddress2  varchar(30),
CustomerFirstName  varchar(30) not null,
CustomerMiddleInitial char(1),
CustomerLastName  varchar(30) not null,
City  varchar(20) not null,
State char(2) not null,
ZipCode char(10) not null,
EmailAddress char(40) not null,
HomePhone char(10) not null,
CellPhone varchar(10) not null,
WorkPhone VARCHAR(10) not null,
SSN varchar(9),
UserLoginID smallint not null,
constraint Pk_C_CustomerID primary key(CustomerID),
constraint Fk_CUL_UserLoginID foreign key (UserloginID) references UserLogins(UserLoginID));
select * from customer
---6. Create CustomerAccount Table*/

drop table customeraccount 
Create table CustomerAccount
(AccountID int not null,
CustomerID int not null,
constraint Fk_CA_AccountID foreign key(AccountID) references Account(AccountID),
constraint Fk_CC_CustomerID foreign key(CustomerID) references Customer(CustomerID));

select * from customeraccount 

---7. create TransactionLog Table*/
create table TransactionLog
(TransactionID int not null,
TransactionDate datetime not null,
TransactionTypeID tinyint not null,
TransactionAmount Money not null,
NewBalance Money not null,
AccountID int not null,
CustomerID int not null,
EmployeeID int not null,
UserLoginID smallint not null,
constraint Pk_TL_TransactionID primary key (TransactionID),
constraint Fk_TT_TL_TransactionTypeID foreign key (TransactionTypeID) references TransactionType(TransactionTypeID),
constraint  Fk_A_TL_AccountID foreign key (AccountID) references Account(AccountID),
constraint Fk_C_TL_CustomerID foreign key (CustomerID) references Customer(CustomerID),
constraint Fk_E_TL_EmployeeID foreign key (EmployeeID) references Employee(EmployeeID),
constraint Fk_UL_TL_UserLoginID foreign key (UserLoginID) references UserLogins(UserLoginID));

---8. create OverdraftLog table 
create table OverDraftLog
(AccountID int not null,
OverDraftDate datetime not null,
OverDraftAmount Money not null,
OverDraftTransactionXML XML not null,
constraint Pk_ODL_AccountID primary key (AccountID),
Constraint Fk_A_ODL_AccountID foreign key (AccountID) references Account(AccountID));


---C. Insert five lines in each table 

--1. Insert userlogin values*?
insert userlogins values('1001','101','pass1');
insert userlogins values('1002','102','pass2');
insert userlogins values('1003','103','pass3');
insert userlogins values('1004','104','pass4');
insert userlogins values('1005','105','pass5');
select * from userlogins
update UserLogins
set Userpassord = 201919
where UserLoginID = 1001
Go
--2. Insert Security Questions Values
insert into UserSecurityQuestions Values(1, 'What is your favoriate vehicle brand?');
insert into UserSecurityQuestions Values(2, 'What is your favoriate vehicle brand?');
insert into UserSecurityQuestions Values(3, 'What is your favoriate vehicle brand?');
insert into UserSecurityQuestions Values(4, 'What is your favoriate vehicle brand?');
insert into UserSecurityQuestions Values(5, 'What is your favoriate vehicle brand?');
Select * from UserSecurityQuestions
Go

---3. Insert AccountType values

insert into AccountType values(1,'saving');
insert into AccountType values(2,'saving');
insert into AccountType values(3,'checking');
insert into AccountType values(4,'checking');
insert into AccountType values(5,'saving');
select * from AccountType
Go

---4. Insert Savings Interest rates Values
insert SavingsInterestRates values(1,'700','Four years');
insert SavingsInterestRates values(2,'900','Five years');
insert SavingsInterestRates values(3,'1300','Six years');
insert SavingsInterestRates values(4,'900',' Five years');
insert SavingsInterestRates values(5,'1200','eight years');
select *from SavingsInterestRates
go
update SavingsInterestRates 
set IntersetRateValue = 1.25
where Intersetratevalue =1200
  
Go
--5. Insert Account status Type values
insert into AccountStatusType values(1,'Active');
insert into AccountStatusType values(2,'Active');
insert into AccountStatusType values(3,'Closed');
insert into AccountStatusType values(4,'Active');
insert into AccountStatusType values(5,'Dormant');
select * from AccountStatusType 
Go

--6. Insert failed Transaction Error values
insert into failedtransactionerrortype values(1,'daily withdrawal limit');
insert into failedtransactionerrortype values(2,'Transaction Pending');
insert into failedtransactionerrortype values(3,'Above balance limit');
insert into failedtransactionerrortype values(4,' Machine down');
insert into failedtransactionerrortype values(5,'Invalid Card');
select * from failedtransactionerrortype
Go

---7. Insert LoginErrorLog table values
 
 insert into LoginErrorLog values(1,'2021/05/20 01:40:40', 'poor server connection');
 insert into LoginErrorLog values(2,'2020/01/20 03:10:10', 'machine down');
 insert into LoginErrorLog values(3,'2019/04/12 08:10:10', 'Failed servise');
 insert into LoginErrorLog values(4,'2018/01/02 04:15:03', 'Wrong password');
 insert into LoginErrorLog values(5,'2017/07/02 10:15:13', 'card not working');
 update loginerrorlog
 set ErrorTime = '2022/1/5 4:20:15'
 where ErrorLogID=1
 select * from LoginErrorLog 
 Go

 --8. Insert employee table values

 insert into Employee values(11,'Eshetu', 'R','Worku','0');
 insert into Employee values(12,'Solomon', 'T','Asresee','1');
 insert into Employee values(13,'Nati', 'T','Debe','0');
 insert into Employee values(14,'Tigist', 'D','Abe','1');
 insert into Employee values(15,'Seyoum', 'T','Esrael','1');
 select  * from employee  
 Go

 ---9. Insert TransactionType Values

 insert into transactiontype values(101,'Deposit', 'see amount', '400');
 insert into transactiontype values(102,'Transfer', 'Transfer Amount', '250');
 insert into transactiontype values(103,'EDeposit', 'Amount', '600');
 insert into transactiontype values(104,'Paid', 'Natan', '1200');
 insert into transactiontype values(105,'Checking balance', 'Available Fund', '1600');
 select * from transactiontype
 Go

 --10. Insert FailedTransactionLog table value

insert FailedTransactionLog values(101,1,'2021/05/20 01:40:40', 'Fifth');
insert FailedTransactionLog values(102,2,'2020/10/10 04:30:50', 'Forth');
insert FailedTransactionLog values(103,3,'2018/03/12 01:05:20', 'Third');
insert FailedTransactionLog values(104,4,'2018/01/02 04:15:03', 'Second');
insert FailedTransactionLog values(105,5,'2017/07/02 10:15:13','First');
Select * from FailedTransactionLog
Go
--11. insert UserSecurityAnswers table values
insert into UserSecurityAnswers values(1001,'Acura','1');
insert into UserSecurityAnswers values(1002,'Alpha','2');
insert into UserSecurityAnswers values(1003,'Aston','3');
insert into UserSecurityAnswers values(1004,'Audi','4');
insert into UserSecurityAnswers values(1005,'Bently','5');
select * from UserSecurityAnswers
Go

--12. Insert Account table values

insert into Account values(111,'4300','1','1','1');
insert into Account values(112,'6000','2','2','2');
insert into Account values(113,'3500','3','3','3');
insert into Account values(114,'4000','4','4','4');
insert into  Account values(115,'5500','5','5','5');
select * from Account 
Go
update Account
set CurrentBalance =1600
where AccountID = 115

---13. Insert  Customer Table values
  
insert into Customer values(21,'111', 'Address1', 'Address2', 'Eshetu', 'R', 'Worku', 'Ottawa', 'ON', '3A5z9z', 'user5@user.com', '141655555',   '453554464',   '3462325',  'A12345',  '1001');
insert into Customer values(22, '112','Address1', 'Address2', 'Solomon','T','Asresee','Hamilton', 'ON','fe3453', 'user6@user.com','141655555', '567435345', '6332423', 'D34353', '1002');
insert into Customer values(23, '113','Address1', 'Address2', 'Nati', 'T', 'Debe', 'Vacouver', 'BC', 'fdf45', 'user7@user.com', '141655555',    '681316226',       '9202521','J56361', '1003');
insert into Customer values(24, '114','Address1', 'Address2', 'Tigist', 'D', 'Abe', 'London', 'ON', '23ffbfs', 'user8@user.com', '141655555',   '795197107',     '8674252',   'I78369',    '1004');
insert into Customer values(25, '115','Address1', 'Address2', 'Seyoum5', 'T', 'Esreal','Calgary','AB', 'hg4536', 'user9@user.com', '141655555', '909077988', '9209371',   'K10377',    '1005');
select * from customer 
Go
 --14. Insert LoginAccount table values

 insert into loginAccount values(1001,111);
insert into loginAccount values(1002, 112);
insert into loginAccount values(1003, 113);
insert into loginAccount values(1004, 114);
insert into loginAccount values(1005, 115);
select * from loginaccount
Go


--15. Insert CustomerAccount Table
 insert into CustomerAccount values(111, 21);
insert into CustomerAccount values(112, 22);
insert into CustomerAccount values(113, 23);
insert into CustomerAccount values(114, 24);
insert into CustomerAccount values(115, 25);
select * from customeraccount
Go

--16. Insert OverDrfat Table values

insert into OverDraftLog values(111,'2021/05/20 01:40:40','250', 'Clear');
insert into OverDraftLog values(112, '2020/6/9 12:34:57', '1500', 'Pending');
insert into OverDraftLog values(113, '2019/4/5 02:14:00', '300', 'Clear');
insert into OverDraftLog values(114,'2018/7/5 05:56:59', '2500', 'Pending');
insert into OverDraftLog values(115,'2017/10/12 08:34:15', '400', 'Clear');
select * from overdraftlog
Go

---17. Insert Transaction Log Values

insert into TransactionLog values(31,'2021/05/20 01:40:40','101','5400','1100', '111','21','11','1001');
insert into TransactionLog values(32,'2020/6/9 12:34:57', '102','6650','1150','112','22','12','1002');
insert into TransactionLog values(33,'2019/4/5 02:14:00', '103','5400','1900','113','23','13', '1003');
insert into TransactionLog values(34,'2018/7/5 05:56:59', '104','3700','2100','114','24','14','1004');
insert into TransactionLog values(35,'2017/10/12 08:34:15','105','6600','1600','115','25','15','1005');
select * from Transactionlog
Go
    ---3. create view
	---1. Create a view to get all customers with checking account from ON province
	 
 Create view VcustomerON
as
select  CustomerFirstName,CustomerLastName,State,accounttypedescription
from Customer c 
  join CustomerAccount ca 
   on C.CustomerID=ca.CustomerID
   join Account a
   on ca.AccountID=a.AccountID
   join AccountType at
   on a.AccountTypeID=at.AccountTypeID
where state='ON' and AccountTypeDescription='Checking'
go 
select * from VcustomerON limit 
go
 
---2.Create a view to get all customers with total account balance (including interest rate) greater than 5000
  
  go
   create view VCustomer_ON   
   as
select c.CustomerFirstName, SUM(a.CurrentBalance) AS Ac_Balance, SUM(a.CurrentBalance + 
(a.CurrentBalance * IntersetRateValue)/100) AS Total_Ac_Balance 
from Customer c
join Account a
on c.AccountID = a.AccountId
join SavingsInterestRates s
on s.InterestSavingsRateID = s.InterestSavingsRateID 
group by c.CustomerFirstName
having SUM(a.CurrentBalance + (a.CurrentBalance * IntersetRatevalue)/100) > 5000; 
go
   
   select * from VCustomer_ON
   go
    
   ---3.	Create a view to get counts of checking and savings accounts by customer
   
 create view customerac 
as
select c.CustomerFirstName, at.AccountTypeDescription, count(*) as Total_AC_Types from Customer c
join Account a
on c.AccountID = a.AccountId
join AccountType at
on a.AccountTypeID = at.AccountTypeID
group by c.CustomerFirstName, at.AccountTypeDescription;
go 
select * from customerac 
   
-----4.	Create a view to get any particular user’s login and password using AccountId
go
 create view VAccountON  
as
select   ul.UserLogin, ul.UserPassord
from UserLogins ul
join LoginAccount la
on ul.UserLoginID = la.UserLoginID
--joi Account a
--on la.AccountID = a.AccountID;
where la.AccountID = '111'
GO;
select * from VAccountON  

-----5.	Create a view to get all customers’ overdraft amount
GO
 create view VcustomerOD
as
select distinct c.CustomerFirstName, o.OverDraftAmount
from overDraftLog o
join customer c
on o.AccountID = c.AccountID;
go
select * from VcustomerOD
go

 ----6.	Create a stored procedure to add “User_” as a prefix to everyone’s login (username)
 go
 create proc spUpdate_Login 
as
update UserLogins
set UserLogin = Concat("User_", UserLogin); 
go
exec sp_Update_Login;
go
select * from userlogins 

----7.	Create a stored procedure that accepts AccountId as a parameter and returns customer’s full name
 
go
create proc spCustomer_Details @AccountID int
as
select c.CustomerFirstName + ' ' + c.CustomerMIddleInitial + ' ' + c.CustomerLastName as Customer_Full_Name
from Customer c
join Account a
on c.AccountID = a.AccountId
where a.AccountID = @accountid
go

exec spCustomer_details 112  
go

----8.	Create a stored procedure that returns error logs inserted in the last 24 hours
go
create proc sploginErrors_24
as
select * from LoginErrorLog
where  ErrorTime between DATEADD(hh, -24, GETDATE()) and GETDATE();
go
exec sploginErrors_24;
go
select * from  sploginErrors_24  
go
---9.Create a stored procedure that takes a deposit as a parameter and updates CurrentBalance value for that particular account
drop proc spcurrent_balance 
go
  create proc spcurrent_balance 
 @accountid int,
 @deposit int
 as
 begin
 select totalbalance =(currentbalance+@deposit) from Account
 where AccountID=@accountid
 end
 execute spcurrent_balance @accountid =111,@deposit =400 
 

 ---10.	Create a stored procedure that takes a withdrawal amount as a parameter and updates 
 go
 create proc spUpdate_AfterWithdraw 
 @AccountID int, 
 @Withdraw int
as
UPDATE Account
set CurrentBalance = CurrentBalance - @Withdraw
where AccountID = '114'
go

exec spUpdate_AfterWithdraw 114, 1200;
