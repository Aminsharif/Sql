create database HospitalOPDManagement
go
use HospitalOPDManagement
go
create table Patient
(
	Patient_id int identity (1,1) primary key,
	Patient_Name varchar(50),
	Gender varchar(10),
	[Address] nvarchar(1000),
	Contact_no varchar(20),
	Doctor_code int references Doctor(Doctor_code)
)

go
create proc spInsert_Patient    @Patient_Name varchar(50),
								@Gender varchar(10),
								@Address nvarchar(1000),
								@Contact_no varchar(20),
								@Doctor_code int
as
begin try
	insert into Patient values(@Patient_Name ,@Gender ,@Address ,@Contact_no ,@Doctor_code)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
go
create proc spUpdate_Patient
as
begin
	begin try
		begin transaction
			declare @Doctor_code int, @Patient_id int
			update Patient set Doctor_code= @Doctor_code where Patient_id=@Patient_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
go
create proc spDelete_Patient
as
begin
	begin try
		begin transaction
			declare @Patient_id int
			delete from Patient where Patient_id=@Patient_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
-----------------------------------------------------------------
go
create table Doctor
(
	Doctor_code int identity (1,1) primary key,
	Doctor_Name varchar(50),
	Doctor_RoomNumber int,
	Gender varchar(10),
	[Address] nvarchar(1000),
	Doctor_Contact_no varchar(20),
	Designation varchar(100)
)
go
create proc spInsert_Doctor     @Doctor_Name varchar(50),
								@Doctor_RoomNumber int,
								@Gender varchar(10),
								@Address nvarchar(1000),
								@Doctor_Contact_no varchar(20),
								@Designation varchar(100)
								
as
begin try
	insert into Doctor values(@Doctor_Name, @Doctor_RoomNumber,@Gender ,@Address,@Doctor_Contact_no ,@Designation)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
go
create proc spUpdate_Doctor
as
begin
	begin try
		begin transaction
			declare @Doctor_code int, @Designation varchar(100)
			update Doctor set Designation= @Designation where Doctor_code=@Doctor_code
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
go
create proc spDelete_Doctor
as
begin
	begin try
		begin transaction
			declare @Doctor_code int
			delete from Doctor where Doctor_code=@Doctor_code
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
-----------------------------------------------------------------------------------------
go
create table AppointmentTime
(
	Appointment_ID int primary key,
	Doctor_code int references	Doctor(Doctor_code),
	Patient_id int references Patient(Patient_id),
	Appointment_date date,
	Start_time varchar(20),
	End_time varchar(20)
)
go
create proc spInsert_AppointmentTime    @Appointment_ID int,
										@Doctor_code int,
										@Patient_id int,
										@Appointment_date date,
										@Start_time varchar(20),
										@End_time varchar(20)
								
as
begin try
	insert into AppointmentTime values(@Appointment_ID,@Doctor_code,@Patient_id,@Appointment_date,@Start_time,@End_time)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
go
--insert into AppointmentTime values(1,1,1,'02-12-2015','3:30','3:50')
--select * from [dbo].[Patient]
go
select getdate()
go
create proc spUpdate_AppointmentTime
as
begin
	begin try
		begin transaction
			declare @Appointment_ID int,@Start_time datetime,@End_time datetime
			update AppointmentTime set Start_time= @Start_time where Appointment_ID=@Appointment_ID
			update AppointmentTime set End_time= @End_time where Appointment_ID=@Appointment_ID
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
go
create proc spDelete_AppointmentTime
as
begin
	begin try
		begin transaction
			declare @Appointment_ID int
			delete from AppointmentTime where Appointment_ID=@Appointment_ID
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
------------------------------------------------------------------------------------------
go
create table Diagnosis
(
	DiagNo int identity (1,1),
	Diagdetails nvarchar(1000),
	Remark varchar(10),
	Diagdate date,
	Other varchar(500),
	Patient_id int references Patient(Patient_id)
)
go
create proc spInsert_Diagnosis  @Diagdetails nvarchar(1000),
								@Remark varchar(10),
								@Diagdate date,
								@Other varchar(500),
								@Patient_id int 
as
begin try
	insert into Diagnosis values(@Diagdetails,@Remark,@Diagdate,@Other,@Patient_id)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
go
create proc spUpdate_Diagnosis
as
begin
	begin try
		begin transaction
			declare @Diagdate nvarchar(1000), @Patient_id int,@Remark varchar(10)
			update Diagnosis set Diagdate= @Diagdate where Patient_id=@Patient_id
			update Diagnosis set Remark =@Remark where Patient_id =@Patient_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
go
create proc spDelete_Diagnosis
as
begin
	begin try
		begin transaction
			declare @Patient_id int
			delete from Diagnosis where Patient_id=@Patient_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
