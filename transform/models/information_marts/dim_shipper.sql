with shipper_d as (
  select
    hub.hk_shipper_h,
    sat.ldts as valid_from,
    coalesce(lead(sat.ldts) over (partition by sat.hk_shipper_h order by sat.ldts), {{ datavault4dbt.string_to_timestamp(timestamp_format, end_of_all_times) }}) as valid_to,
    shipper_bk,
    company_name,
    phone
  from {{ ref('shipper_h') }} hub
  inner join {{ ref('shipper_northwind_s') }} sat
  on hub.hk_shipper_h = sat.hk_shipper_h
)
select * from shipper_d