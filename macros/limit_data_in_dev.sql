{% macro limit_data_in_dev(column_name, days_of_data=3) -%}
{% if target.name == 'dev' %}
where {{ column_name }} >= dateadd('day', - {{ days_of_data }}, getdate()::timestamp )
{% endif %}
{%- endmacro %}