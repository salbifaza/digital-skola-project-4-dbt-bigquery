{% macro comma_split(column_name) %}
    SPLIT({{ column_name }}, ',')
{% endmacro %}
