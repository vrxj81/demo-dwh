WITH raw_data AS (
    SELECT model_entities::jsonb as data
    FROM {{ source('ellie', 'metadata') }}
),
entities AS (
    SELECT
        entity ->> 'id' AS entity_id,
        entity ->> 'name' AS entity_name,
        entity ->> 'createdAt' AS entity_created_at,
        entity ->> 'updatedAt' AS entity_updated_at
    FROM raw_data,
    LATERAL jsonb_array_elements(data) AS entity
)

SELECT *
FROM entities
