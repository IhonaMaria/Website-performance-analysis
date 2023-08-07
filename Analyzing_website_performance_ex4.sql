-- EXERCISE 4

-- Statement: Based on previous analysis, they sat a new landing pae (/lander-1) in a 50/50 test against the homepage (/home) for our gsearch nonbrand traffic.
-- We need to pull the bounce rates for both landing pages in order to compare them and see which one performs better. 
-- It is important to just compare the data when the /lander-1 gets traffic to make a fair comparison. 
-- We want to know wether home or lander performs better in terms of bounce rates. 

USE mavenfuzzyfactory;

-- STEP 1: Find the first instance of /lander -1
-- STEP 2: Identify the landing page of each session 
-- STEP 3: Count pageviews for each session, to identify the "bounces"
-- STEP 4: Summarize total sessions and bounce sessions



-- First find the first instance of /lander -1 to set the analysis timeframe. We have to extract the data only from the period where the test was set, so that we can compare both fairly.alter


SELECT
	MIN(created_at) AS first_created_at,   -- This is the first time that /lander-1 was displayed to a customer on the website. 
    MIN(website_pageview_id) AS first_pageview_id
FROM website_pageviews
WHERE pageview_url = '/lander-1'
	AND created_at IS NOT NULL
;
-- first_created_at: 2012-06-19
-- first_pageview_id: 23504



CREATE TEMPORARY TABLE first_test_pageviews
SELECT
	website_pageviews.website_session_id,
    MIN(website_pageviews.website_pageview_id) AS min_pageview_id
FROM website_pageviews
	INNER JOIN website_sessions
		ON website_sessions.website_session_id = website_pageviews.website_session_id
        AND website_sessions.created_at < '2012-07-28'
        AND website_pageviews.website_pageview_id > 23504
        AND website_sessions.utm_source = 'gsearch'
        AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY
	website_pageviews.website_session_id;



-- We bring the landpage to each session:
CREATE TEMPORARY TABLE nonbrand_test_sessions_w_landing_page
SELECT
	first_test_pageviews.website_session_id,
    website_pageviews.pageview_url AS landing_page 
FROM first_test_pageviews
	LEFT JOIN website_pageviews
		ON website_pageviews.website_pageview_id=first_test_pageviews.min_pageview_id -- The website pageview is the landing pageview
WHERE website_pageviews.pageview_url IN ('/home','/lander-1');




-- We identify the bouncers:
CREATE TEMPORARY TABLE bounced_sessions_test
SELECT
	nonbrand_test_sessions_w_landing_page.website_session_id,
    nonbrand_test_sessions_w_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed -- It counts how many pageviews the customer had on one web session
FROM nonbrand_test_sessions_w_landing_page
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id=nonbrand_test_sessions_w_landing_page.website_session_id
GROUP BY
	nonbrand_test_sessions_w_landing_page.website_session_id,
    nonbrand_test_sessions_w_landing_page.landing_page
HAVING
	COUNT(website_pageviews.website_pageview_id) = 1;  -- We only save the pages viewed that has a count of 1 (because that are the bounced sessions)



-- Final analysis:

SELECT
	nonbrand_test_sessions_w_landing_page.landing_page,
	COUNT(DISTINCT nonbrand_test_sessions_w_landing_page.website_session_id) AS sessions,
    COUNT(DISTINCT bounced_sessions_test.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT bounced_sessions_test.website_session_id)/COUNT(DISTINCT nonbrand_test_sessions_w_landing_page.website_session_id) AS bounce_rate
    
    
FROM nonbrand_test_sessions_w_landing_page
	LEFT JOIN bounced_sessions_test
		ON nonbrand_test_sessions_w_landing_page.website_session_id=bounced_sessions_test.website_session_id
GROUP BY
	nonbrand_test_sessions_w_landing_page.landing_page;
    
    
    
-- It looks like there has been an improvement: the lander page has a few bounce_rate. 