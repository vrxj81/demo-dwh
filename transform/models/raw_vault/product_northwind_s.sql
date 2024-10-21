{{
  config(
    materialized = 'incremental'
    )
}}

{%- set yaml_metadata -%}
source_model: stg_products
parent_hashkey: hk_product_h
src_hashdiff: hd_product_s
src_payload:
  - product_name
  - quantity_per_unit
  - unit_price
  - units_in_stock
  - units_on_order
  - reorder_level
  - discontinued
{%- endset %}

{%- set metadata_dict = fromyaml(yaml_metadata) %}
{%- set source_model = metadata_dict.get('source_model') %}
{%- set parent_hashkey = metadata_dict.get('parent_hashkey') %}
{%- set src_hashdiff = metadata_dict.get('src_hashdiff') %}
{%- set src_payload = metadata_dict.get('src_payload') %}

{{
  datavault4dbt.sat_v0(
    source_model=source_model,
    parent_hashkey=parent_hashkey,
    src_hashdiff=src_hashdiff,
    src_payload=src_payload
  )
}}