{%- set yaml_metadata -%}
source_model:
  'source-northwind': 'customers'
rsrc: '!Northwind.customers'
hashed_columns:
  hk_customer_h:
    - customer_id
  hd_customer_s:
    is_hashdiff: true
    columns:
      - company_name
      - contact_name
      - contact_title
      - address
      - city
      - region
      - postal_code
      - country
      - phone
      - fax
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set source_model = metadata_dict.get('source_model') -%}
{%- set rsrc = metadata_dict.get('rsrc') -%}
{%- set hashed_columns = metadata_dict.get('hashed_columns') -%}
{{ datavault4dbt.stage(
  source_model=source_model,
  rsrc=rsrc,
  hashed_columns=hashed_columns
) }}