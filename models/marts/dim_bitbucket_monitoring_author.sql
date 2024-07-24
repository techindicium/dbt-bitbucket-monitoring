with
    author as (
        select distinct
            author_uuid
            , author_type
            , author_accountid
            , author_displayname
            , author_nickname
        from {{ ref('stg_bitbucket_monitoring_commits') }}
    )

, author_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['author_uuid']) }} as author_sk
            , author_uuid            
            , author_type
            , author_accountid
            , author_displayname
            , author_nickname
        from author
)

select *
from author_sk