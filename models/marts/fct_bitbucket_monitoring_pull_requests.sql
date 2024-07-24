with
    dim_author as (
        select *
        from {{ ref('dim_bitbucket_monitoring_author') }}
    )

    , dim_repository as (
        select *
        from {{ ref('dim_bitbucket_monitoring_repository') }}
    )

    , stg_pullrequests as (
        select
            pullrequest_title
            , pullrequest_description
            , pullrequest_type
            , created_on
            , pullrequest_state
            , pullrequest_reason
            , updated_on
            , close_source_branch
            , pullrequest_id
            , comment_count
            , task_count
            , commit_count
            , merged_at
            , files_changed
            , lines_added
            , lines_deleted
            , destination_branch_name
            , destination_commit_hash
            , destination_commit_type
            , destination_repository_name
            , destination_repository_uuid
            , source_branch_name
            , source_commit_hash
            , source_commit_type
            , source_repository_name
            , source_repository_uuid
            , author_displayname
            , author_uuid
            , merge_commit_hash
            , merge_commit_type
            , closed_by_displayname
            , closed_by_uuid
            , extracted_at
        from {{ ref('stg_bitbucket_monitoring_pull_requests') }}
    )

    , joined as (
        select
            dim_author.author_sk as author_fk
            , dim_repository.repository_sk as repository_fk
            , stg_pullrequests.pullrequest_title
            , stg_pullrequests.pullrequest_description
            , stg_pullrequests.pullrequest_type
            , stg_pullrequests.created_on
            , stg_pullrequests.pullrequest_state
            , stg_pullrequests.updated_on
            , stg_pullrequests.close_source_branch
            , stg_pullrequests.pullrequest_id
            , stg_pullrequests.comment_count
            , stg_pullrequests.task_count
            , stg_pullrequests.commit_count
            , stg_pullrequests.merged_at
            , stg_pullrequests.files_changed
            , stg_pullrequests.lines_added
            , stg_pullrequests.lines_deleted
            , stg_pullrequests.destination_branch_name
            , stg_pullrequests.destination_commit_hash
            , stg_pullrequests.destination_commit_type
            , stg_pullrequests.destination_repository_name
            , stg_pullrequests.destination_repository_uuid
            , stg_pullrequests.source_branch_name
            , stg_pullrequests.source_commit_hash
            , stg_pullrequests.source_commit_type
            , stg_pullrequests.source_repository_name
            , stg_pullrequests.source_repository_uuid
            , stg_pullrequests.author_displayname
            , stg_pullrequests.author_uuid
            , stg_pullrequests.merge_commit_hash
            , stg_pullrequests.merge_commit_type
            , stg_pullrequests.closed_by_displayname
            , stg_pullrequests.closed_by_uuid
            , stg_pullrequests.extracted_at
        from stg_pullrequests
        left join dim_author on stg_pullrequests.author_uuid = dim_author.author_uuid
        left join dim_repository on stg_pullrequests.source_repository_uuid = dim_repository.repository_uuid
    )
    
    , pullrequest_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['pullrequest_id']) }} as pullrequest_sk
            , *
        from joined
    )

select *
from pullrequest_sk