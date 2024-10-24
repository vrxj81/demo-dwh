WITH raw_data AS (
    SELECT model_entities::jsonb as data
    FROM {{ source('ellie', 'metadata') }}
),
entities AS (
    SELECT
        entity ->> 'id' AS entity_id,
        entity -> 'attributes' AS attributes_json
    FROM raw_data,
    LATERAL jsonb_array_elements(data) AS entity
),
attributes AS (
    SELECT
        e.entity_id,
        attribute ->> 'id' AS attribute_id,
        attribute ->> 'name' AS attribute_name,
        (attribute ->> 'order')::int AS attribute_order,
        (attribute -> 'metadata' ->> 'PK')::boolean AS is_pk,
        (attribute -> 'metadata' ->> 'FK')::boolean AS is_fk
        attribute ->> 'created_at' AS attribute_created_at,
        attribute ->> 'updated_at' AS attribute_updated_at,
    FROM entities e,
    LATERAL jsonb_array_elements(e.attributes_json) AS attribute
)

SELECT *
FROM attributes
