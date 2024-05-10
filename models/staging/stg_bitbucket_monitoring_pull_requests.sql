with
    renamed as (
        select
            title as pullrequest_title
            , description as pullrequest_description
            , type as pullrequest_type
            , cast(createdon as timestamp) as created_on
            , state as pullrequest_state
            , reason as pullrequest_reason
            , cast(updatedon as timestamp) as updated_on
            , closesourcebranch as close_source_branch
            , id as pullrequest_id
            , commentcount as comment_count
            , taskcount as task_count
            , cast(calculatedactivity:commitcount as varchar) as commit_count
            , cast(calculatedactivity:mergedat as varchar) as merged_at
            , cast(diffstat:fileschanged as varchar) as files_changed
            , cast(diffstat:linesadded as varchar) as lines_added
            , cast(diffstat:linesdeleted as varchar) as lines_deleted
            , cast(destination:branch:name as varchar) as destination_branch_name
            , cast(destination:commit:hash as varchar) as destination_commit_hash
            , cast(destination:commit:type as varchar) as destination_commit_type
            , cast(destination:repository:fullName as varchar) as destination_repository_fullname
            , cast(destination:repository:name as varchar) as destination_repository_name
            , cast(destination:repository:type as varchar) as destination_repository_type
            , cast(destination:repository:uuid as varchar) as destination_repository_uuid
            , cast(source:branch:name as varchar) as source_branch_name
            , cast(source:commit:hash as varchar) as source_commit_hash
            , cast(source:commit:type as varchar) as source_commit_type
            , cast(source:repository:fullName as varchar) as source_repository_fullname
            , cast(source:repository:name as varchar) as source_repository_name
            , cast(source:repository:type as varchar) as source_repository_type
            , cast(source:repository:uuid as varchar) as source_repository_uuid
            , cast(author:accountId as varchar) as author_accountid
            , cast(author:displayName as varchar) as author_displayname
            , cast(author:nickname as varchar) as author_nickname
            , cast(author:type as varchar) as author_type
            , cast(author:uuid as varchar) as author_uuid
            , cast(mergecommit:hash as varchar) as merge_commit_hash
            , cast(mergecommit:type as varchar) as merge_commit_type
            , cast(closedby:accountId as varchar) as closed_by_accountid
            , cast(closedby:displayName as varchar) as closed_by_displayname
            , cast(closedby:nickname as varchar) as closed_by_nickname
            , cast(closedby:type as varchar) as closed_by_type
            , cast(closedby:uuid as varchar) as closed_by_uuid
            , _SDC_EXTRACTED_AT as extracted_at
        from {{ source('raw_bitbucket', 'pull_requests') }}
    )

select *
from renamed