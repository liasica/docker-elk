#!/usr/bin/env bash

# set -eu
set -x

/usr/local/bin/docker-entrypoint.sh &

function wait_for_elasticsearch {
	local elasticsearch_host="${ELASTICSEARCH_HOST:-elasticsearch}"

	local -a args=( '-s' '-D-' '-m15' '-w' '%{http_code}' "http://localhost:9200/" )

	if [[ -n "${ELASTIC_PASSWORD:-}" ]]; then
		args+=( '-u' "elastic:${ELASTIC_PASSWORD}" )
	fi

	local -i result=1
	local output

	# retry for max 300s (60*5s)
	for _ in $(seq 1 60); do
		local -i exit_code=0
		output="$(curl "${args[@]}")" || exit_code=$?

		if ((exit_code)); then
			result=$exit_code
		fi

		if [[ "${output: -3}" -eq 200 ]]; then
			result=0
			break
		fi

		sleep 5
	done

	if ((result)) && [[ "${output: -3}" -ne 000 ]]; then
		echo -e "\n${output::-3}"
	fi

	return $result
}

function import_license {
  local license_file="$1"

  if [[ -f "$license_file" ]]; then
    echo "Importing license from $license_file"
    curl -XPUT -u "elastic:${ELASTIC_PASSWORD}" 'http://localhost:9200/_license?acknowledge=true' -H 'Content-Type: application/json' -d @"$license_file"
  else
    echo "License file $license_file not found, skipping license import"
  fi
}

# Wait for Elasticsearch to be up and running
echo 'Waiting for Elasticsearch to be ready...'
wait_for_elasticsearch

# Check if Elasticsearch is up
if [[ $? -ne 0 ]]; then
  echo 'Elasticsearch is not responding. Exiting.'
  exit 1
fi

echo 'Elasticsearch is ready.'

# Apply the license
echo 'Applying license...'
import_license /usr/share/elasticsearch/license.json

# Keep the container running
wait
