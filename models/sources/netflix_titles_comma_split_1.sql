{{
  config(
    materialized='ephemeral'
  )
}}

SELECT
    * EXCEPT(
        date_added,
        country,
        listed_in,
        `cast`,
        director
    ),
    CASE
        WHEN date_added <> "" THEN PARSE_DATE("%B %d, %Y", date_added)
        ELSE NULL
    END AS date_added,
    {{ comma_split('country') }} AS country,
    {{ comma_split('listed_in') }} AS listed_in,
    {{ comma_split('`cast`') }} AS `cast`,
    {{ comma_split('director') }} AS director
FROM
    {{ source('dbt_playground', 'raw_netflix_titles') }}
