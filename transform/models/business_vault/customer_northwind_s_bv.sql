{{
  config(
    alias = 'customer_northwind_s',
    )
}}

with customer_sat as (
  select
    *
  from {{ ref('customer_northwind_s') }}
)
select
  *
from customer_sat