{%- set yaml_metadata -%}
control_snap_v0: snapshot_control_v0
log_logic:
  daily:
    duration: 3
    unit: 'MONTH'
  weekly:
    duration: 1
    unit: 'YEAR'
  monthly:
    duration: 5
    unit: 'YEAR'
  yearly:
    forever: true
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) %}
{%- set control_snap_v0 = metadata_dict.get('control_snap_v0') %}
{%- set log_logic = metadata_dict.get('log_logic') %}

{{ datavault4dbt.control_snap_v1(control_snap_v0=control_snap_v0, log_logic=log_logic) }}