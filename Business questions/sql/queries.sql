-- NOTE:
-- I beautified queries for ease of interpretation and used default convention of MySQL for commenting sections
-- The name of the table is sample_responses
-- Backticks are used to denote column names instead of double quotes

-- 1. What is the gender distribution of respondents from India?
SELECT 
    `Gender`,
    (COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India') * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Gender`;
-- Observation: about 60% of respondents are Male

-- 2. What percentage of respondents from India are interested in education abroad and sponsorship?
SELECT 
    `Self-Sponsor Higher Studies Abroad`,
    (COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India') * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Self-Sponsor Higher Studies Abroad`;
-- Observation: about 32% of Indian respondents are not interested in self sponsoring higher studies abroad.

-- 3. What are the 6 top influences on career aspirations for respondents in India?
SELECT 
    `Career Influencer`, COUNT(*) AS `Influencers`
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Career Influencer`
ORDER BY `Influencers` DESC
LIMIT 6;
-- Observation: used order by clause to sort descending and limit it to 6

-- 4. How do career aspiration influences vary by gender in India?
SELECT 
    `Careers Near Aspirational Job`,
    `Gender`,
    (COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India') * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Careers Near Aspirational Job` , `Gender`
ORDER BY `Gender` ASC , percentage DESC;
-- Observation: Most aspirational job for females is design and creative strategy and for males is data analytics

-- 5. What percentage of respondents are willing to work for a company for at least 3 years?
SELECT 
    `Commit to One Employer (3+ Years)`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Commit to One Employer (3+ Years)`
ORDER BY percentage DESC;
-- Observation: About 58% of respondents choose commitment based on company's culture.

-- 6. How many respondents prefer to work for socially impactful companies?
SELECT 
    `Willingness to Work for Company with No Social Impact (1â€“10)`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Willingness to Work for Company with No Social Impact (1â€“10)`
order by `Willingness to Work for Company with No Social Impact (1â€“10)` asc;
-- Observation: About 40% of respondents don't care about company with social impact (4 to 6 range)

-- 7. How does the preference for socially impactful companies vary by gender?
SELECT 
    `Willingness to Work for Company with No Social Impact (1â€“10)`,
    `Gender`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Willingness to Work for Company with No Social Impact (1â€“10)`, `Gender`
order by `Willingness to Work for Company with No Social Impact (1â€“10)` asc, `Gender` asc;
-- Observation: About 11.7% of males and 9% of females strictly don't care about social impact of the company.

-- 8. What is the distribution of minimum expected salary in the first three years among respondents?
SELECT 
    `Minimum In-Hand Salary (First 3 Years)`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Minimum In-Hand Salary (First 3 Years)`
ORDER BY percentage DESC;
-- Observation: One third of total respondents from India expect salary >50k for first 3 years.

-- 9. What is the expected minimum monthly salary in hand?
SELECT 
    MIN(c)
FROM
    (SELECT 
        `Minimum Starting In-Hand Salary`, COUNT(*) AS c
    FROM
        sample_responses
    WHERE
        `Country` = 'India'
    GROUP BY `Minimum Starting In-Hand Salary`) AS t;
-- Observation: 10k to 15k is expected minimum in hand salary.

-- 10. What percentage of respondents prefer remote working?
SELECT 
    `Preferred Working Environment`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Preferred Working Environment` LIKE '%Remote%'
GROUP BY `Preferred Working Environment`
ORDER BY percentage DESC;
-- Observation: About one third of respondents from India prefer remote work (fully or with travel options included)

-- 11. What is the preferred number of daily work hours?
SELECT 
    AVG(`Preferred Daily Working Hours`)
FROM
    sample_responses
WHERE
    `Country` = 'India';
-- Observation: People like to work even less than 3 hours daily.

-- 12. What are the common work frustrations among respondents?
SELECT 
    `Cause of Workplace Frustration`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India'
                AND `Cause of Workplace Frustration` != 'NA')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Cause of Workplace Frustration` != 'NA'
GROUP BY `Cause of Workplace Frustration`
ORDER BY percentage DESC;
-- Observation: Excluding the null response, most hated thing about workplace is aimless work.

-- 13. How does the need for work-life balance interventions vary by gender?
SELECT 
    `Reason for Workplace Happiness and Productivity`,
    `Gender`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India'
                AND `Reason for Workplace Happiness and Productivity` != 'NA')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Reason for Workplace Happiness and Productivity` != 'NA'
GROUP BY `Reason for Workplace Happiness and Productivity` , `Gender`
ORDER BY `Gender` ASC , percentage DESC;
-- Observation: Passion in work is the cause of happiness.

-- 14. How many respondents are willing to work under an abusive manager?
SELECT 
    `Work with Manager with History of Abuse`,
    COUNT(*) AS 'ready to work'
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Work with Manager with History of Abuse` = 'Yes'
GROUP BY `Work with Manager with History of Abuse`;
-- Observation: 3852 respondents are ready to work with an abusive manager.

-- 15. What is the distribution of minimum expected salary after five years?
SELECT 
    `Minimum In-Hand Salary (After 5 Years)`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
GROUP BY `Minimum In-Hand Salary (After 5 Years)`
ORDER BY percentage DESC;
-- Observation: About 23% of Indians expect >151k salary after 5 years.

-- 16. What are the remote working preferences by gender?
SELECT 
    `Gender`,
    `Preferred Working Environment`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Preferred Working Environment` LIKE '%Remote%'
GROUP BY `Preferred Working Environment` , `Gender`
ORDER BY `Gender` ASC , percentage DESC;
-- Observation: About 12% of total females prefer remote work whereas about 18% of total males prefer remote work.

-- 17. What are the top work frustrations for each gender?
SELECT 
    `Gender`,
    `Cause of Workplace Frustration`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India'
                AND `Cause of Workplace Frustration` != 'NA')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Cause of Workplace Frustration` != 'NA'
GROUP BY `Cause of Workplace Frustration` , `Gender`
ORDER BY `Gender` ASC , percentage DESC;
-- Observation: Toxic politics is main reason for frustration for females whereas Aimless work is main reason for frustration among males.

-- 18. What factors boost work happiness and productivity for respondents?
SELECT 
    `Reason for Workplace Happiness and Productivity`,
    ((COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India'
                AND `Reason for Workplace Happiness and Productivity` != 'NA')) * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Reason for Workplace Happiness and Productivity` != 'NA'
GROUP BY `Reason for Workplace Happiness and Productivity`
ORDER BY percentage DESC;
-- Observation: Passion in work is the reason voted by respondents for happiness and productivity.

-- 19. What percentage of respondents need sponsorship for education abroad?
SELECT 
    `Self-Sponsor Higher Studies Abroad`,
    (COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            sample_responses
        WHERE
            `Country` = 'India') * 100) AS percentage
FROM
    sample_responses
WHERE
    `Country` = 'India'
        AND `Self-Sponsor Higher Studies Abroad` NOT IN ('No')
GROUP BY `Self-Sponsor Higher Studies Abroad`;
-- Observation: About 67.82% of total respondents from India need sponsorship in one form or another for higher studies abroad.







