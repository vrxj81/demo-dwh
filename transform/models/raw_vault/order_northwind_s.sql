{{
  config(
    materialized = 'incremental'
    )
}}

{%- set yaml_metadata -%}
source_model: stg_orders
parent_hashkey: hk_order_l
src_hashdiff: hd_order_s
src_payload:
  - order_date
  - required_date
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set source_model = metadata_dict.get('source_model') -%}
{%- set parent_hashkey = metadata_dict.get('parent_hashkey') -%}
{%- set src_hashdiff = metadata_dict.get('src_hashdiff') -%}
{%- set src_payload = metadata_dict.get('src_payload') -%}

{{
  datavault4dbt.sat_v0(
    source_model=source_model,
    parent_hashkey=parent_hashkey,
    src_hashdiff=src_hashdiff,
    src_payload=src_payload
  )
}}