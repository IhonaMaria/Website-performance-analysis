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
