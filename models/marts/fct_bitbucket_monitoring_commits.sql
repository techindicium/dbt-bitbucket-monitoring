with
    dim_author as (
        select *
        from {{ ref('dim_bitbucket_monitoring_author') }}
    )

    , dim_repository as (
        select *
        from {{ ref('dim_bitbucket_monitoring_repository') }}
    )

    , stg_commits as (
        select
            commit_hash
            , commit_date
            , commit_message
            , commit_type
            , repository_name
            , repository_uuid
            , author_displayname
            , author_uuid
            , parents_hash
            , parents_type
            , extracted_at
        from {{ ref('stg_bitbucket_monitoring_commits') }}
    )

    , joined as (
        select
            dim_author.author_sk as author_fk
            , dim_repository.repository_sk as repository_fk
            , stg_commits.commit_hash
            , stg_commits.commit_date
            , stg_commits.commit_message
            , stg_commits.commit_type
            , stg_commits.repository_name
            , stg_commits.repository_uuid
            , stg_commits.author_displayname
            , stg_commits.author_uuid
            , stg_commits.parents_hash
            , stg_commits.parents_type
            , stg_commits.extracted_at
        from stg_commits
        left join dim_author on stg_commits.author_uuid = dim_author.author_uuid
        left join dim_repository on stg_commits.repository_uuid = dim_repository.repository_uuid
    )
select *
from joined