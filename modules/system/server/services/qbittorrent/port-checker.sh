get_natpmp_port () {
    req=$(natpmpc -a 1 0 "$1" 60 -g 10.2.0.1)
    echo "$req" | grep "Mapped public port" | sed 's/.* public port \([0-9]*\).*/\1/'
}


get_natpmp_ip () {
    req=$(natpmpc -g 10.2.0.1)
    echo "$req" | grep "Public IP address" | sed 's/.*: \(.*\)/\1/'
}


set_qbittorrent_port () {
    qb_url="http://localhost:8888"
    api_url="${qb_url}/api/v2"
    header="Referer: ${qb_url}"
    cookie_path="/tmp/qbittorrent.cookie"

    qbit_auth="$(curl --header "$header" \
        --data "$(< ./creds_path)" $api_url/auth/login \
        -c $cookie_path -s)"

    if [ "$qbit_auth" != "Ok." ]; then
        echo "$qbit_auth"
    fi

    curl --header "$header" \
        --data "json={\"listen_port\": ${1}}" $api_url/app/setPreferences \
        -b $cookie_path -s
}


port=""
ip=""

while true 
do 
    echo "Request IP and Port"

    udp_port=$(get_natpmp_port "udp")
    tcp_port=$(get_natpmp_port "tcp")
    c_ip=$(get_natpmp_ip)


    if [ "$c_ip" != "$ip" ]; then
        ip=$c_ip
        echo "IP address changed"
        echo "IP address: $ip"
    fi


    if [ "$udp_port" != "$tcp_port" ]; then
        echo "UDP and TCP port are not the same!"
    else
        c_port=$udp_port
    fi


    if [ "$c_port" != "$port" ]; then
        port=$c_port
        echo "TCP/UDP port changed"
        echo "TCP/UDP port: $port"
        set_qbittorrent_port "$port"
    fi

    sleep 45 
done
