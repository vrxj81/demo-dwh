with product_d as (
  select
    hub.hk_product_h,
    sat.ldts as valid_from,
    coalesce(lead(sat.ldts) over (partition by sat.hk_product_h order by sat.ldts), {{ datavault4dbt.string_to_timestamp(timestamp_format, end_of_all_times) }}) as valid_to,
    product_id,
    product_name,
    quantity_per_unit,
    unit_price,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued
  from {{ ref('product_h') }} hub
  inner join {{ ref('product_northwind_ed_s') }} sat
  on hub.hk_product_h = sat.hk_product_h
)
select * from product_d