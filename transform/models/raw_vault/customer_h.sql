{{
  config(
    materialized = 'incremental',
    )
}}

{%- set yaml_metadata -%}
source_models:
  stg_customers
hashkey: hk_customer_h
business_keys: customer_id
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set source_models = metadata_dict.get('source_models') -%}
{%- set hashkey = metadata_dict.get('hashkey') -%}
{%- set business_keys = metadata_dict.get('business_keys') -%}

{{
  datavault4dbt.hub(
    source_models=source_models,
    hashkey=hashkey,
    business_keys=business_keys
  )
}}