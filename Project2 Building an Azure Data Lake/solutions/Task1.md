

# [Task 2: Design a star schema](../Project%20Instructions.md#task-2--design-a-star-schema)

## Evaluation criteria
<img src="../assets/image8.png" width="700"/>

## Guide

> Output of this task is almost identical to the [Task 2 from the previous project](../../Project1%20Bikeshare%20data%20analytics/solutions/Task2.md).


We have to transform relational-database schema to OLTP-suitable star-schema.
Star schema splits tables into fact-tables (or "events" like payment, trip) and dimension-tables (like date, rider or station).
The design should take into account [future queries](../Project%20Overview.md).

<img src="../assets/dend-project-erd.jpeg" width="600"/>

Creating database diagrams is convenient using https://dbdiagram.io/.

The resulting schema can look smth like this ([OLTP_schema.pdf](../assets/oltp_schema.pdf)):

<img src="../assets/schema.png" width="700"/>

```
Table fact_trip {
  trip_id bigint [primary key]
  rider_id bigint 
  rider_age int
  station_start_id nvarchar
  station_end_id nvarchar
  duration_minutes bigint
  date_start_id varbinary
  date_end_id varbinary
}

Table fact_payment {
  payment_id bigint [primary key]
  date_id varbinary
  rider_id bigint
  amount money
}

Table dim_rider {
  rider_id bigint [primary key]
  address nvarchar
  first_name nvarchar
  last_name nvarchar
  birthday timestamp
  age_start_account int
  account_start_date timestamp
  accound_end_date timestamp 
  is_member bit
  total_payed money
  total_duration_minutes int
}


Table dim_date {
  date_id varbinary [primary key]
  date timestamp
  year int
  quater int
  month int 
  day int
  weekday int
}

Table dim_station{
  station_id nvarchar
  station_name nvarchar
}

Ref: fact_trip.rider_id > dim_rider.rider_id 
Ref: fact_payment.rider_id > dim_rider.rider_id 
Ref: fact_payment.date_id > dim_date.date_id 
Ref: fact_trip.station_start_id - dim_station.station_id 
Ref: fact_trip.station_end_id - dim_station.station_id 
```

# | [Task 2](./Task2.md)