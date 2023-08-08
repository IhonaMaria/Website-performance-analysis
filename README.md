# WEBSITE PERFORMANCE ANALYSIS

## Introduction
Website content analysis is about understanding which pages are seen the most by your users in order to identify where to focus on improving your business. It also discovers useful information like how customers land on the website and how they make their way to place an order. 

The most common use cases of website content analysis are:

- Find the most-viewed pages on the site.
- Identify the first thing or entry page the user sees.
- Understand how most-viewed pages and entry pages perform to the business objectives.

In this repository, I attach several exercises with MySQL that have been done from a real business database with the aim of assessing this kind of analysis.The exercises simulate a hypothetical environment where a business asks us to get certain information and do certain analyses to optimize its benefits.

## Exercises

### Exercise 1:
In this first exercise, we had to extract the most-viewed website pages, ranked by session volume. The information was on the "website_pageviews" table from the database. 
After doing the analysis (see screenshot below) We can observe that the "home" page gets the vast majority of the page views during the specified period, followed by the "products". 
This is an indicator that we might want to focus on those pages that get the most views. 

![image](https://github.com/IhonaMaria/Website-performance-analysis/assets/119692820/a9117e16-20bf-4dc6-81d1-e947cf7f5337)


## Exercise 2:
Exercise two consisted of extracting a list of the top entry pages (the top pages where the customer lands for the first time) ranked by entry volume. 
To solve it, we will create a temporary table. Temporary tables in SQL are used to store intermediate results during the execution of a complex query or set of queries. They are especially useful when you need to perform multiple operations on a dataset and want to reuse or reference certain data without having to repeatedly query the original tables.
Two steps are performed to solve the problem:

- STEP 1: Find the first pageview for each session.
- STEP 2: Find the url that the customer saw on that first pageview.

  ![image](https://github.com/IhonaMaria/Website-performance-analysis/assets/119692820/cd8ad3de-cb46-4c55-8ce3-f011f2c5c7cf)


## Exercise 3:
In this exercise, we were asked to pull bounce rates for traffic landing on the homepage. The result should be in three columns, which are: sessions, bounced_sessions and bounce_rates. 
We have been introduced to a new concept, the "bounce" and "bounce rates". A bounce refers to a visitor's behavior when they land on a web page and then leave the site without interacting with any other pages or elements on that page. Essentially, a bounce occurs when a user visits a single page of a website and then exits the website without taking any further action or navigating to another page.
The bounce rate is a metric that represents the percentage of visitors who bounce from a website after viewing just one page, without engaging further with the site. It is calculated by dividing the number of single-page visits (bounces) by the total number of visits to the website and then multiplying by 100 to get the percentage.

Bounce rate = (Number of single-page visits / Total number of visits) * 100

Bounce rates are an essential metric for website owners and digital marketers as they provide insights into the effectiveness of landing pages and user engagement. The higher the bounce rate is, the worst for the business.

In order to solve the problem, these steps have been taken:

- STEP 1: Find the first website_page_view_id for relevant sessions
- STEP 2: Identify the landing page of each session 
- STEP 3: Count pageviews for each session, to identify the "bounces"
- STEP 4: Summarize total sessions and bounce sessions

It was necessary to create several temporary tables.

The final result is shown below:

![image](https://github.com/IhonaMaria/Website-performance-analysis/assets/119692820/97acd895-cf83-4e16-9d01-f2184c585b6c)

We can see a bounce rate of 60% approximately, which is a pretty high value. Actions should be taken from the company to decrease this value.


## Exercise 4:
Following the last analysis, the company we are supposed to work for sat a new landing page (/lander-1) in a 50/50 test against the homepage (/home) for the gsearch nonbrand traffic.
We are asked to pull the bounce rates for both landing pages in order to compare them and see which one performs better. 
Basically, we want to know whether the home or the lander page performs better in terms of bounce rates. 

Important note: It is important to just compare the data when the /lander-1 gets traffic to make a fair comparison. 

In order to solve the exercise, these steps have been taken:

-- STEP 1: Find the first instance of /lander -1
-- STEP 2: Identify the landing page of each session 
-- STEP 3: Count pageviews for each session, to identify the "bounces"
-- STEP 4: Summarize total sessions and bounce sessions

After the analysis, it looks like there has been an improvement since the lander page has a less bounce rate.

![image](https://github.com/IhonaMaria/Website-performance-analysis/assets/119692820/4f6d3993-da25-4030-b42d-63a86640896f)


## Exercise 5:
After the analysis of exercise 4, the company has changed the paid traffic route to the /lander-1. Therefore, they want us to pull the volume of paid search nonbrand traffic landing on
/home and /lander-1, trended weekly since June 1st. Basically, they want to make sure that the change has had the positive impact expected.

The solution is again a multi-step query:

- STEP 1: Finding the first website_pageview_id for the relevant sessions
- STEP 2: Identify the landing page for each session
- STEP 3: Count the pageviews for each session to identify the "bounces"
- STEP 4: Summarize per week (bounce rate, session to each lander)

![image](https://github.com/IhonaMaria/Website-performance-analysis/assets/119692820/2994ee3f-8799-4002-a440-32f6d75d870a)

Looking at the results, we can see that, at first, all the sessions are landing on home, then they are split among home and lander, and finally, at some point (2012-08-05), all of the traffic goes to lander-1.
We can see that when the traffic is completely switched to the lander-1, the bounce rates decrease. 
Moreover, the bounce rates drop from around 60% to 50%, which is a positive thing for the business, meaning that now more people interact with the website. 

