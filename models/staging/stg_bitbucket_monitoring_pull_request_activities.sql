with
    renamed as (
        select
            cast(pullrequest:id as varchar) as pullrequest_id
            , cast(pullrequest:title as varchar) as pullrequest_tittle
            , cast(pullrequest:type as varchar) as pullrequest_type
            , cast(pullrequest:workspace as varchar) as pullrequest_workspace
            , cast(pullrequestupdatedon as timestamp) as pullrequest_updated_on
            , cast(approval:date as timestamp) as approval_date
            , cast(approval:pullrequest:id as varchar) as approval_pr_id
            , cast(approval:pullrequest:tittle as varchar) as approval_pr_tittle
            , cast(approval:pullrequest:type as varchar) as approval_pr_type
            , cast(approval:user:accountId as varchar) as approval_user_accountid
            , cast(approval:user:displayName as varchar) as approval_user_displayname
            , cast(approval:user:nickname as varchar) as approval_user_nickname
            , cast(approval:user:type as varchar) as approval_user_type
            , cast(approval:user:uuid as varchar) as approval_user_uuid
            , cast("UPDATE":author:accountid as varchar) as update_author_accountid
            , cast("UPDATE":author:displayName as varchar) as update_author_displayname
            , cast("UPDATE":author:nickname as varchar) as update_author_nickname
            , cast("UPDATE":author:type as varchar) as update_author_type
            , cast("UPDATE":author:uuid as varchar) as update_author_uuid
            , cast("UPDATE":date as timestamp) as update_date
            , cast("UPDATE":description as varchar) as update_description
            , cast("UPDATE":destination:branch:name as varchar) as update_destination_branch
            , cast("UPDATE":destination:commit:hash as varchar) as update_destination_commit_hash
            , cast("UPDATE":destination:repository:fullName as varchar) as update_destination_repository_fullname
            , cast("UPDATE":destination:repository:name as varchar) as update_destination_repository_name
            , cast("UPDATE":destination:repository:uuid as varchar) as update_destination_repository_uuid
            , cast("UPDATE":destination:reason as varchar) as update_destination_reason
            , cast("UPDATE":destination:reviewers:accountI as varchar) as update_destination_reviewers_accountid
            , cast("UPDATE":destination:reviewers:displayname as varchar) as update_destination_reviewers_displayname
            , cast("UPDATE":destination:reviewers:nickname as varchar) as update_destination_reviewers_nickname
            , cast("UPDATE":destination:reviewers:type as varchar) as update_destination_reviewers_type
            , cast("UPDATE":destination:reviewers:uuid as varchar) as update_destination_reviewers_uuid
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'pull_request_activities') }}
    )

select *
from renamed