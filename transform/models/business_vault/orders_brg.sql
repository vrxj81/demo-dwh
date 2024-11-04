with orders as (
  select
    link.hk_order_l,
    link.hk_order_h,
    link.hk_customer_h,
    link.hk_employee_h,
    link.ldts,
    sat.order_date,
    sat.required_date
  from {{ ref('order_l') }} link
  inner join {{ ref('order_northwind_s') }} sat
  on sat.hk_order_l = link.hk_order_l
),
order_details as (
  select
    link.hk_order_details_l,
    link.hk_order_h,
    link.hk_product_h,
    sat.unit_price,
    sat.quantity,
    sat.discount
  from {{ ref('order_details_l') }} link
  inner join {{ ref('order_details_s') }} sat
  on sat.hk_order_details_l = link.hk_order_details_l
)
select
  o.hk_order_h,
  o.hk_customer_h,
  o.hk_employee_h,
  od.hk_product_h,
  o.ldts,
  o.order_date,
  o.required_date,
  od.unit_price,
  od.quantity,
  od.discount,
  od.unit_price * od.quantity * (1 - od.discount) as total_price
from orders o
inner join order_details od
on o.hk_order_h = od.hk_order_h