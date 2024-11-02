{{
  config(
    alias = 'customer_h'
    )
}}

with bv_customer_h as (
  select *
  from {{ ref('customer_h')}}
)
select * from bv_customer_h