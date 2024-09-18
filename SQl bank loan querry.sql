-- lets view the table

SELECT *
	FROM [dbo].[bank_loan];

--										KEY METRICS
--INTEREST RATE
-- PAYMENT RECIEVED
-- LOAN AMOUNT
-- LOAN APPLICATION
--dEBT TO INTEREST RATIO.
--GOOD AND BAD LOAN METRICS
-- STATE
-- TERM
--	PURPOSE

-- loan Application

--							 Total Loan Application = 38,576

SELECT COUNT(*) AS Total_Application
	FROM [dbo].[bank_loan];

--							Month to Date Total Loan applicant = 4,314

  SELECT COUNT(*) AS MTD_Total_Loan_Applications
FROM [portfolio].[dbo].[bank_loan]
WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
  AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0);

 --							Month to Month Total Loan Application percentage growth = 6.914498141263
  WITH previous_mtd AS (
    SELECT COUNT(*) AS PMTD_Total_Loan_Applications
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) - 1, 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
),
mtd AS (
    SELECT COUNT(*) AS MTD_Total_Loan_Applications
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0)
)
SELECT 
    previous_mtd.PMTD_Total_Loan_Applications,
    mtd.MTD_Total_Loan_Applications,
    CASE 
        WHEN mtd.MTD_Total_Loan_Applications = 0 THEN 0
        ELSE ((mtd.MTD_Total_Loan_Applications - previous_mtd.PMTD_Total_Loan_Applications) * 100.0 / previous_mtd.PMTD_Total_Loan_Applications)
    END AS Percentage_Change
FROM previous_mtd, mtd;


--					Total Money Loaned =435,757,075
SELECT SUM(loan_amount) AS Total_Application
	FROM [dbo].[bank_loan];

--					Month to Date Total Loan applicant = 53,981,425

  SELECT SUM(loan_amount) AS MTD_Total_Loan_Applications
FROM [portfolio].[dbo].[bank_loan]
WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
  AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0);

  --				Month to Month Total Loan Amount percentage growth = 13.038682478681

  WITH previous_mtd AS (
    SELECT SUM(loan_amount) AS PMTD_Total_Loan_Amount
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) - 1, 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0) --- previous Month
),
mtd AS (
    SELECT SUM(loan_amount) AS MTD_Total_Loan_Amount
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0)
)
SELECT 
    previous_mtd.PMTD_Total_Loan_Amount,
    mtd.MTD_Total_Loan_Amount,
    CASE 
        WHEN mtd.MTD_Total_Loan_Amount = 0 THEN 0
        ELSE ((mtd.MTD_Total_Loan_Amount - previous_mtd.PMTD_Total_Loan_Amount) * 100.0 / previous_mtd.PMTD_Total_Loan_Amount)
    END AS Percentage_Change
FROM previous_mtd, mtd;

--					Total Payment Recieved =473,070,933

SELECT SUM(total_payment) AS Total_Application
	FROM [dbo].[bank_loan];

--					Month to Date Total Payment Recieved  = 58,074,380

  SELECT SUM(total_payment) AS MTD_Total_Money_Recieved
FROM [portfolio].[dbo].[bank_loan]
WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
  AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0);

  --				 Month to Month Total Money Recieved percentage growth = 15.842865329810

  WITH previous_mtd AS (
    SELECT SUM(total_payment) AS PMTD_Total_Money_Recieved
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) - 1, 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0) --- previous Month
),
mtd AS (
    SELECT SUM(total_payment) AS MTD_Total_Money_Recieved
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0)
)
SELECT 
    previous_mtd.PMTD_Total_Money_Recieved,
    mtd.MTD_Total_Money_Recieved,
    CASE 
        WHEN mtd.MTD_Total_Money_Recieved = 0 THEN 0
        ELSE ((mtd.MTD_Total_Money_Recieved - previous_mtd.PMTD_Total_Money_Recieved) * 100.0 / previous_mtd.PMTD_Total_Money_Recieved)
    END AS Percentage_Change
FROM previous_mtd, mtd;

--						Average interest Rate = 12.0488314172048

SELECT AVG(int_rate) * 100 AS Avg_int
	FROM [dbo].[bank_loan]

	--				Month to Date Average interest Rate = 12.3560408676042

  SELECT AVG(int_rate)*100 AS MTD_Average_interest_Rate
FROM [portfolio].[dbo].[bank_loan]
WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
  AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0);

  --			Month to Month Average interest Rate growth = 3.46954544896374

  WITH previous_mtd AS (
    SELECT AVG(int_rate) AS PMTD_Average_interest_Rate
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) - 1, 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0) --- previous Month
),
mtd AS (
    SELECT AVG(int_rate) AS MTD_Average_interest_Rate
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0)
)
SELECT 
    previous_mtd.PMTD_Average_interest_Rate,
    mtd.MTD_Average_interest_Rate,
    CASE 
        WHEN mtd.MTD_Average_interest_Rate = 0 THEN 0
        ELSE ((mtd.MTD_Average_interest_Rate - previous_mtd.PMTD_Average_interest_Rate) * 100.0 / previous_mtd.PMTD_Average_interest_Rate)
    END AS Percentage_Change
