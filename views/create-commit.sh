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
    Added new feature for user authentication using JWT."
"Updated API routes to support RESTful design principles."
"Fixed bug in React component lifecycle causing re-renders."
"Optimized MongoDB queries for better performance."
"Implemented password hashing with bcrypt for security."
"Integrated cloud storage with AWS S3 for file uploads."
"Refactored Express server structure for cleaner codebase."
"Created reusable UI components using React and Material-UI."
"Migrated project to use MongoDB Atlas for database management."
"Enhanced validation logic with Joi for form inputs."
"Improved API response times by caching requests."
"Configured environment variables with dotenv for security."
"Added support for role-based access control (RBAC)."
"Updated Redux store to manage global state efficiently."
"Implemented real-time notifications with Socket.io."
"Fixed CORS issues in backend API requests."
"Set up automated testing with Jest and Enzyme."
"Improved error handling in async API requests."
"Optimized image loading for faster page performance."
"Added pagination to the API for better data handling."
"Integrated third-party OAuth login using Passport.js."
"Updated Docker configuration for seamless deployment."
"Enhanced SEO with dynamic meta tags for React pages."
"Implemented lazy loading for React routes."
"Added custom middleware to log API requests."
"Configured continuous integration with GitHub Actions."
"Refactored MongoDB schemas for scalability."
"Updated Webpack configuration for optimized build size."
"Added unit tests for core backend functionality."
"Set up email notifications using Nodemailer."
"Fixed memory leak issue in backend processes."
"Added Redux Thunk for async API calls in React."
"Updated ESLint configuration to enforce coding standards."
"Enhanced form validation with Yup for better UX."
"Improved security by implementing Helmet middleware."
"Added social media sharing buttons to the React app."
"Refactored CSS with Styled Components for cleaner design."
"Added Google Maps integration for location services."
"Set up GraphQL API for efficient data queries."
"Implemented Stripe payment gateway for transactions."
"Refined mobile responsiveness with custom breakpoints."
"Updated React Router for better navigation flow."
"Added new feature to export data in CSV format."
"Improved performance by using memoization in React."
"Set up MongoDB aggregation pipeline for complex queries."
"Refactored backend services for better modularity."
"Updated project documentation for better clarity."
"Added real-time search functionality with MongoDB text search."
"Fixed issue with React key props in dynamic lists."
"Added dark mode toggle for enhanced UX."
"Optimized server response times by using gzip compression."
"Updated client-side routing to handle 404 errors gracefully."
"Integrated Google Analytics for tracking user behavior."
"Added new feature to schedule tasks with node-cron."
"Fixed race condition in handling multiple API requests."
"Updated form handling to use React Hook Form."
"Improved mobile navigation with a custom drawer component."
"Added file upload progress indicators to the frontend."
"Enhanced security with rate limiting on API routes."
"Refactored Redux actions and reducers for better readability."
"Added feature to preview uploaded images before submission."
"Updated MongoDB connection pooling for better scalability."
"Implemented server-side rendering for improved SEO."
"Fixed issue with JWT token expiration and refresh logic."
"Updated React app to use functional components with hooks."
"Optimized bundle size by code-splitting React components."
"Improved user feedback with toast notifications on form submission."
"Refactored Express error handling middleware for better debugging."
"Added feature to reset password via email link."
"Improved database indexing for faster query performance."
"Refactored React context API for managing global state."
"Added push notifications for real-time updates in the app."
"Updated form inputs to support auto-completion."
"Integrated Google reCAPTCHA for better bot protection."
"Enhanced file upload security with file type validation."
"Fixed React useEffect dependency issues causing infinite loops."
"Added WebSocket support for live chat feature."
"Refactored server code to use async/await for better readability."
"Set up linting and formatting with Prettier and ESLint."
"Implemented conditional rendering for different user roles."
"Improved UX by adding loading spinners to async operations."
"Updated server-side logging with Winston for better traceability."
"Added MongoDB transaction support for atomic operations."
"Refactored Redux store to use Redux Toolkit for simpler state management."
"Enhanced API security by implementing CORS policies."
"Updated UI to support drag-and-drop file uploads."
"Fixed React state issues causing incorrect form resets."
"Optimized React app by removing unnecessary re-renders."
"Implemented Redis caching for frequently accessed data."
"Improved backend routing structure with nested routes."
"Updated project to use TypeScript for better type safety."
"Added analytics dashboard with real-time data visualization."
"Improved server security by sanitizing user inputs."
"Refactored project structure for better scalability and maintainability."
"Updated CI pipeline to run tests on every commit."
"Added support for multi-language localization in the app."
"Fixed issue with file upload path on production server."
"Improved form error messaging for a better user experience."
"Enhanced API rate limiting to prevent abuse."
"Optimized database connections with connection pooling.

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
