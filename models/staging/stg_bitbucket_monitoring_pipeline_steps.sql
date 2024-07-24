with
    renamed as (
        select
            uuid as step_uuid
            , name as step_name
            , type as step_type
            , startedon as started_on
            , completedon as completed_on
            , runnumber as run_number
            , maxtime as max_time
            , buildsecondsused as build_seconds_used
            , durationinseconds as duration_in_seconds
            , cast(pipeline:type as varchar) as pipeline_type
            , cast(pipeline:uuid as varchar) as pipeline_uuid
            , cast(image:name as varchar) as image_name
            , cast(state:name as varchar) as state_name
            , cast(state:result:name as varchar) as state_result_name
            , cast(state:result:type as varchar) as state_result_type
            , cast(state:type as varchar) as state_type
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'pipeline_steps') }}
    )

select *
from renamed