#!/bin/zsh

function cleanup_my_branches() {
    local DEFAULT_BASE_BRANCH=""
    
    # Try to detect default branch
    if git rev-parse --verify "main" >/dev/null 2>&1; then
        DEFAULT_BASE_BRANCH="main"
    elif git rev-parse --verify "master" >/dev/null 2>&1; then
        DEFAULT_BASE_BRANCH="master"
    fi
    
    # Prompt for base branch with default suggestion
    read "base_branch?Enter the base branch to compare against [${DEFAULT_BASE_BRANCH}]: "
    base_branch=${base_branch:-$DEFAULT_BASE_BRANCH}

    # Validate base branch input
    if [[ "$base_branch" != "master" && "$base_branch" != "main" ]]; then
        echo "Invalid branch. Please enter 'master' or 'main'."
        return 1
    fi

    # Ensure we're on an actual branch
    local current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        echo "Not on any branch. Please checkout a branch first."
        return 1
    fi

    # Fetch latest changes
    echo "Fetching latest changes from remote..."
    if ! git ls-remote --quiet origin >/dev/null 2>&1; then
        echo "Warning: Cannot connect to remote repository"
    elif ! git fetch origin --quiet; then
        echo "Warning: Unable to fetch changes"
    else
        echo "✓ Remote changes fetched successfully"
    fi

    # Get user email for branch ownership check
    local user_email=$(git config user.email)
    if [[ -z "$user_email" ]]; then
        echo "Unable to determine your git email. Please configure git user.email"
        return 1
    fi

    # Optional: Prompt for story/ticket number
    read "story_number?Enter story/ticket number (leave empty for all your branches): "

    # Find branches that you created/last committed to
    local my_branches=()
    local skipped_branches=()
    local protected_branches=($base_branch $current_branch)
    
    echo "\nAnalyzing branches..."
    
    while IFS= read -r branch; do
        branch="${branch#"${branch%%[! ]*}"}" # trim leading whitespace
        branch="${branch# }" # Remove potential leading space
        branch="${branch#\* }" # Remove potential asterisk from current branch
        
        # Skip if branch is empty or protected
        [[ -z "$branch" || " ${protected_branches[@]} " =~ " ${branch} " ]] && continue

        # Check branch ownership and merge status
        if [[ -z "$(git rev-parse --verify "$branch" 2>/dev/null)" ]]; then
            continue
        fi

        local last_committer=$(git log -1 --format='%ae' "$branch" 2>/dev/null)
        
        # If this is your branch and matches story number if provided
        if [[ "$last_committer" == "$user_email" || \
              ( -z "$last_committer" && -n "$(git rev-parse --verify "$branch" 2>/dev/null)" ) ]] && \
           [[ -z "$story_number" || "$branch" =~ "$story_number" ]]; then
            
            # Check if branch is merged or empty
            if git branch --merged "$base_branch" | grep -q "^[* ]*${branch}$" || \
               [[ -z "$(git rev-parse --verify "$branch^{commit}" 2>/dev/null)" ]]; then
                my_branches+=("$branch")
            else
                # Check if branch has any unique commits
                local unique_commits=$(git log "$base_branch..$branch" --oneline 2>/dev/null | wc -l)
                if (( unique_commits == 0 )); then
                    my_branches+=("$branch")  # Branch is effectively merged
                else
                    skipped_branches+=("$branch")
                fi
            fi
        fi
    done < <(git branch)

    if (( ${#my_branches[@]} == 0 )); then
        echo "\nNo branches found that match your criteria."
        if [[ -n "$story_number" ]]; then
            echo "No branches found matching story number: $story_number"
        fi
        
        if (( ${#skipped_branches[@]} > 0 )); then
            echo "\nUnmerged branches that were skipped:"
            printf '%s\n' "${skipped_branches[@]}"
        fi
        return 0
    fi

    echo "\nFound ${#my_branches[@]} eligible branches for cleanup:"
    printf '%s\n' "${my_branches[@]}"
    
    if (( ${#skipped_branches[@]} > 0 )); then
        echo "\nSkipping ${#skipped_branches[@]} unmerged branches:"
        printf '%s\n' "${skipped_branches[@]}"
    fi

    # Batch deletion option
    read "batch_delete?Do you want to delete all eligible branches at once? (y/n): "
    if [[ "$batch_delete" =~ ^[Yy]$ ]]; then
        echo "\nProcessing batch deletion..."
        local deleted_count=0
        local remote_deleted_count=0
        local failed_deletions=()
        local failed_remote_deletions=()
        
        for branch in "${my_branches[@]}"; do
            echo "\nProcessing '$branch'..."
            
            # Verify branch still exists and is still merged
            if ! git rev-parse --verify "$branch" >/dev/null 2>&1; then
                echo "Branch no longer exists, skipping..."
                continue
            fi
            
            if ! git branch --merged "$base_branch" | grep -q "^[* ]*${branch}$"; then
                local unique_commits=$(git log "$base_branch..$branch" --oneline 2>/dev/null | wc -l)
                if (( unique_commits > 0 )); then
                    echo "Branch is no longer merged, skipping..."
                    continue
                fi
            fi
            
            if git branch -d "$branch" 2>/dev/null; then
                ((deleted_count++))
                echo "Deleted local branch"
                
                # Check if branch exists on remote
                if git ls-remote --heads origin "$branch" &>/dev/null; then
                    if git push origin --delete "$branch" 2>/dev/null; then
                        ((remote_deleted_count++))
                        echo "Deleted remote branch"
                    else
                        failed_remote_deletions+=("$branch")
                        echo "Failed to delete remote branch"
                    fi
                fi
            else
                failed_deletions+=("$branch")
                echo "Failed to delete local branch"
            fi
        done
        
        echo "\nCleanup Summary:"
        if (( deleted_count > 0 )); then
            echo "✓ Successfully deleted $deleted_count local branches"
            echo "✓ Successfully deleted $remote_deleted_count remote branches"
        else
            echo "No branches were deleted"
        fi
        
        if (( ${#failed_deletions[@]} > 0 )); then
            echo "\n❌ Failed to delete these local branches:"
            printf '%s\n' "${failed_deletions[@]}"
        fi
        
        if (( ${#failed_remote_deletions[@]} > 0 )); then
            echo "\n❌ Failed to delete these remote branches:"
            printf '%s\n' "${failed_remote_deletions[@]}"
        fi
    else
        # Individual deletion mode
        echo "\nProcessing branches individually..."
        for branch in "${my_branches[@]}"; do
            read "delete_branch?Delete branch '$branch'? (y/n): "
            if [[ "$delete_branch" =~ ^[Yy]$ ]]; then
                if git branch -d "$branch" 2>/dev/null; then
                    echo "Deleted local branch '$branch'"
                    
                    if git ls-remote --heads origin "$branch" &>/dev/null; then
                        read "delete_remote?Delete remote branch 'origin/$branch'? (y/n): "
                        if [[ "$delete_remote" =~ ^[Yy]$ ]]; then
                            if git push origin --delete "$branch" 2>/dev/null; then
                                echo "Deleted remote branch 'origin/$branch'"
                            else
                                echo "Failed to delete remote branch 'origin/$branch'"
                            fi
                        fi
                    fi
                else
                    echo "Failed to delete local branch '$branch'"
                fi
            fi
        done
    fi

    # Show remaining branches status
    echo "\nYour remaining branches:"
    while IFS= read -r branch; do
        branch="${branch#"${branch%%[! ]*}"}" # trim leading whitespace
        branch="${branch# }" # Remove potential leading space
        branch="${branch#\* }" # Remove potential asterisk from current branch
        
        [[ -z "$branch" ]] && continue
        
        local last_committer=$(git log -1 --format='%ae' "$branch" 2>/dev/null)
        if [[ "$last_committer" == "$user_email" ]]; then
            local is_merged=""
            if git branch --merged "$base_branch" | grep -q "^[* ]*${branch}$"; then
                is_merged="(merged)"
            else
                is_merged="(not merged)"
            fi
            echo "- $branch $is_merged"
        fi
    done < <(git branch)
}

# Set up an alias
alias cleanup="cleanup_my_branches"
