#!/bin/bash
# Elasticsearch (6.x) _cat API consumable by the command line.

_usage()
{
  cat <<EOF_USAGE
Usage: $0 [-u|--url URL] [-c|--columns COLUMNS] [-v|--verbose] <command>

Available _cat commands:
   allocation  Manage shard allocation
   health      Cluster health
   indices     Show indices
   master      List master node
   nodes       Node stats
   shards      List shards in the cluster
   snapshots   List snapshots that belong to a repository (default to "backup_repo" or use --snapshot-repo to override)

Extra command (not _cat):
   version     Show cluster name and current elastic build version

Options:
   -h --help         show this help text
   -u  --url <url>   elastic url (default "http://localhost:9200")
   -c  --columns     comma-separated columns to return for the _cat command
   -l  --list-columns   list the columns supported by the _cat command 
   -v  --verbose     print column headers
   --snapshot-repo   specify repository to use by "snapshots" command


Examples:
  List nodes in cluster:

    $ es -v nodes
    ip         heap.percent ram.percent cpu load_1m load_5m load_15m node.role master name
    172.19.0.2           56          42   1    0.00    0.04     0.00 mdi       -      cu_4t7K
    172.19.0.3           70          42   1    0.00    0.04     0.00 mdi       *      WI7hZOS


  List nodes in the cluster, only return ip, ram.current, load_1m columns

    $ es -v -c ip,ram.current,load_1m  nodes
    ip         ram.current load_1m
    172.19.0.2       3.2gb    0.01
    172.19.0.3       3.2gb    0.01


  To get all columns supported by the `nodes` command

    $ es -l nodes

    id                           | id,nodeId                      | unique node id
    disk.used                    | du,diskUsed                    | used disk space
    disk.avail                   | d,da,disk,diskAvail            | available disk space
    disk.used_percent            | dup,diskUsedPercent            | used disk space percentage
    heap.current                 | hc,heapCurrent                 | used heap
    heap.percent                 | hp,heapPercent                 | used heap ratio
    heap.max                     | hm,heapMax                     | max configured heap
    ram.current                  | rc,ramCurrent                  | used machine memory
    ram.percent                  | rp,ramPercent                  | used machine memory ratio
    ram.max                      | rm,ramMax                      | total machine memory
    cpu                          | cpu                            | recent cpu usage
    load_1m                      | l                              | 1m load avg
    load_5m                      | l                              | 5m load avg
    -- remainings ignored 

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
        -l | --list-columns )   shift
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
