#!/bin/bash
# Elasticsearch (6.x) _cat API consumable by the command line.

_usage()
{
  cat <<EOF_USAGE
Usage: $0 [options] <command>

Available commands:
   allocation  Manage shard allocation
   health      Cluster health
   indices     Show elasticsearch indices
   master      List master node
   nodes       Node stats
   heap        Heap statistics for nodes (deprecated, use "es nodes" instread)
   shards      List shards in the cluster
   snapshots   List snapshots that belong to a repository (default to "backup_repo" or use --snapshot-repo to override)
   version     Show cluster name and current elastic build version

Options:
   -u  --url <url>   elastic url (default "http://localhost:9200")
   -v  --verbose     print column headers
   --snapshot-repo   specify repository to use by "snapshots" command

EOF_USAGE
}

# Do not print column headers by default
verbose=false
command=""

# Comma-separated list of column names to display
headers_filter=""

snapshot_repo="backup_repo"

while [ "$1" != "" ]; do
    case $1 in
        -u | --url )            shift
                                es_url=$1
                                ;;
        -v | --verbose )        verbose=true
                                ;;
        --snapshot-repo )       shift
                                snapshot_repo=$1
                                ;;
        -h | --help )           _usage
                                exit
                                ;;
        allocation | health | indices | master | shards | aliases | version)
                                command=$1
                                ;;
        snapshots )
                                command="snapshots"
                                ;;
        nodes )
                                command="nodes"
                                headers_filter="&h=name,ip,master,heap.current,heap.percent,ram.current,ram.max,ram.percent,disk.used,disk.total,disk.used_percent"
                                ;;
        heap )
                                command="nodes"
                                headers_filter="&h=name,ip,master,heap.current,heap.percent"
                                ;;
        * )                     _usage
                                exit 1
    esac
    shift
done

es_url="${es_url:-http://localhost:9200}"
if [ -z "$command" ]; then
    _usage
    echo "<command> should be provided"
    exit 1
fi

if [[ "$command" = "version" ]]; then
  #rename number to version_number | remove quotes (") and commas (,) | removing leading/tailing spaces
  curl -s "$es_url" | grep 'cluster_name\|number' | sed 's/number/version_number/g' | tr -d '"' | tr -d ',' | tr -d ' '
elif [[ "$command" = "snapshots" ]]; then
    curl -s "$es_url/_cat/$command/$snapshot_repo?v=${verbose}"
else
  curl -s "$es_url/_cat/$command?v=${verbose}${headers_filter}"
fi
