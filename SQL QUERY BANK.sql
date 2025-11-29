create database bank;

use bank;

--- 1.Total loan amount funded:
Select sum(Loanamount)as Total_loan_amt_funded from bank.bankanalyst;

--- 2.Total_Loans:
select Count(Loanamount) as Total_Loans from bank.bankanalyst;

--- 3.Total amount:
select round(sum(Totalpymnt)) as Total_Amount from bank.bankanalyst;

--- 4.Total Interest
Select round(sum(Totalrec_int)) as Total_Interest from bank.bankanalyst;

--- 5.Branch-Wise (Interest, Fees, Total Revenue)
select 
	`branchname`,
	round(sum(`Totalrec_int`),2) "Total Interest" ,
    round(sum(`Totalfees`),2) "Total Fees",
    round(sum(`Totalrevenue`),2) "Total Revenue"
from `bankanalyst`
group by `branchname`;

--- 6.State-Wise Loan
select 
	`statename`, 
	sum(`loanamount`) "Total Loan Amount",
    round((sum(`loanamount`)*100/(select sum(`loanamount`) from `bankanalyst`)),"%") "% of Total Loan"
from `bankanalyst`
group by `statename`;

--- 7. Religion-Wise Loan: Monitors loan distribution across religious demographics.
select 
	Religion, 
	sum(`loanamount`) "Total Loan Amount"
from bankanalyst
group by Religion;

--- 8.Product Group-Wise Loan: Categorizes loans by product types (e.g., personal, auto).
select 
	`Productcategory` "Product Group",
	sum(`Loanamount`) "Total Loan Amount"
from bankanalyst
group by `Productcategory`;

--- 9. disbursment trend
SELECT  DISTINCT YEAR(STR_TO_DATE(Disbursementdate, '%d-%m-%Y')) AS Years,
count(loanamount) as No_Of_Loan from bankanalyst group by years order by years;

--- 10. Grade-Wise Loan
Select Grade,
Count(loanamount) "no_of_loans" from bankanalyst group by grade order by grade;

--- 11.Count of Default Loan
select count(*) as "Default Loan Count"
from `bankanalyst`
where `isdefaultloan` ="Yes";


--- 12.Count of Delinquent Clients
select count(*) "Delinquent Client Count"
from `bankanalyst` 
where `isdelinquentloan` ="Yes";

select 
 concat(Format(count(*) / 1000,2),'k') as "Deliquent_count" from bankanalyst where isdelinquentloan ="Yes"; 
 
 --- 13.Delinquent Loans Rate
select 
	concat(round((select count(*) from `bankanalyst` where `isdelinquentloan`="Yes")*100/count(*),2),"%") as "Delinquent Loan Rate"
from `bankanalyst`;


--- 14. Default Loan Rate
select 
	concat(round((select count(*) from `bankanalyst` where `isdefaultloan` ="Yes")*100/count(*),2),"%") as "Default Loan Rate"
from `bankanalyst`;

--- 15.Loan Status-Wise Loan
select Loanstatus, concat(round((sum(`loanamount`)*100/(select sum(`loanamount`) from `bankanalyst`)),2),"%") "% loan",
sum(loanamount) as "Total_loans"from bankanalyst group by loanstatus order by loanstatus;

--- 16.Age Group-Wise Loan
 select 
	Age "Age Group",
    sum(`loanamount`) "Total Loan Amount",
    concat(round(sum(`loanamount`)*100/(select sum(`loanamount`) from `bankanalyst`),2),"%") "% of Total Loan"
from `bankanalyst`
group by Age
order by Age;

--- 17.No Verified Loan
select 
	count(*) "No Verified Loan"
from `bankanalyst`
where `verificationstatus`= "not verified";

-- 18.Loan Maturity

SELECT  DISTINCT YEAR(STR_TO_DATE(Loanmaturity, '%d-%m-%Y')) AS Years,
count(Totalpymnt) as "Total_payments",
concat(round((Count(`totalpymnt`)*100/(select count(`Totalpymnt`) from `bankanalyst`)),2),"%") "%repayment"
FROM bankanalyst
group by Years
ORDER BY Years;