{% test is_id_valid(model, column_name) %}

    select 1
    from {{ model }}
    where not REGEXP_CONTAINS({{ column_name }}, "s[0-9]+")

{% endtest %}
