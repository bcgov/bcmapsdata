library(git2r)
library(gh)
library(httr)

# Get the package version number
ver <- as.character(read.dcf("DESCRIPTION", "Version"))

# Tag the repo with the package version:
bcmaps.rdata_repo <- repository(".")
tagname <- paste0("bcmaps.rdata version ", ver)
tag(bcmaps.rdata_repo, ver, tagname)
system("git push origin --tags")

# List releases
# rels <- gh(
#   "/repos/bcgov/bcmaps.rdata/releases"
# )

# List most recent release
# release <- gh(
#   "/repos/bcgov/bcmaps.rdata/releases/:id",
#   id = rels[[1]]$id
# )

# Create a release
release <- gh("POST /repos/bcgov/bcmaps.rdata/releases", 
   tag_name = ver, 
   name = tagname)

# For all rda files in data-extra, which are too big to include in the package,
# attach them to the release so can be downloaded by bcmaps individually.
release_files <- list.files("release-data", pattern = "\\.rds", full.names = TRUE)
for (f in release_files) {
  
  r <- POST(gsub("\\{.+\\}$", "", release$upload_url),
            query = list(name = basename(f)),
            body = upload_file(f),
            authenticate(github_pat(), ""), 
            progress("up"))
  
  warn_for_status(r, task = paste0("upload ", f))
  
}

