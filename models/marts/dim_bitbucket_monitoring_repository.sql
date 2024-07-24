with
    repository as (
        select distinct
            repository_uuid
            , repository_fullname
            , repository_name
            , repository_type
        from {{ ref('stg_bitbucket_monitoring_commits') }}
    )

, repository_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['repository_uuid']) }} as repository_sk
            , repository_uuid
            , repository_fullname
            , repository_name
            , repository_type
        from repository
)

select *
from repository_sk