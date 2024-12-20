{{
  config(
    materialized = 'incremental',
    )
}}

{%- set yaml_metadata -%}
source_model: stg_shippers
parent_hashkey: hk_shipper_h
src_hashdiff: hd_shipper_s
src_payload:
  - company_name
  - phone
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