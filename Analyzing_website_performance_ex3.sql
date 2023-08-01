-- EXERCISE 3

-- Statement: Pull bounce rates for traffic landing on the homepage. Express the result in three columns, sessions: bounced_sessions and bounce_rates. 


USE mavenfuzzyfactory;

-- STEP 1: Find the first website_page_view_id for relevant sessions
-- STEP 2: Identify the landing page of each session 
-- STEP 3: Count pageviews for each session, to identify the "bounces"
-- STEP 4: Summarize total sessions and bounce sessions



-- Find the minimum website pageview id associated with each session we care about. 

CREATE TEMPORARY TABLE first_pageviews
SELECT
	website_session_id,
    MIN(website_pageview_id) AS min_pageview_id
FROM website_pageviews
WHERE created_at <'2012-06-14'  -- We put the data when the message from the boss was sent to us
GROUP BY
	website_session_id;



-- Bring the landing page for each session

CREATE TEMPORARY TABLE sessions_w_landing_page
SELECT
	first_pageviews.website_session_id,
    website_pageviews.pageview_url AS landing_page 
FROM first_pageviews
	LEFT JOIN website_pageviews
		ON website_pageviews.website_pageview_id=first_pageviews.min_pageview_id -- The website pageview is the landing pageview
WHERE website_pageviews.pageview_url='/home'; 



-- Count pageviews for each session, to identify the "bounces"

CREATE TEMPORARY TABLE bounced_sessions
SELECT
	sessions_w_landing_page.website_session_id,
    sessions_w_landing_page.landing_page,
    COUNT(website_pageviews.website_pageview_id) AS count_of_pages_viewed -- It counts how many pageviews the customer had on one web session
FROM sessions_w_landing_page
	LEFT JOIN website_pageviews
		ON website_pageviews.website_session_id=sessions_w_landing_page.website_session_id
GROUP BY
	sessions_w_landing_page.website_session_id,
    sessions_w_landing_page.landing_page
HAVING
	COUNT(website_pageviews.website_pageview_id) = 1;  -- We only save the pages viewed that has a count of 1 (because that are the bounced sessions)
    

-- FINAL OUTPUT
SELECT
	COUNT(DISTINCT sessions_w_landing_page.website_session_id) AS sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id) AS bounced_sessions,
    COUNT(DISTINCT bounced_sessions.website_session_id)/COUNT(DISTINCT sessions_w_landing_page.website_session_id) AS bounce_rate
FROM sessions_w_landing_page
	LEFT JOIN bounced_sessions
		ON sessions_w_landing_page.website_session_id=bounced_sessions.website_session_id;
        
        
-- We obtained a 60% bounce rate, which can be pretty high.
    
	
	
	

