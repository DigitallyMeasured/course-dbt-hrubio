{% macro truncate_stg_tables(tables_prefix) %}

    select 'truncate table [' || table_name || ']'
    from information_schema.tables
    where table_name like '{{ tables_prefix }}' || '%'

{% endmacro %}
