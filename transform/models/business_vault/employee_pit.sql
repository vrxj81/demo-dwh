{{
  config(
    materialized = 'incremental',
    post_hook="{{ datavault4dbt.clean_up_pit('snapshot_control_v1') }}"
    )
}}

{%- set yaml_metadata -%}
tracked_entity: employee_h
hashkey: hk_employee_h
sat_names:
  - employee_northwind_contact_ed_s
  - employee_northwind_personal_ed_s
  - employee_northwind_address_ed_s
snapshot_relation: snapshot_control_v1
dimension_key: hk_employee_d
custom_rsrc: 'PIT for Employees'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) %}
{%- set tracked_entity = metadata_dict.get('tracked_entity') %}
{%- set hashkey = metadata_dict.get('hashkey') %}
{%- set sat_names = metadata_dict.get('sat_names') %}
{%- set snapshot_relation = metadata_dict.get('snapshot_relation') %}
{%- set dimension_key = metadata_dict.get('dimension_key') %}
{%- set custom_rsrc = metadata_dict.get('custom_rsrc') %}

{{
  datavault4dbt.pit(
    tracked_entity=tracked_entity,
    hashkey=hashkey,
    sat_names=sat_names,
    snapshot_relation=snapshot_relation,
    dimension_key=dimension_key,
    custom_rsrc=custom_rsrc
  )
}}