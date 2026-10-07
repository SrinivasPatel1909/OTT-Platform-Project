                          # Objective 2: Understand Viewing Behaviour Using SQL

CREATE DATABASE OTT_Analysis;
USE OTT_Analysis;

SELECT * FROM ratings_feedback;
SELECT * FROM subscription_retention;
SELECT * FROM user_profile;
SELECT * FROM viewing_activity;

                          # Task 1: Analyze Viewing Habits Across Audience Groups

# Task 1 Interpretation: User demographics significantly influence OTT viewing behavior, with certain age groups, genders, and subscription plans showing higher engagement and content completion.


# Analysis 1 :- Which age group spends the most time watching OTT content?

SELECT
    u.Age_Group,
    SUM(v.Watch_Duration_Minutes) AS Total_Watch_Time
FROM user_profile u
INNER JOIN viewing_activity v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Age_Group
ORDER BY Total_Watch_Time DESC;

# Interpretation:- 36-50 Age Group spends most time watching OTT content




# Analysis 2 : Which gender has the highest average content completion percentage?

SELECT
    u.Gender,
    AVG(v.Completion_Percentage) AS Avg_Completion
FROM user_profile AS u
INNER JOIN viewing_activity AS v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Gender
ORDER BY Avg_Completion DESC;

# Interpretation: Female users have the highest average content completion percentage, indicating slightly better content engagement .



# Analysis 3 :- Which subscription plan has the highest viewing engagement?

SELECT
    u.Subscription_Type,
    COUNT(v.Session_ID) AS Total_Sessions,
    SUM(v.Watch_Duration_Minutes) AS Total_Watch_Time,
    AVG(v.Completion_Percentage) AS Avg_Completion
FROM user_profile AS u
INNER JOIN viewing_activity AS v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Subscription_Type
ORDER BY Total_Watch_Time DESC;

# Interpretation: Free Trial users recorded the highest total watch time and viewing sessions, showing the greatest overall viewing engagement.



# Analysis 4 :- Which age groups have above-average watch duration?

SELECT
    u.Age_Group,
    AVG(v.Watch_Duration_Minutes) AS Avg_Watch_Time
FROM user_profile AS u
INNER JOIN viewing_activity AS v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Age_Group
HAVING AVG(v.Watch_Duration_Minutes) >
(
    SELECT AVG(Watch_Duration_Minutes)
    FROM viewing_activity
);

# Interpretation: Users aged 26–35 and 36–50 have above-average watch durations, making them the most engaged age groups.



# Analysis 5 : How can OTT users be classified based on their engagement level?

SELECT
    User_ID,
    Completion_Percentage,
    CASE
        WHEN Completion_Percentage >= 80 THEN 'High Engagement'
        WHEN Completion_Percentage >= 50 THEN 'Moderate Engagement'
        ELSE 'Low Engagement'
    END AS Engagement_Level
FROM viewing_activity
ORDER BY Completion_Percentage DESC;


# Interpretation: Users are classified into High, Moderate, and Low engagement levels based on their content completion, helping identify the most active viewers.



                           # Task 2: Compare Viewing Patterns by Devices and Regions
                           

# Task 2 Interpretation: OTT viewing patterns vary across devices and regions, with Smart TVs and the West/East regions demonstrating the highest streaming activity and engagement.

                           
# Analysis 1: Which device is most frequently used for streaming OTT content?

SELECT
    Device_Type,
    COUNT(Session_ID) AS Total_Sessions
FROM viewing_activity
GROUP BY Device_Type
ORDER BY Total_Sessions DESC;

# Interpretation: Smart TVs are the most frequently used devices for streaming OTT content.



# Analysis 2: Which region has the highest average watch duration?

SELECT
    u.Region,
    AVG(v.Watch_Duration_Minutes) AS Avg_Watch_Duration
FROM user_profile u
INNER JOIN viewing_activity v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Region
ORDER BY Avg_Watch_Duration DESC;

# Interpretation: The East region has the highest average watch duration, indicating the strongest viewer engagement.



# Analysis 3: Which devices have above-average watch duration?

SELECT
    Device_Type,
    AVG(Watch_Duration_Minutes) AS Avg_Watch_Duration
FROM viewing_activity
GROUP BY Device_Type
HAVING AVG(Watch_Duration_Minutes) >
(
    SELECT AVG(Watch_Duration_Minutes)
    FROM viewing_activity
);

