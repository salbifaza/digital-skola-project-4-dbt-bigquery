{{
  config(
    materialized='table'
  )
}}

SELECT
    *
FROM
    {{ ref('netflix_titles') }}
WHERE
    type = 'Movie'
