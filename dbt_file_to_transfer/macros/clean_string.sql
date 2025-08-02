{% macro clean_string(column_name) %}
    replace({{ column_name }}, '–', '-')
{% endmacro %}
