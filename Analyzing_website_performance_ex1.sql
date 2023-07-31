-- EXERCISE 1

-- Statement: Pull the most-viewed website pages, ranked by session volume.

USE mavenfuzzyfactory;

SELECT
	pageview_url,
    COUNT(DISTINCT website_pageview_id) AS pvs -- Page views

FROM website_pageviews
WHERE created_at <'2012-06-09'  -- We put the data when the message from the boss was sent to us
GROUP BY
	pageview_url
ORDER BY pvs DESC

-- We can see that the home page gets the vast majority of the page views during the specified period, followed by the products. 
-- This is an indicator that we might want to focus on those pages that get the most views. 
