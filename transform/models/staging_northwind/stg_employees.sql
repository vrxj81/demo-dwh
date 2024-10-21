{% set yaml_metadata %}
source_model:
  'source-northwind': 'employees'
rsrc: '!Northwind.employees'
hashed_columns:
  hk_employee_h:
    - employee_id
  hd_employee_personal_s:
    is_hashdiff: true
    columns:
      - last_name
      - first_name
      - title
      - title_of_courtesy
      - birth_date
      - hire_date
      - photo_path
      - notes
      - reports_to
  hd_employee_address_s:
    is_hashdiff: true
    columns:
      - address
      - city
      - region
      - postal_code
      - country
  hd_employee_contact_s:
    is_hashdiff: true
    columns:
      - home_phone
      - extension
      - photo
{% endset %}
{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict.get('source_model') %}
{% set rsrc = metadata_dict.get('rsrc') %}
{% set hashed_columns = metadata_dict.get('hashed_columns') %}
{{ datavault4dbt.stage(
  source_model=source_model,
  rsrc=rsrc,
  hashed_columns=hashed_columns
) }}
