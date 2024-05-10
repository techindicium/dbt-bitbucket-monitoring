with
    renamed as (
        select
            name as branch_name
            , type as branch_type
            , cast(target:author:user:accountId as varchar) as target_author_accountid
            , cast(target:author:user:displayName as varchar) as target_author_displayname
            , cast(target:author:user:nickname as varchar) as target_author_nickname
            , cast(target:author:user:"TYPE" as varchar) as target_author_type
            , cast(target:author:user:uuid as varchar) as target_author_uuid
            , cast(target:"DATE" as timestamp) as target_date
            , cast(target:"HASH" as varchar) as target_hash
            , cast(target:"MESSAGE" as varchar) as target_message
            , cast(target:parents:"HASH" as varchar) as target_parents_hash
            , cast(target:repository:fullName as varchar) as target_repository_fullname
            , cast(target:repository:"NAME" as varchar) as target_repository_name
            , cast(target:repository:"TYPE" as varchar) as target_repository_type
            , cast(target:repository:uuid as varchar) as target_repository_uuid
            , cast(target:"TYPE" as varchar) as target_type
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'branches') }}
    )

select *
from renamed