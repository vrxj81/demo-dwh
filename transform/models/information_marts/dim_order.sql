with order_d as (
  select
    hk_order_h,
    order_id
  from {{ ref('order_h') }} hub
)
select * from order_d