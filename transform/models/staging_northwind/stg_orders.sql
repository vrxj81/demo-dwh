{%- set yaml_metadata -%}
source_model:
  'source-northwind': 'orders'
rsrc: '!Northwind.orders'
hashed_columns:
  hk_order_h:
    - order_id
  hk_employee_h:
    - employee_id
  hk_customer_h:
    - customer_id
  hk_shipper_h:
    - ship_via
  hk_order_l:
    - customer_id
    - employee_id
    - order_id
  hk_shipment_l:
    - order_id
    - ship_via
  hd_order_s:
    is_hashdiff: true
    columns:
      - order_date
      - required_date
  hd_shipment_s:
    is_hashdiff: true
    columns:
      - ship_name
      - ship_address
      - ship_city
      - ship_region
      - ship_postal_code
      - ship_country
      - shipped_date
      - freight
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