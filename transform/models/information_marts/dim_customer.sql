with customer_d as (
  select
    hub.hk_customer_h,
    sat.ldts as valid_from,
    coalesce(lead(sat.ldts) over (partition by sat.hk_customer_h order by sat.ldts), {{ datavault4dbt.string_to_timestamp(timestamp_format, end_of_all_times) }}) as valid_to,
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax
  from {{ ref('customer_h') }} hub 
  inner join {{ ref('customer_northwind_ed_s') }} sat
  on hub.hk_customer_h = sat.hk_customer_h
)
select * from customer_d