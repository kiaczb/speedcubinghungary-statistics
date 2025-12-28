# Information

> _Note: This document is from the [WCA Statistics website](https://statistics.worldcubeassociation.org/database-query)_

## Helper Function

You can use the following function to better display your results
`wca_statistics_time_format(time_result, event_id, result_type)`

- `time_result`: is an integer that represents the time in hundredths of seconds. 474 means 4.74 s.
- `event_id`: is the WCA event code. You can find all accepted values by running the query `SELECT id FROM events.`
- `result_type`: either single or average

#### Examples:

```
- SELECT wca_statistics_time_format(474, '333', 'single') -> 4.74
- SELECT wca_statistics_time_format(-1, '222', 'average') -> DNF
- SELECT wca_statistics_time_format(-2, '333oh', 'single') -> DNS
- SELECT wca_statistics_time_format(22, '333fm', 'single') -> 22
- SELECT wca_statistics_time_format(2167, '333fm', 'average') -> 21.67
- SELECT wca_statistics_time_format(410358601, '333mbf', 'single') -> 59/60 (59:46)
```

## Parameter Substitution

You can use `:some_parameter` or `:SOME_PARAMETER` in your query for placeholders.

```sql
SELECT * from results r where event_id = :event_id and person_id = :person_id
```

You can then fill the placeholder using inputs below the query text area.

## Pagination

This behavior is handled automatically by the WCA Statistics website.

To paginate your results, we wrap your original query into a counter function and then we run it.

```sql
SELECT count(*) from ({{YOUR QUERY GOES HERE}}) alias
```

This is not something you should be worried about, but is good to know in case you get an error with that alias somewhere (it is likely that the query you submitted has an SQL error in that case).
