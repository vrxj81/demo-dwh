{%- set yaml_metadata -%}
source_model:
  'source-northwind': 'shippers'
rsrc: '!Northwind.shippers'
hashed_columns:
  hk_shipper_h:
    - shipper_id
  hd_shipper_s:
    is_hashdiff: true
    columns:
      - company_name
      - phone
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
