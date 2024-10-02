#!/bin/bash

# ====================================================================
# Script Name: create_random_commits.sh
# Description: Automates the creation of random Git commits on random dates
#              within a specified date range.
# Author: Ankur
# Date: 2024-09-01
# ====================================================================

# Path to your local Git repository
REPO_PATH="C:\Users\ankur\Github\read-me"

# Array of commit messages
commit_messages=(
    Add project title and initial description
Add installation instructions section
Include usage examples section
Add configuration details section
Add contribution guidelines
Include license information
Add project setup prerequisites
Add quick start guide
Expand installation instructions
Add troubleshooting tips
Update usage examples with new features
Add API documentation section
Include FAQ section
Update contribution guidelines with code style rules
Add information about code of conduct
Update license information with license type
Add acknowledgements section
Include detailed installation steps
Add links to external resources
Update project setup prerequisites with additional details
Add detailed usage scenarios
Include examples of configuration files
Add changelog section
Update API documentation with new endpoints
Include contact information for maintainers
Add a section on project goals and objectives
Update FAQ with new common questions
Expand troubleshooting tips with common issues
Add a section on known issues
Update acknowledgements with contributors
Add release notes section
Include screenshots of the project in action
Update project goals and objectives with recent changes
Add a glossary of terms used in the project
Update contribution guidelines with new processes
Add instructions for running tests
Include a section on how to report bugs
Update configuration details with example setups
Add a section on performance considerations
Include a section on security practices
Update installation instructions with new dependencies
Add migration guide for version updates
Include a section on advanced usage
Update usage examples with user feedback
Add a section on project architecture
Include a roadmap of future features
Update troubleshooting tips with recent issues
Add a section on community and support
Update contact information with new team members
Add a final review and polish the README
)

# Check if repository path exists
if [ ! -d "$REPO_PATH" ]; then
    echo "Error: Repository path '$REPO_PATH' does not exist."
    exit 1
fi

# Navigate to the repository
cd "$REPO_PATH" || { echo "Failed to navigate to repository."; exit 1; }

# Function to create or modify a file with meaningful content
modify_file() {
    local file_path="$1"
    local commit_message="$2"

    # Create the file if it doesn't exist
    if [ ! -f "$file_path" ]; then
        touch "$file_path"
        echo "# $(basename "$file_path" .md | awk '{print toupper($0)}')" > "$file_path"
    fi

    # Append a line related to the commit message
    echo "$commit_message - Updated on $(date +"%Y-%m-%d")" >> "$file_path"
}

# Function to generate a random date within a specific range
generate_random_date() {
    local start_date=$(date -d "2024-04-05" +%s)
    local end_date=$(date -d "2024-04-11" +%s)
    local random_date=$(date -d @$((start_date + RANDOM % (end_date - start_date))) +"%Y-%m-%d")
    echo $random_date
}

# Ensure the repository has at least one commit
if [ -z "$(git rev-parse --verify HEAD 2>/dev/null)" ]; then
    echo "Repository is empty. Creating an initial commit."
    touch README.md
    git add README.md
    git commit -m "Initial commit"
fi

# Get the starting commit number
get_last_commit_number() {
    last_file=$(ls file*.txt 2>/dev/null | sort -V | tail -n 1)
    if [[ $last_file =~ file([0-9]+)\.txt ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "0"
    fi
}

last_commit=$(get_last_commit_number)

# Iterate over the date range and create random commits
current_date="2024-09-17"
end_date="2024-09-30"

while [[ "$current_date" < "$end_date" ]]; do
    num_commits=$((RANDOM % 4 + 2))  # Random number between 2 and 5

    for (( j=0; j<$num_commits; j++ )); do
        commit_number=$((last_commit + 1))
        commit_message=${commit_messages[$((RANDOM % ${#commit_messages[@]}))]}
        last_commit=$((last_commit + 1))

        # Create or modify a file
        file_name="file${commit_number}.txt"
        modify_file $file_name "$commit_message"

        # Stage the file
        git add "$file_name"

        # Ensure the file is staged
        if git diff --cached --name-only | grep -q "$file_name"; then
            # Generate a random time on the current date
            commit_time=$(date -d "$current_date $((RANDOM % 24)):$((RANDOM % 60)):00" +"%Y-%m-%d %H:%M:%S")
            GIT_AUTHOR_DATE="$commit_time" GIT_COMMITTER_DATE="$commit_time" git commit -m "$commit_message"
            echo "Committed '$commit_message' on $commit_time"
        else
            echo "Failed to stage $file_name"
        fi
    done

    # Move to the next day
    current_date=$(date -I -d "$current_date + 1 day")
done

# Display the commit log for review
echo "Displaying the git commit log..."
git log --oneline

echo "Review the commits with 'git log'. Use 'git push' to push the commits to GitHub."
