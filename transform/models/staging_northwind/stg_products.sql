{%- set yaml_metadata -%}
source_model:
  'source-northwind': 'products'
rsrc: '!Northwind.products'
hashed_columns:
  hk_product_h:
    - product_id
  hk_category_h:
    - category_id
  hk_supplier_h:
    - supplier_id
  hd_product_s:
    is_hashdiff: true
    columns:
      - product_name
      - quantity_per_unit
      - unit_price
      - units_in_stock
      - units_on_order
      - reorder_level
      - discontinued
{% endset %}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}
{%- set source_model = metadata_dict.get('source_model') -%}
{%- set rsrc = metadata_dict.get('rsrc') -%}
{%- set hashed_columns = metadata_dict.get('hashed_columns') -%}
{{ datavault4dbt.stage(
  source_model=source_model,
  rsrc=rsrc,
  hashed_columns=hashed_columns
) }}