FROM previous_mtd, mtd;

--					Average Debt to Income Rate = 13.3274331211432

SELECT AVG(dti) * 100 AS Avg_dti
	FROM [dbo].[bank_loan]

--				Month to Date Debt to Income Rate = 13.6655377880425

  SELECT AVG(dti)*100 AS MTD_Debt_to_Income_Rate
FROM [portfolio].[dbo].[bank_loan]
WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
  AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0);

--				 Month to Month Debt to Income Rate growth = 2.72729061380536

  WITH previous_mtd AS (
    SELECT AVG(dti) AS PMTD_Debt_to_Income_Rate
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) - 1, 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0) --- previous Month
),
mtd AS (
    SELECT AVG(dti) AS MTD_Debt_to_Income_Rate
    FROM [portfolio].[dbo].[bank_loan]
    WHERE issue_date >= DATEADD(MONTH, DATEDIFF(MONTH, 0, (SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])), 0)
      AND issue_date < DATEADD(MONTH, DATEDIFF(MONTH, 0,(SELECT MAX(issue_date) FROM [portfolio].[dbo].[bank_loan])) + 1, 0)
)
SELECT 
    previous_mtd.PMTD_Debt_to_Income_Rate,
    mtd.MTD_Debt_to_Income_Rate,
    CASE 
        WHEN mtd.MTD_Debt_to_Income_Rate = 0 THEN 0
        ELSE ((mtd.MTD_Debt_to_Income_Rate - previous_mtd.PMTD_Debt_to_Income_Rate) * 100.0 / previous_mtd.PMTD_Debt_to_Income_Rate)
    END AS Percentage_Change
FROM previous_mtd, mtd;


--								GOOD AND BAD LOAN METRICS
--Good loan is regarded as when the loan status is fully paid or Current while bad loan is when the loan status is Charged off

--		Good loan applicant =33,243

SELECT COUNT(*) AS Good_loan_Applicant
	FROM [dbo].[bank_loan]
	WHERE loan_status IN ('Fully Paid','Current');

--		Good loan Total Amount Loaned =370,224,850

SELECT SUM(loan_amount) AS Good_loan_Total_Amount_Loaned
	FROM [dbo].[bank_loan]
	WHERE loan_status IN ('Fully Paid','Current');

--		Good loan Total Amount Recieved =435,786,170

SELECT SUM(total_payment) AS Good_loan_Total_payment
	FROM [dbo].[bank_loan]
	WHERE loan_status IN ('Fully Paid','Current');

--		Good loan Average interest Rate  =11.7552952693394

SELECT Avg(int_rate)*100 AS Good_loan_Average_interest
	FROM [dbo].[bank_loan]
	WHERE loan_status IN ('Fully Paid','Current');

--		Good loan Average Debt to Income Rate  =13.2187774886706

SELECT Avg(dti)*100 AS Good_loan_Average_dti
	FROM [dbo].[bank_loan]
	WHERE loan_status IN ('Fully Paid','Current');


--					BAD LOAN METRICS

--		Bad loan applicant =5,333

SELECT COUNT(*) AS Bad_loan_Applicant
	FROM [dbo].[bank_loan]
	WHERE loan_status NOT IN ('Fully Paid','Current');

--		BAD loan Total Amount Loaned =65,532,225

SELECT SUM(loan_amount) AS Bad_loan_Total_Amount_Loaned
	FROM [dbo].[bank_loan]
	WHERE loan_status NOT IN ('Fully Paid','Current');

--		Bad loan Total Amount Recieved =37,284,763

SELECT SUM(total_payment) AS Bad_loan_Total_payment
	FROM [dbo].[bank_loan]
	WHERE loan_status NOT IN ('Fully Paid','Current');

--		Bad loan Average interest Rate  =13.8785749318289

SELECT Avg(int_rate)*100 AS Bad_loan_Average_interest
	FROM [dbo].[bank_loan]
	WHERE loan_status NOT IN ('Fully Paid','Current');

--		Bad loan Average Debt to Income Rate  =14.0047328005517

SELECT Avg(dti)*100 AS Bad_loan_Average_dti
	FROM [dbo].[bank_loan]
	WHERE loan_status NOT IN ('Fully Paid','Current');

		-- LOAN STATUS

	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        [dbo].[bank_loan]
    GROUP BY
        loan_status

--				STATE
SELECT 
	address_state AS AD_STATE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [dbo].[bank_loan]
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC


--					TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [dbo].[bank_loan]
GROUP BY term
ORDER BY Total_Loan_Applications DESC
	

--				PURPOSE

SELECT 
	purpose AS purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [dbo].[bank_loan]
GROUP BY purpose
ORDER BY Total_Loan_Applications  DESC