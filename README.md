# Sparta

## What

Instantly turn your data into charts and dashboards.

[![Sparta](https://dl.dropboxusercontent.com/u/10506/blog/sparta/sparta.png)](https://dl.dropboxusercontent.com/u/10506/blog/sparta/sparta.png)

A lot of data already lives in a SQL table somewhere. Why is it so hard to visualize?

Yeah, you could write a query to extract the data, download it, and dump it into Excel or R. But this is suboptimal and inefficient.

- Databases are dynamic, but your one-off chart isn't. What if you want your time series of revenue to be updated everyday?
- It's hard to send pictures of graphs around. Attaching screenshots to emails doesn't always work, and your image is probably at a poor resolution anyways. Why not link to a chart that's fully interactive?
- Seeing the query that generated the data can be very useful. It explains what the chart is displaying, and also teaches coworkers what different tables and columns mean.

Sparta is a web app that allows you to write a SQL query, and quickly turn it into a chart (bar chart, time series, etc.) or dashboard. Think of it like a lightweight, simpler Tableau.  

Support for data sources besides MySQL (e.g., CSV files, other databases, Hadoop, etc.) coming soon.

## Getting Started

1. First, tweak the `database.yml` file to connect to the database where the tables the app needs will be created, and add any databases you want to be able to turn into charts.
2. Make sure you have Ruby installed, and install the necessary gems with `bundle install`.
3. Create the MySQL tables that the app uses with `rake db:migrate` .
4. Launch the app with `ruby app.rb`.

## TODOs

* Add dashboard functionality.
* Support multiple databases better.
* Make it easier and more obvious to fill out the necessary fields for different chart types.
* Add error handling for broken SQL queries.