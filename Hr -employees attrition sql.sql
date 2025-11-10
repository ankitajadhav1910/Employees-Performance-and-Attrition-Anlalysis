use hr_analytics;
select * from mytable;

Insight 1 — How many employees left?

SELECT 
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS AttritionRate
FROM mytable;

 “Out of 1470 employees, 237 left — that’s a 16% attrition rate.”


 Insight 2 — Which department has more people leaving?

SELECT 
    Department,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS AttritionRate
FROM mytable
GROUP BY Department
ORDER BY AttritionRate DESC;

 “Sales department has the highest attrition rate (22%).”


 Insight 3 — Does overtime affect attrition?
SELECT 
    OverTime,
    ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS AttritionRate
FROM mytable
GROUP BY OverTime;

“Employees doing overtime have a 30% attrition rate — those without overtime only 10%.”

💡 Insight 4 — Does salary matter?
SELECT 
    CASE 
        WHEN MonthlyIncome < 4000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 4000 AND 8000 THEN 'Medium'
        ELSE 'High' 
    END AS SalaryRange,
    ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS AttritionRate
FROM mytable
GROUP BY SalaryRange;

“Low-salary employees leave more often — 25% attrition compared to only 8% for high-salary employees.”

 Insight 5 — Does experience affect attrition?
SELECT 
    CASE 
        WHEN YearsAtCompany < 3 THEN '0-3 years'
        WHEN YearsAtCompany BETWEEN 3 AND 7 THEN '3-7 years'
        ELSE '7+ years'
    END AS ExperienceGroup,
    ROUND(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS AttritionRate
FROM mytable
GROUP BY ExperienceGroup;

 “Employees with less than 3 years in the company are leaving the most (28%).”

