with
    renamed as (
        select
            uuid as pipeline_uuid
            , type as pipeline_type
            , buildnumber as pipeline_buildnumber
            , createdon as created_on
            , completedon as completed_on
            , runnumber as pipeline_runnumber
            , durationinseconds as duration_in_seconds
            , buildsecondsused as build_in_seconds
            , firstsuccessful as first_successfull
            , expired
            , hasvariables as has_variables
            , cast(repository:fullName as varchar) as repository_fullname
            , cast(repository:name as varchar) as repository_name
            , cast(repository:type as varchar) as repository_type
            , cast(repository:uuid as varchar) as repository_uuid
            , cast(state:name as varchar) as state_name
            , cast(state:stage:name as varchar) as state_stage_name
            , cast(state:stage:type as varchar) as state_stage_type
            , cast(state:type as varchar) as state_type
            , cast(creator:accountId as varchar) as creator_accountid
            , cast(creator:displayName as varchar) as creator_displayname
            , cast(creator:nickname as varchar) as creator_nickname
            , cast(creator:type as varchar) as creator_type
            , cast(creator:uuid as varchar) as creator_uuid
            , cast(target:commit:hash as varchar) as target_commit_hash
            , cast(target:commit:type as varchar) as target_commit_type
            , cast(target:refName as varchar) as target_refname
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'pipelines') }}
    )

select *
from renamed