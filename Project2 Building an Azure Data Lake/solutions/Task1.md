

# [Task 2: Design a star schema](../Project%20Instructions.md#task-2--design-a-star-schema)

## Evaluation criteria
<img src="../assets/image8.png" width="700"/>

## Guide

> Output of this task is identical to the [Task 2 from the previous project](../../Project1%20Bikeshare%20data%20analytics/solutions/Task2.md).


We have to transform relational-database schema to OLTP-suitable star-schema.
Star schema splits tables into fact-tables (or "events" like payment, trip) and dimension-tables (like date, rider or station).
The design should take into account [future queries](../Project%20Overview.md).

<img src="../assets/dend-project-erd.jpeg" width="600"/>

Creating database diagrams is convenient using https://dbdiagram.io/.

The resulting schema can look smth like this ([OLTP_schema.pdf](../../Project1%20Bikeshare%20data%20analytics/assets/oltp_schema.pdf)):
<img src="../../Project1 Bikeshare data analytics/assets/2023-08-12%2020_14_30-.png" width="700"/>


# | [Task 2](./Task2.md)