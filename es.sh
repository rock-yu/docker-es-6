#!/bin/bash
# Elasticsearch (6.x) _cat API consumable by the command line.

_usage()
{
  cat <<EOF_USAGE
Usage: $0 [options] <command>

Available _cat commands:
   allocation  Manage shard allocation
   health      Cluster health
   indices     Show indices
   master      List master node
   nodes       Node stats
   shards      List shards in the cluster
   snapshots   List snapshots that belong to a repository (default to "backup_repo" or use --snapshot-repo to override)

Extra command:
   version     Show cluster name and current elastic build version

Options:
   -u  --url <url>   elastic url (default "http://localhost:9200")
   -c  --columns     comma-separated columns to return
   -v  --verbose     print column headers
   --snapshot-repo   specify repository to use by "snapshots" command

Use '$0 columns <command>' to list columns the _cat command supports
EOF_USAGE
}

es_url="${es_url:-http://localhost:9200}"
# Do not print column headers by default
verbose=false
ask_columns=false
command=""
# Comma-separated list of column names to display
columns=""
snapshot_repo="backup_repo"

while [ "$1" != "" ]; do
    case $1 in
        -u | --url )            shift
                                es_url=$1
                                ;;
        -c | --columns )        shift
                                columns=$1
                                ;;                                
        -v | --verbose )        verbose=true
                                ;;
        --snapshot-repo )       shift
                                snapshot_repo=$1
                                ;;
        -h | --help )           _usage
                                exit
                                ;;                                
        column | columns )      shift
                                ask_columns=true
                                command=$1
                                ;;
        nodes | allocation | health | indices | master | shards | aliases | version)
                                command=$1
                                ;;
        snapshots )
                                command="snapshots"
                                ;;
        * )                     _usage
                                exit 1
    esac
    shift
done


if [ -z "$command" ]; then
    _usage
    echo "<command> should be provided"
    exit 1
fi

if [[ "$command" = "version" ]]; then
  #rename number to version_number | remove quotes (") and commas (,) | removing leading/tailing spaces
  curl -s "$es_url" | grep 'cluster_name\|number' | sed 's/number/version_number/g' | tr -d '"' | tr -d ',' | tr -d ' '
  exit 0
fi

# ask command columns 
if [[ "$ask_columns" = "true" ]]; then
  curl -s "$es_url/_cat/$command?help"
  exit 0
fi

# cat API
if [[ "$command" = "snapshots" ]]; then
    curl -s "$es_url/_cat/$command/$snapshot_repo?v=${verbose}"
else
  [[ -n "$columns" ]] && headers_filter="&h=${columns}" 
  curl -s "$es_url/_cat/$command?v=${verbose}${headers_filter}"
fi