# Interpretation: Tablet, Smart TV, and Laptop users have above-average watch durations, showing higher viewing engagement.



# Analysis 4: Which registered users have not watched any content?

SELECT
    u.`ï»¿User_ID`,
    u.Region,
    u.Subscription_Type
FROM user_profile u
LEFT JOIN viewing_activity v
ON u.`ï»¿User_ID` = v.User_ID
WHERE v.User_ID IS NULL;

# Interpretation: All registered users have viewing activity; no inactive users were found.


# Analysis 5: Which regions generate the highest number of viewing sessions?

SELECT
    u.Region,
    COUNT(v.Session_ID) AS Total_Sessions
FROM user_profile u
INNER JOIN viewing_activity v
ON u.`ï»¿User_ID` = v.User_ID
GROUP BY u.Region
ORDER BY Total_Sessions DESC;


# Interpretation: The West region generates the highest number of viewing sessions, making it the most active streaming region.



									
                                    # Task 3: Identify Peak Viewing Time Trends


# Task 3 Interpretation: User engagement is highest during the Evening and Night, making these the peak periods for OTT content consumption.



# Analysis 1: Which time of day records the highest number of viewing sessions?

SELECT
    Time_of_Day,
    COUNT(Session_ID) AS Total_Sessions
FROM viewing_activity
GROUP BY Time_of_Day
ORDER BY Total_Sessions DESC;

# Interpretation: Evening records the highest number of viewing sessions, making it the peak streaming time.


# Analysis 2: What is the average watch duration during each time of day?

SELECT
    Time_of_Day,
    AVG(Watch_Duration_Minutes) AS Avg_Watch_Duration
FROM viewing_activity
GROUP BY Time_of_Day
ORDER BY Avg_Watch_Duration DESC;

# Interpretation: Night has the highest average watch duration, indicating users spend the most time watching content at night.


# Analysis 3: Which time of day has the highest average content completion percentage?

SELECT
    Time_of_Day,
    AVG(Completion_Percentage) AS Avg_Completion_Percentage
FROM viewing_activity
GROUP BY Time_of_Day
ORDER BY Avg_Completion_Percentage DESC;


# Interpretation: Night users have the highest average content completion percentage, showing the strongest viewing engagement.


# Analysis 4: Which time of day has above-average watch duration?

SELECT
    Time_of_Day,
    AVG(Watch_Duration_Minutes) AS Avg_Watch_Duration
FROM viewing_activity
GROUP BY Time_of_Day
HAVING AVG(Watch_Duration_Minutes) >
(
    SELECT AVG(Watch_Duration_Minutes)
    FROM viewing_activity
);

# Interpretation: Evening and Night have above-average watch durations, making them the most engaging time periods for OTT viewing.



                                       # Task 4: Evaluate Content Completion 
                                       
                                      
# Task 4 Interpretation: Most users show moderate-to-high content completion, positive feedback, and strong satisfaction, indicating good overall content performance.


# Analysis 1: What is the average content completion percentage?

SELECT
    AVG(Completion_Percentage) AS Avg_Completion_Percentage
FROM viewing_activity;

# Interpretation: The average content completion percentage across all users is approximately 52.36%, indicating moderate overall viewing completion.



# Analysis 2: How many users completed more than 80% of the content?

SELECT
    COUNT(User_ID) AS Highly_Engaged_Users
FROM viewing_activity
WHERE Completion_Percentage > 80;

# Interpretation: A total of 6,272 users completed more than 80% of the content, representing highly engaged viewers.



# Analysis 3: Which content received the highest average rating?

SELECT
    Content_ID,
    AVG(Rating) AS Avg_Rating
FROM ratings_feedback
GROUP BY Content_ID
ORDER BY Avg_Rating DESC;

# Interpretation: The listed content titles received the highest average rating of 5.0, indicating excellent viewer satisfaction.


# Analysis 4: Which content has been rewatched the most?

SELECT
    Content_ID,
    COUNT(*) AS Total_Rewatches
FROM viewing_activity
WHERE Rewatched_Flag = 'Yes'
GROUP BY Content_ID
ORDER BY Total_Rewatches DESC;

# Interpretation: No content has been rewatched, indicating that users generally prefer watching new content over repeating existing content.



# Analysis 5: What is the distribution of feedback categories?

