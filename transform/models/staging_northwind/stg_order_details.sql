{%- set yaml_metadata -%}
source_model:
  'source-northwind': 'order_details'
rsrc: '!Northwind.order_details'
hashed_columns:
  hk_order_details_l:
    - order_id
    - product_id
  hk_order_h:
    - order_id
  hk_product_h:
    - product_id
  hd_order_details_s:
    is_hashdiff: true
    columns:
      - unit_price
      - quantity
      - discount
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