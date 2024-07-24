with
    renamed as (
        select
            hash as commit_hash
            , cast(date as timestamp) as commit_date
            , message as commit_message
            , type as commit_type
            , cast(repository:fullName as varchar) as repository_fullname
            , cast(repository:name as varchar) as repository_name
            , cast(repository:type as varchar) as repository_type
            , cast(repository:uuid as varchar) as repository_uuid
            , cast(author:type as varchar) as author_type
            , cast(author:user:accountId as varchar) as author_accountid
            , cast(author:user:displayName as varchar) as author_displayname
            , cast(author:user:nickname as varchar) as author_nickname
            , cast(author:user:type as varchar) as author_user_type
            , cast(author:user:uuid as varchar) as author_uuid
            , cast(parents:hash as varchar) as parents_hash
            , cast(parents:type as varchar) as parents_type
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'commits') }}
    )

select *
from renamed