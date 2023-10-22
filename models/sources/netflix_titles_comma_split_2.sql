{{
  config(
    materialized='ephemeral'
  )
}}

{% set comma_split_columns = ["country", "listed_in", "`cast`", "director"] %}

SELECT
    * EXCEPT(
        date_added
        {% for comma_split_column in comma_split_columns %}
        , {{ comma_split_column }}
        {% endfor %}
    ),
    CASE
        WHEN date_added <> "" THEN PARSE_DATE("%B %d, %Y", date_added)
        ELSE NULL
    END AS date_added,
    {% for comma_split_column in comma_split_columns %}
    {{ comma_split(comma_split_column) }} AS {{ comma_split_column }},
    {% endfor %}
FROM
    {{ source('dbt_playground', 'raw_netflix_titles') }}
