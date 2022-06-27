#!/bin/bash

while :
do
    sudo /phv/phv

    file_path=/phv/data.log

    identity=`sed -n '$p' /phv/id.log`

    # Read last line
    data=`sed -n '$p' $file_path`

    IFS=" "
    arr=($data)
    url='https://www.power-hv.com/update.php?'
    url=${url}'ID='$identity
    url=${url}'&temp='${arr[1]}
    url=${url}'&humid='${arr[2]}
    url=${url}'&current='${arr[5]}
    url=${url}'&VBatt='${arr[3]}
    url=${url}'&condition='${arr[4]}
    url=${url}'&ad='${arr[5]}
    for i in {6..34}
    do
        url=${url}','${arr[i]}
    done
    echo $url
    curl -H 'Authorization:Basic cG93ZXJodjU6cG93ZXItaHyubG9jYWw1cG0=' "${url}"

    line=`sed -n '$=' $file_path`

    while [ "$line" -gt 100 ] 
    do
        echo 'delete one line'
        sed -i '1d' $file_path
        let 'line--'
    done
    # 600-2
    sleep 298
done


