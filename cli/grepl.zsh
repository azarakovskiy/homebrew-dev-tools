# grep without truncating
function grepl_impl() {
    readonly what=${1:?"Specify what to grep please"}
    readonly regexp=".*$what.*|\$"
    grep -E $regexp
}
alias grepl=grepl_impl