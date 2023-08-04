/* Overview the Data*/

Select *
From dbo.social_influence_on_shopping



/*To get the total counts and percentages of respondents for each social platform*/

SELECT 
	answer,	
	SUM(Count) AS Total_Count, 
	SUM(Percentage) AS Total_Percentage
FROM
	dbo.social_influence_on_shopping
GROUP BY 
	Answer;

/*To find the social platform with the highest count and percentage of respondents*/

SELECT 
	answer, 
	SUM(Count) AS Total_Count, 
	SUM(Percentage) AS Total_Percentage
FROM
	dbo.social_influence_on_shopping
GROUP BY
	answer
ORDER BY
	Total_Count DESC, 
	Total_Percentage DESC;

/*To explore differences in shopping habits between segment descriptions*/

SELECT 
    segment_description,
    answer,
    MAX(Count) AS Max_Count
FROM 
    dbo.social_influence_on_shopping
GROUP BY 
    segment_description,
    answer
Order BY Max_Count DESC;

/*To analyze the variation in counts and percentages across segments*/

SELECT 
	segment_type, 
	segment_description, 
	answer, 
	SUM(Count) AS Total_Count, 
	SUM(Percentage) AS Total_Percentage
FROM
	dbo.social_influence_on_shopping
GROUP BY 
	segment_type, segment_description, answer
ORDER BY 
	Total_Count DESC, 
	Total_Percentage DESC;


/*To draw insights for effective targeting of millennials and Gen Z on social media*/

SELECT 
	Answer, 
	segment_description,
	SUM(Count) AS Total_Count,
	SUM(Percentage) AS Total_Percentage
FROM	
	dbo.social_influence_on_shopping
WHERE
	segment_type IN ('university', 'college', 'school')
GROUP BY
	Answer,
	segment_description
ORDER BY
	Total_Count DESC;


/*To find the most influential social media platform for online shopping among respondents from different universities*/

SELECT 
	segment_description,
	answer, 
	SUM(Count) AS Total_Count
FROM 
	dbo.social_influence_on_shopping
WHERE
	segment_type = 'University' AND segment_description IN 
	('Appalachian State University', 'Arbroath Academy', 
	'University of Texas', 'University of Toronto', 
	'University of Virginia', 'University of Washington',
	'United States Military Academy', 'United States Naval Academy',
	'University of British Columbia', 'University of Alabama',
	'University of Arizona', 'University of Arkansas'
	) -- You can add any other university names to check thier results.
GROUP BY 
	segment_description, 
	answer
ORDER BY 
	answer, 
	Total_Count DESC;

/*To analyze significant variations in online shopping preferences based on different segment types*/

SELECT 
    segment_type,
    answer,
    SUM(Count) AS Total_Count,
    SUM(Percentage) AS Total_Percentage
FROM 
    dbo.social_influence_on_shopping
GROUP BY 
    segment_type, answer
ORDER BY 
    segment_type, Total_Count DESC, Total_Percentage DESC;

/*Common Table Expression (CTE) named "SocialMediaRanking" to rank the social media platforms 
based on their total counts within each segment type.*/ 

WITH SocialMediaRanking AS (
    SELECT 
        segment_type,
        answer,
        SUM(Count) AS Total_Count,
        RANK() OVER (PARTITION BY segment_type ORDER BY SUM(Count) DESC) AS Platform_Rank
    FROM 
        dbo.social_influence_on_shopping
    GROUP BY 
        segment_type, answer
)
SELECT
    segment_type,
    answer AS Social_Media_Platform,
    Total_Count,
    Platform_Rank
FROM
    SocialMediaRanking
ORDER BY
    segment_type, Platform_Rank;



