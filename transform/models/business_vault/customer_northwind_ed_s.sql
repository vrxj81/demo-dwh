{%- set yaml_metadata -%}
sat_v0: customer_northwind_s
hashkey: hk_customer_h
hashdiff: hd_customer_s
add_is_current_flag: true
{%- endset %}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set sat_v0 = metadata_dict.get('sat_v0') -%}
{%- set hashkey = metadata_dict.get('hashkey') -%}
{%- set hashdiff = metadata_dict.get('hashdiff') -%}
{%- set add_is_current_flag = metadata_dict.get('add_is_current_flag') -%}

{{
  datavault4dbt.sat_v1(
    sat_v0=sat_v0,
    hashkey=hashkey,
    hashdiff=hashdiff,
    add_is_current_flag=add_is_current_flag
  )
}}
