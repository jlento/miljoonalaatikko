#!/bin/bash
# MacOS version

key="$1"
user="$USER"
caurl="https://my-csc-alpha-my-csc-dev.2.rahtiapp.fi"

keypri="${HOME}/.ssh/${key}"
keypub="${keypri}.pub"
cert="${keypri}-cert.pub"

if [ -f "$keypub" ]
then
    certsign=$(printf '{"sshPublicKey": "%s", "userCn": "%s"}' "$(< ${keypub})" "$USER" | base64)
else
    echo "File '$keypub' not found." >&2
    exit 1
fi

cert_is_valid() {
    test -s $cert || return 1
    local expiration_date=$(ssh-keygen -L -f $cert | awk '/^ *Valid:/{print $NF}')
    (( $(date -jf "%Y-%m-%dT%H:%M:%S" "${expiration_date}" +%s) > $(date +%s) ))
}

cert_is_in_agent() {
    test -s $cert || return 1
    grep -q "$(< $cert)" <(ssh-add -L)
}

get_cert() {
    curl -s ${caurl}/api/certificate/download/${certsign} \
        | jq -r '.data' | sed -e '/^null$/d' -e '/^[[:space:]]*$/d' > $cert
}

if cert_is_valid
then
    if cert_is_in_agent
    then # All good, exit early
        exit 0
    fi
else
    # Remove invalid cert from ssh agent
    cert_is_in_agent && ssh-add -d $cert
    # Try getting a new cert
    get_cert
    # If we did not get a cert, or what we got is invalid (expired),
    # request the CA to create a new certificate
    cert_is_valid || open ${caurl}/login?certSign=${certsign}
    # Signing in to the CA and creating a cert may take a second,
    # keep polling until we get a valid cert
    until cert_is_valid
    do
        get_cert
        sleep 5
    done
fi

ssh-add $keypri
