with
    dim_author as (
        select *
        from {{ ref('dim_bitbucket_monitoring_author') }}
    )

    , dim_repository as (
        select *
        from {{ ref('dim_bitbucket_monitoring_repository') }}
    )

    , stg_pipelines as (
        select
            pipeline_uuid
            , pipeline_type
            , pipeline_buildnumber
            , created_on
            , completed_on
            , pipeline_runnumber
            , duration_in_seconds
            , build_in_seconds
            , first_successfull
            , expired
            , has_variables
            , repository_fullname
            , repository_name
            , repository_type
            , repository_uuid
            , state_name
            , state_stage_name
            , state_stage_type
            , state_type
            , creator_accountid
            , creator_displayname
            , creator_nickname
            , creator_type
            , creator_uuid
            , target_commit_hash
            , target_commit_type
            , target_refname
            , extracted_at
        from {{ ref('stg_bitbucket_monitoring_pipelines') }}
    )

    , joined as (
        select
            dim_author.author_sk as author_fk
            , dim_repository.repository_sk as repository_fk
            , stg_pipelines.pipeline_uuid
            , stg_pipelines.pipeline_type
            , stg_pipelines.pipeline_buildnumber
            , stg_pipelines.created_on
            , stg_pipelines.completed_on
            , stg_pipelines.pipeline_runnumber
            , stg_pipelines.duration_in_seconds
            , stg_pipelines.build_in_seconds
            , stg_pipelines.first_successfull
            , stg_pipelines.expired
            , stg_pipelines.has_variables
            , stg_pipelines.repository_name
            , stg_pipelines.repository_uuid
            , stg_pipelines.state_name
            , stg_pipelines.state_stage_name
            , stg_pipelines.creator_displayname
            , stg_pipelines.creator_uuid
            , stg_pipelines.target_commit_hash
            , stg_pipelines.target_commit_type
            , stg_pipelines.target_refname
            , stg_pipelines.extracted_at
        from stg_pipelines
        left join dim_author on stg_pipelines.creator_uuid = dim_author.author_uuid
        left join dim_repository on stg_pipelines.repository_uuid = dim_repository.repository_uuid
    )    
    
    , pipeline_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['pipeline_uuid']) }} as pipeline_sk
            , *
        from joined
    )

select *
from pipeline_sk