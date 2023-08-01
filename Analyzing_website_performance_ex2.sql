-- EXERCISE 2

-- Statement: Pull a list of the top entry pages (the top pages where the customer lands on for the first time) ranked on entry volume. 

USE mavenfuzzyfactory;

-- STEP 1: Find the first pageview for each session
-- STEP 2: Find the url that the customer saw on that first pageview. 

DROP TEMPORARY TABLE IF EXISTS first_pv_per_session;

CREATE TEMPORARY TABLE first_pv_per_session
SELECT 
	website_session_id,
    MIN(website_pageview_id) AS first_pv -- First pageview
    
FROM website_pageviews
WHERE created_at <'2012-06-12'  -- We put the data when the message from the boss was sent to us
GROUP BY website_session_id;

SELECT
	website_pageviews.pageview_url AS landing_page_url,
    COUNT( DISTINCT first_pv_per_session.website_session_id) AS sessions_hitting_landing_page
FROM first_pv_per_session
	LEFT JOIN website_pageviews
		ON first_pv_per_session.first_pv = website_pageviews.website_pageview_id
GROUP BY
	website_pageviews.pageview_url
    
    
    