---------------------------------------------------------------------------
go
create table Staff
(
	Staff_id int identity (1,1),
	Staff_Name varchar(50),
	Gender varchar(10),
	[Address] nvarchar(1000),
	Staff_Contact_no varchar(20),
	Department varchar(50),
	Doctor_code int references Doctor(Doctor_code)
)
go
create index IX_Department
on Staff(Department)
go
create proc spInsert_Staff      @Staff_Name varchar(50),
								@Gender varchar(10),
								@Address nvarchar(1000),
								@Staff_Contact_no varchar(20),
								@Department varchar(50),
								@Doctor_code int
as
begin try
	insert into Staff values(@Staff_Name ,@Gender ,@Address,@Staff_Contact_no, @Department ,@Doctor_code)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
go
create proc spUpdate_Staff
as
begin
	begin try
		begin transaction
			declare @Address nvarchar(1000), @Staff_id int
			update Staff set [Address]= @Address where Staff_id=@Staff_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
go
create proc spDelete_Staff
as
begin
	begin try
		begin transaction
			declare @Staff_id int
			delete from Staff where Staff_id=@Staff_id
		commit
		print 'Success'
	end try
	begin catch
		rollback transaction
		print 'Failed'
	end catch
end
-------------------------------------------------------------------------------
go

create table Bill
(
	Bill_No int identity (1,1),
	Patient_Name varchar(50),
	Date_Time datetime,
	Amount money,
	Contact_no varchar(20),
	Patient_id int references Patient(Patient_id)
)
go
create proc spInsert_Bill       @Patient_Name varchar(50),
								@Date_Time datetime,
								@Amount money,
								@Contact_no varchar(20),
								@Patient_id int
as
if @Date_Time=''
begin
    set @Date_Time =getdate()
end
begin try
	insert into Bill values(@Patient_Name,@Date_Time ,@Amount ,@Contact_no ,@Patient_id)
end try
begin catch
	declare @msg varchar(100)
	set @msg = ERROR_MESSAGE()
	raiserror(@msg,10,1)
	return @msg
end catch
select * from bill
go
----------------------------------------------------------------------------------------
create view vw_Patient_CurrentStatus
as
select Patient.Patient_id, Patient.Patient_Name as Patient_Name,Patient.Gender as Patient_Gender,
Patient.Contact_no as Patient_Patient_Contact_no,
Doctor_Name,Doctor.Doctor_code,
Doctor.Doctor_RoomNumber,Doctor.Doctor_Contact_no,
Diagnosis.Diagdetails,Diagnosis.Diagdate,Diagnosis.Remark,
Bill.Bill_No,Bill.Amount,Bill.Date_Time,Bill.Contact_no
from Patient
inner join Doctor
on Doctor.Doctor_code=Patient.Doctor_code
inner join Bill
on Bill.Patient_id=Patient.Patient_id
inner join Diagnosis
on Diagnosis.Patient_id=Patient.Patient_id
go
------------------------------------------------------------------------------------
create function fn_BillAmount (@Patient_id int)
returns varchar(500)
begin
	 DECLARE @date datetime, @tmpdate datetime, @years int, @months int, @days int,@total int
	SELECT @date = Appointment_date from AppointmentTime 
	where Patient_id= @Patient_id

	SELECT @tmpdate = @date
 
SELECT @years = DATEDIFF(yy, @tmpdate, GETDATE()) - CASE WHEN (MONTH(@date) > MONTH(GETDATE())) OR (MONTH(@date) = MONTH(GETDATE()) AND DAY(@date) > DAY(GETDATE())) THEN 1 ELSE 0 END
SELECT @tmpdate = DATEADD(yy, @years, @tmpdate)
SELECT @months = DATEDIFF(m, @tmpdate, GETDATE()) - CASE WHEN DAY(@date) > DAY(GETDATE()) THEN 1 ELSE 0 END
SELECT @tmpdate = DATEADD(m, @months, @tmpdate)
SELECT @days = DATEDIFF(d, @tmpdate, GETDATE())
 
SELECT @total=@years*365+ @months*30+@days
return @total
end	
go
select dbo.fn_BillAmount(2)
go
------------------------------------------------------------------------------------
create function fn_tablevalued (@Doctor_code int)
returns table
as
return(select Doctor_Name,Doctor.Gender,Department,Doctor.[Address],
Doctor.Designation,Staff.Staff_Name,Staff.Staff_Contact_no
from Doctor
inner join Staff
on Doctor.Doctor_code=Staff.Doctor_code
where Doctor.Doctor_code=@Doctor_code)
go
select * from dbo.fn_tablevalued(1)
go
-------------------------------------------------------------------------------------
create trigger tr_restriction
on bill
for insert
as
begin
	begin try
		begin transaction
			declare @amount money
			select @amount = Amount from Bill
			if(@amount=500)
	   commit
	   print 'Bill is Added'
	end try
	begin catch
		rollback transaction
		print 'Amount must be at least 500 taka'
	end catch
	
end

