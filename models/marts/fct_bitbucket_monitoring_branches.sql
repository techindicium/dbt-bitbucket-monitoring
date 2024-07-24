with
    dim_author as (
        select *
        from {{ ref('dim_bitbucket_monitoring_author') }}
    )

    , dim_repository as (
        select *
        from {{ ref('dim_bitbucket_monitoring_repository') }}
    )

    , stg_branches as (
        select
            branch_name
            , branch_type
            , target_author_type
            , target_author_accountid
            , target_author_displayname
            , target_author_nickname
            , target_author_type
            , target_author_uuid
            , target_date
            , target_hash
            , target_message
            , target_parents_hash
            , target_repository_fullname
            , target_repository_name
            , target_repository_type
            , target_repository_uuid
            , target_type
            , extracted_at
        from {{ ref('stg_bitbucket_monitoring_branches') }}
    )

    , joined as (
        select
            dim_author.author_sk as author_fk
            , dim_repository.repository_sk as repository_fk
            , stg_branches.branch_name
            , stg_branches.branch_type
            , stg_branches.target_author_displayname
            , stg_branches.target_author_uuid
            , stg_branches.target_date
            , stg_branches.target_hash
            , stg_branches.target_message
            , stg_branches.target_parents_hash
            , stg_branches.target_repository_name
            , stg_branches.target_repository_uuid
            , stg_branches.target_type
            , stg_branches.extracted_at
        from stg_branches
        left join dim_author on stg_branches.target_author_uuid = dim_author.author_uuid
        left join dim_repository on stg_branches.target_repository_uuid = dim_repository.repository_uuid
    )

select *
from joined