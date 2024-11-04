with orders_f as (
  select
    hk_order_h as hk_order_d,
    hk_customer_h as hk_customer_d,
    hk_employee_d,
    hk_product_h as d_product_key,
    order_date,
    required_date,
    unit_price,
    quantity,
    discount,
    total_price
  from {{ ref('orders_brg') }} brg
  inner join {{ ref('employee_pit') }} pit
  on pit.hk_employee_h = brg.hk_employee_h
  and pit.sdts <= brg.ldts
)
select * from orders_f