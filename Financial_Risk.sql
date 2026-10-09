CREATE TABLE finacial_risk (
    loan_id VARCHAR(20),
    loan_date DATE,
    state VARCHAR(50),
    loan_type VARCHAR(50),
    loan_purpose VARCHAR(100),
    loan_amount NUMERIC(15,2),
    outstanding_balance NUMERIC(15,2),
    annual_income NUMERIC(15,2),
    credit_score NUMERIC(10,1),
    debt_to_income NUMERIC(10,2),
    interest_rate NUMERIC(10,2),
    loan_term_months INT,
    risk_grade VARCHAR(5),
    employment_status VARCHAR(50),
    loan_status VARCHAR(30),
    payments_missed INT,
    collateral_value NUMERIC(15,2),
    estimated_interest NUMERIC(15,2)
);
SELECT * FROM finacial_risk 

SELECT * FROM finacial_risk  LIMIT 10;

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    SUM(outstanding_balance) AS total_outstanding_balance
FROM finacial_risk;

-- BUSINESS QUESTIONS 

-- What is the total number of loans?
SELECT COUNT(*) AS total_number_of_loans
FROM finacial_risk;

-- What is the total loan exposure?
SELECT ROUND(SUM(loan_amount), 2) AS loan_exposure
FROM finacial_risk;

-- What is the total outstanding balance?
SELECT ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM finacial_risk;

-- How many loans are in each loan status?
SELECT loan_status,
COUNT(*) AS total_loan_status
FROM finacial_risk 
GROUP BY loan_status
ORDER BY total_loan_status DESC;

-- How many loans are in each risk grade?
SELECT risk_grade,
COUNT(*) AS total_loan
FROM finacial_risk 
GROUP BY risk_grade
ORDER BY total_loan DESC;

-- How many loans are in each loan type?
SELECT loan_type,
COUNT(*) AS total_loan
FROM finacial_risk 
GROUP BY loan_type
ORDER BY total_loan DESC;

-- What is the total loan amount by loan type?
SELECT loan_type,
ROUND(SUM(loan_amount), 2) AS total_loan_amount
FROM finacial_risk 
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- How many default loans are there?
SELECT loan_status,
COUNT(*) AS default_loan
FROM finacial_risk 
WHERE loan_status = 'Default'
GROUP BY loan_status;

-- What is the total default loan amount?
SELECT loan_status,
ROUND(SUM(loan_amount), 2) AS total_loan_amount
FROM finacial_risk 
WHERE loan_status = 'Default'
GROUP BY loan_status
ORDER BY total_loan_amount DESC;

-- What is the total default outstanding balance?
SELECT loan_status,
ROUND(SUM(outstanding_balance), 2) AS total_outstanding_balance
FROM finacial_risk 
WHERE loan_status = 'Default'
GROUP BY loan_status
ORDER BY total_outstanding_balance DESC;

-- How many default loans are there by risk grade?
SELECT risk_grade,
COUNT(*) AS default_loans
FROM finacial_risk 
WHERE loan_status = 'Default'
GROUP BY risk_grade
ORDER BY risk_grade DESC;

-- What is the default outstanding balance by state?
SELECT state,
ROUND(SUM(outstanding_balance), 2) AS default_outstanding_balance
FROM finacial_risk 
WHERE loan_status = 'Default'
GROUP BY state
ORDER BY default_outstanding_balance DESC;

-- What is the average credit score by risk grade?
SELECT risk_grade,
ROUND(AVG(credit_score),2) AS avg_credit_score
FROM finacial_risk 
GROUP BY risk_grade
ORDER BY risk_grade DESC;

-- Which loans have collateral lower than outstanding balance?
SELECT
 loan_id,
 loan_amount,
 outstanding_balance,
 collateral_value,
    ROUND(
        outstanding_balance - collateral_value,
        2
    ) AS collateral_shortfall
FROM finacial_risk 
WHERE collateral_value < outstanding_balance
ORDER BY collateral_shortfall DESC;

-- Which loans have credit score below 670 and DTI above 35?
SELECT
    loan_id,
    credit_score,
    debt_to_income,
    loan_amount,
    outstanding_balance,
    risk_grade,
    loan_status
FROM finacial_risk 
WHERE credit_score < 670
  AND debt_to_income > 35
ORDER BY debt_to_income DESC;

