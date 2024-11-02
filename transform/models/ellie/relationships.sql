WITH raw_data AS (
    SELECT model_relationships::jsonb AS data
    FROM {{ source('ellie', 'metadata') }}
),
relationships_expanded AS (
    SELECT
        relationship -> 'sourceEntity' ->> 'id' AS source_entity_id,
        relationship -> 'sourceEntity' ->> 'name' AS source_entity_name,
        relationship -> 'sourceEntity' ->> 'startType' AS source_start_type,
        relationship -> 'targetEntity' ->> 'id' AS target_entity_id,
        relationship -> 'targetEntity' ->> 'name' AS target_entity_name,
        relationship -> 'targetEntity' ->> 'endType' AS target_end_type,
        relationship -> 'description' AS description_json
    FROM raw_data,
    LATERAL jsonb_array_elements(data) AS relationship
)

SELECT
    source_entity_id,
    source_entity_name,
    source_start_type,
    target_entity_id,
    target_entity_name,
    target_end_type,
    description_json
FROM relationships_expanded
