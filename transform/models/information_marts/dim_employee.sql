with employee_d as (
  select 
    hk_employee_d,
    sdts as valid_from,
    coalesce(lead(sdts) over (partition by employee_pit.hk_employee_h order by sdts), {{ datavault4dbt.string_to_timestamp(timestamp_format, end_of_all_times) }}) as valid_to,
    employee_id,
    last_name,
    first_name,
    title,
    title_of_courtesy,
    birth_date,
    hire_date,
    address,
    city,
    region,
    postal_code,
    country,
    home_phone,
    extension,
    photo,
    notes,
    reports_to
  from {{ ref('employee_pit') }}
  inner join {{ ref('employee_h')}}
  on employee_pit.hk_employee_h = employee_h.hk_employee_h
  inner join {{ ref('employee_northwind_personal_ed_s') }}
  on employee_pit.hk_employee_northwind_personal_ed_s = employee_northwind_personal_ed_s.hk_employee_h
  and employee_pit.ldts_employee_northwind_personal_ed_s = employee_northwind_personal_ed_s.ldts
  inner join {{ ref('employee_northwind_contact_ed_s') }}
  on employee_pit.hk_employee_northwind_contact_ed_s = employee_northwind_contact_ed_s.hk_employee_h
  and employee_pit.ldts_employee_northwind_contact_ed_s = employee_northwind_contact_ed_s.ldts
  inner join {{ ref('employee_northwind_address_ed_s') }}
  on employee_pit.hk_employee_northwind_address_ed_s = employee_northwind_address_ed_s.hk_employee_h
  and employee_pit.ldts_employee_northwind_address_ed_s = employee_northwind_address_ed_s.ldts
)
select * from employee_d