SELECT
    Feedback_Category,
    COUNT(*) AS Total_Feedback
FROM ratings_feedback
GROUP BY Feedback_Category
ORDER BY Total_Feedback DESC;

# Interpretation: Positive feedback is the most common category, indicating overall viewer satisfaction with the OTT platform.


                                 
                                 # Task 5: Analyze User Engagement and Subscription Performance
                                 
# Task 5 Interpretation: Subscription performance analysis shows that while the Free Trial attracts the most users, Premium drives higher revenue and renewals, and Basic users provide the highest satisfaction ratings.


# Analysis 1: Which subscription type has the highest number of users?

SELECT
    Subscription_Type,
    COUNT(User_ID) AS Total_Users
FROM subscription_retention
GROUP BY Subscription_Type
ORDER BY Total_Users DESC;

# Interpretation: Free Trial has the highest number of users, making it the most popular subscription plan


# Analysis 2: What is the average monthly fee for each subscription type?

SELECT
    Subscription_Type,
    AVG(Monthly_Fee) AS Avg_Monthly_Fee
FROM subscription_retention
GROUP BY Subscription_Type
ORDER BY Avg_Monthly_Fee DESC;

# Interpretation: Premium has the highest average monthly fee, followed by Basic, while Free Trial has no subscription cost.



# Analysis 3: Which subscription type has the highest renewal rate?

SELECT
    Subscription_Type,
    COUNT(User_ID) AS Renewed_Users
FROM subscription_retention
WHERE Renewal_Status = 'Renewed'
GROUP BY Subscription_Type
ORDER BY Renewed_Users DESC;

# Interpretation: Premium has the highest number of renewed users, indicating the strongest subscription renewal performance.


# Analysis 4: Which subscription type has the highest churn rate?

SELECT
    Subscription_Type,
    COUNT(User_ID) AS Churned_Users
FROM subscription_retention
WHERE Churn_Flag = 'Yes'
GROUP BY Subscription_Type
ORDER BY Churned_Users DESC;

# Interpretation: Premium also records the highest number of churned users, suggesting it experiences the greatest customer loss.



# Analysis 5: What is the average user rating for each subscription type?

SELECT
    s.Subscription_Type,
    AVG(r.Rating) AS Avg_Rating
FROM subscription_retention s
INNER JOIN ratings_feedback r
ON s.User_ID = r.ï»¿User_ID
GROUP BY s.Subscription_Type
ORDER BY Avg_Rating DESC;

# Interpretation: Basic subscribers have the highest average user rating, indicating the highest customer satisfaction among all subscription plans.








# Trigger 

CREATE TABLE subscription_log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Renewal_Status VARCHAR(20),
    Updated_On TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);






DELIMITER //

CREATE TRIGGER trg_subscription_log
AFTER UPDATE ON subscription_retention
FOR EACH ROW
BEGIN
    INSERT INTO subscription_log(User_ID, Renewal_Status)
    VALUES (NEW.User_ID, NEW.Renewal_Status);
END //

DELIMITER ;


CREATE TABLE user_feedback_json(
Feedback_ID INT AUTO_INCREMENT PRIMARY KEY,
Feedback JSON
);


#json 

INSERT INTO user_feedback_json(Feedback)
VALUES
('{
 "User_ID":101,
 "Rating":5,
 "Feedback":"Excellent Content",
 "Device":"Mobile"
}');

SELECT
JSON_EXTRACT(Feedback,'$.Rating') AS Rating,
JSON_EXTRACT(Feedback,'$.Device') AS Device
FROM user_feedback_json;



# stored procedure 

DELIMITER //

CREATE PROCEDURE GetRegionViewing(IN region_name VARCHAR(50))
BEGIN

SELECT
    u.Region,
    COUNT(v.Session_ID) AS Total_Sessions,
    AVG(v.Watch_Duration_Minutes) AS Avg_Watch_Duration
FROM user_profile u
JOIN viewing_activity v
ON u.`ï»¿User_ID` = v.User_ID
WHERE u.Region = region_name
GROUP BY u.Region;

END //

DELIMITER ;


# Overall Objective Conclusion: The analysis identified key trends in user behavior, viewing patterns, content engagement, and subscription performance on the OTT platform. These insights highlight opportunities to improve user engagement, optimize content strategies, and enhance customer retention. Overall, the findings support better data-driven decision-making for business growth.
