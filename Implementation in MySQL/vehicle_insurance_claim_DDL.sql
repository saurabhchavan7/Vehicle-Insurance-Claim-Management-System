-- Create database

CREATE DATABASE IF NOT EXISTS insurance;
USE insurance;

create table customer
		(customer_id		varchar(40),
         first_name			varchar(40),
         last_name			varchar(40),
         birth_date			date,
         primary key (customer_id)
		);

create table customer_phone
		(customer_phone		varchar(20),
         customer_id		varchar(40),
         primary key (customer_phone),
         foreign key (customer_id) references customer (customer_id)
				on delete cascade
		);

create table car
		(car_vin			varchar(40),
         model				varchar(40),
         year_of_mfg		numeric(4,0),
         primary key (car_vin)
		);
        
create table bike
		(bike_vin				varchar(40),
         model				varchar(40),
         year_of_mfg		numeric(4,0),
         BikeType 			varchar(20) check (BikeType IN ('2-wheeler', '3-wheeler', 'other')),
         primary key (bike_vin)
		);

create table accident
		(accident_date		date not null,
         customer_id		varchar(40),
         car_vin			varchar(20),
         description		text,
         latitude			numeric(8,6),
         longitude			numeric(9,6),
         approx_location	varchar(40) not null,
         primary key (accident_date, customer_id),
         foreign key (car_vin) references car (car_vin)
				on delete cascade,
		 foreign key (customer_id) references customer(customer_id)
				on delete cascade
		);
        
create table policy
		(policy_no			varchar(40),
        sum_insured			int,
        start_date  		date,
        end_date			date,
        policy_type			varchar(50),
        primary key (policy_no)
        );
        
create table PolicyTransactions
		(customer_id		varchar(40),
         policy_no			varchar(40),
         purchase_date		date,
         primary key (customer_id, policy_no),
         foreign key (customer_id) references customer(customer_id)
				on delete cascade,
		 foreign key (policy_no) references policy(policy_no)
				on delete cascade
		 );
         
create table finance_dept
		 (transaction_id		varchar(40),
          disbursed_amount		int,
          disbursement_status	varchar(40)
					check (disbursement_status in ('disbursed', 'pending')),
		  primary key (transaction_id)
		  );
          		
create table claim
		 (claim_no				varchar(40),
          transaction_id		varchar(40),
          issued_amount			int,
          issued_date			date,
          claim_status			varchar(40)
					 check (claim_status in ('completed', 'notcompleted')),
		  primary key (claim_no),
          foreign key (transaction_id) references finance_dept (transaction_id)
				on delete cascade
		  );
          
create table PolicyClaims
		 (policy_no				varchar(40),
          claim_no				varchar(40),
          primary key (policy_no,claim_no),
          foreign key (policy_no) references policy (policy_no)
				on delete cascade,
		  foreign key (claim_no) references claim (claim_no)
				on delete cascade
		);
        
create table report
		(report_id				varchar(40),
         ReportDate				date,
         fraud_detected			varchar(10) 
					check (fraud_detected in ('yes', 'no')),
         report_details			text,
         primary key (report_id)
		);     
        
create table garage_partner
		(garage_name			varchar(40),
         contact_info			varchar(40),
         primary key (garage_name)
		);
         
create table claim_inspector
		(inspector_id			varchar(40),
         claim_no				varchar(40),
		 report_id				varchar(40),
         garage_name			varchar(40),
         inspector_name			varchar(40),
         inspector_contact_info varchar(40),
         primary key (inspector_id, claim_no, report_id, garage_name),
         foreign key (claim_no) references claim (claim_no)
				on delete cascade,
		 foreign key (report_id) references report (report_id)
				on delete cascade,
		 foreign key (garage_name) references garage_partner (garage_name)
				on delete cascade
		);
        
 
 





        


         
         
         
         
        
         
         
         
        

        
        
        
        
        
        
		
        
