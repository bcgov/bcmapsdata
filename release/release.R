# Source the functions we need. They are documented in the same file
source("release/release_functions.R")

# First tag the local bcmapsdata repo, then push the repo and the tags to GitHub
version <- tag_pkg_repo()

# Create a GitHub release for bcmapsdata
rel <- create_release(version)

# Upload the large layers (e.g., bec, tsa) which are stored in release/release-data
# to the GitHub release we just created
upload_release_attachments(release_url = rel$upload_url)

# Finally, build and add bcmapsdata to the bcgov drat repository 
# (https://github.com/bcgov/drat)
add_to_drat()
