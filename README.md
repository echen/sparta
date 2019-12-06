# Sparta

## What

Instantly turn your data into charts and dashboards.

[![Sparta](https://i.imgur.com/amPcsll.png)](https://i.imgur.com/amPcsll.png)

A lot of data already lives in a SQL table somewhere. Why is it so hard to visualize?

Yeah, you could write a query to extract the data, download it, and dump it into Excel or R. But this is suboptimal and inefficient.

- Databases are dynamic, but your one-off chart isn't. What if you want your time series of revenue to be updated everyday?
- It's hard to send pictures of graphs around. Attaching screenshots to emails doesn't always work, and your image is probably at a poor resolution anyways. Why not link to a chart that's fully interactive?
- Seeing the query that generated the data can be very useful. It explains what the chart is displaying, and also teaches coworkers what different tables and columns mean.

Sparta is a web app that allows you to write a SQL query, and quickly turn it into a chart (bar chart, time series, etc.) or dashboard. Think of it like a lightweight, simpler Tableau.

Support for data sources besides MySQL (e.g., CSV files, other databases, Hadoop, etc.) coming soon.

## Getting Started

1. First, tweak the `database.yml` file to connect to the database where the tables the app needs will be created, and add any databases you want to be able to turn into charts.
2. Make sure you have Ruby 1.9.3 installed
3. Install the bundler with `gem install bundler`
4. Install the necessary gems with `bundle install`.
5. Create the MySQL tables that the app uses with `rake db:migrate` .
6. Launch the app with `ruby app.rb`.

## Usage

### Bar Charts

Suppose you want to create a bar chart, e.g., the following bar chart of lacrosse events.

[![Bar Chart](https://i.imgur.com/TGYPoZK.png)](https://i.imgur.com/TGYPoZK.png)

Then write a SQL query whose output contains at least two named columns, one which provides a label for each bar and one which provides the width of each bar. Enter the name of the labeling column into the **Bar Label Column** field, and enter the name of the width column into the **Bar Width Column** field.

[![Bar Chart Fields](https://i.imgur.com/L0ze8is.png)](https://i.imgur.com/L0ze8is.png)

### Time Series

Suppose you want to create a time series.

[![Time Series](https://i.imgur.com/WyFFruA.png)](https://i.imgur.com/WyFFruA.png)

Then write a SQL query whose output contains at least two named columns, one which provides a date (in YYYY-MM-DD format) and one which provides a value. Enter the name of the date column into the **Date Column** field, and enter the name of the value column into the **Value Column** field. You can either leave the Grouping Column blank, or if you have a column you want to slice your data by (to generate multiple time series on the same graph, e.g., a time series of revenue split by desktop users, Android users, and iOS users), you can enter the name of that column into the **Grouping Column** field.

[![Time Series Fields](https://i.imgur.com/6eJH6Y5.png)](https://i.imgur.com/6eJH6Y5.png)

### Line Chart

A line chart is the same as a time series, except the x-axis can be any numeric column, instead of a date in YYYY-MM-DD format.

[![Line Chart](https://i.imgur.com/dRJzO3A.png)](https://i.imgur.com/dRJzO3A.png)

You write a SQL query whose output contains at least two named columns, containing values for the x-axis and the y-axis. You can either leave the Grouping Column blank, or if you have a column you want to slice your data by (to generate multiple line charts on the same graph), you can enter the name of that column into the **Grouping Column** field.

[![Line Chart Fields](https://i.imgur.com/Ivd9lhy.png)](https://i.imgur.com/Ivd9lhy.png)

## TODOs

* Add dashboard functionality.
* Support multiple databases better.
* Change the form fields depending on the chart type selected.
* Add error handling for broken SQL queries.
