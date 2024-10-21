{{
  config(
    materialized = 'incremental'
    )
}}

{%- set yaml_metadata -%}
link_hashkey: hk_order_l
foreign_hashkeys:
  - hk_order_h
  - hk_customer_h
  - hk_employee_h
source_models: stg_orders
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set link_hashkey = metadata_dict.get('link_hashkey') -%}
{%- set foreign_hashkeys = metadata_dict.get('foreign_hashkeys') -%}
{%- set source_models = metadata_dict.get('source_models') -%}

{{
  datavault4dbt.link(
    link_hashkey=link_hashkey,
    foreign_hashkeys=foreign_hashkeys,
    source_models=source_models
  )
}}