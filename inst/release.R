#' Tag the repo with the package version:
#'
#' @param repo path to bcmaps.rdata repo. Default `"."`
#' @param version bcmaps.rdata package version. By default reads it from the DESCRIPTION file
#' 
#' @return the package version
tag_pkg_repo <- function(repo = ".", version = as.character(read.dcf(file.path(repo, "DESCRIPTION"), "Version"))) {
  stopifnot(requireNamespace("git2r"))
  stopifnot(nzchar(Sys.getenv("GITHUB_PAT")))
  
  bcmaps.rdata_repo <- git2r::repository(repo)
  status <- git2r::status(bcmaps.rdata_repo)
  
  if (!all(vapply(status, length, FUN.VALUE = integer(1)) == 0)) {
    stop("You have uncommitted changes. Please commit or stash before proceeding")
  }
  
  tagname <- paste0("bcmaps.rdata version ", version)
  git2r::tag(bcmaps.rdata_repo, version, tagname)
  
  # Push repo
  git2r::push(bcmaps.rdata_repo, "origin", "refs/heads/master",
              credentials = git2r::cred_token())
  
  # Push tag
  gitr::push(bcmaps.rdata_repo, "origin", paste0("refs/tags/", version), 
             credentials = git2r::cred_token())
  
  version
}


#' List releases on GitHub for bcmaps.rdata
#'
#' @return list of lists of information about the releases
list_releases <- function() {
  stopifnot(requireNamespace("gh"))
  rels <- gh::gh(
    "/repos/bcgov/bcmaps.rdata/releases"
  )
  rels
}

#' Create a release from the version tag
#'
#' @param version bcmaps.rdata package version. By default reads it from the DESCRIPTION file
#'
#' @return list of information about the release
#' @export
#'
#' @examples
create_release <- function(version = as.character(read.dcf("DESCRIPTION", "Version"))) {
  stopifnot(requireNamespace("gh"))
  
  tagname <- paste0("bcmaps.rdata version ", version)
  release <- gh::gh("POST /repos/bcgov/bcmaps.rdata/releases", 
                tag_name = version, 
                name = tagname)
  release
}

#' Upload attachments to the github release
#' 
#' For all rds files in release-data, which are too big to include in the package,
#' attach them to the release so can be downloaded by bcmaps individually.
#'
#' @param release_url the url of the release - best obtained from the output of `release()`
#'
upload_release_attachments <- function(release_url) {
  stopifnot(requireNamespace("httr"))
  
  release_files <- list.files("release-data", pattern = "\\.rds", full.names = TRUE)
  for (f in release_files) {
    message("uploading ", f)
    r <- httr::POST(gsub("\\{.+\\}$", "", release_url),
                    query = list(name = basename(f)),
                    body = httr::upload_file(f),
                    httr::authenticate(httr::github_pat(), ""), 
                    httr::progress("up"))
    
    httr::stop_for_status(r, task = paste0("upload ", f))
  }
  invisible(TRUE)
}

#' Add new bcmaps.rdata to drat
#'
#' @param drat_loc path to the drat repo (a local clone of https://github.com/bcgov/drat)
#' @param cleanup remove the built tar.gz file after it's been added to drat?
#'
add_to_drat <- function(drat_loc = "../drat", cleanup = TRUE) {
  stopifnot(requireNamespace("devtools"))
  stopifnot(requireNamespace("git2r"))
  stopifnot(requireNamespace("drat"))
  stopifnot(nzchar(Sys.getenv("GITHUB_PAT")))
  
  built_bcmaps.rdata_file <- devtools::build()
  if (cleanup) {
    on.exit(unlink(built_bcmaps.rdata_file))
  }
  
  # Get current package version
  ver <- as.character(read.dcf("DESCRIPTION", "Version"))
  drat_loc <- normalizePath(drat_loc, winslash = "/", mustWork = TRUE)
  drat_repo <- git2r::repository(drat_loc)
  
  # Pull first
  git2r::pull(drat_repo)
  
  # Insert built package into the drat repo
  drat::insertPackage(built_bcmaps.rdata_file, drat_loc)
  
  # Add files, commit, and push to drat repo
  git2r::add(drat_repo, ".")
  git2r::commit(drat_repo, paste("Add bcmaps.rdata", ver))
  git2r::push(drat_repo, "origin", "refs/heads/gh-pages", 
              credentials = git2r::cred_token())
  
}
