{{
  config(
    materialized='incremental'
  )
}}

SELECT
    *
FROM
    {{ ref('netflix_titles') }}
WHERE
    type = 'TV Show'

{% if is_incremental() %}
    AND date_added > (
        SELECT
            MAX(date_added)
        FROM
            {{ this }}
    )
{% endif %}
