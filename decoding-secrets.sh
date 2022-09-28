#! /bin/sh

echo "DECODING USERNAME AND PASSWORD SECRET \n "
echo "provided $1 is not a defined argument for script \n use decode for generic secrets and docker for docker registry secrets \n "


if [ "$1" = "decode" ]
then  
    kubectl get ns
    echo " Enter Namespace "
    read namespace
    kubectl get secrets -n $namespace
    echo " Enter Secret Name "
    read secret
    kubectl describe secret $secret -n $namespace
    echo " choose values to Decode, can take two values  example: USERNAME PASSWORD "
    read value1 value2
    echo " Decoding $value1 " 
    echo -n  "$value1="; kubectl get secret $secret -n $namespace -o jsonpath={.data.$value1} | base64 --decode
    echo " Decoding $value2 "
    echo -n  "$value2="; kubectl get secret $secret -n $namespace -o jsonpath={.data.$value2} | base64 --decode
elif  [ "$1" = "docker" ]
then 
     kubectl get ns
     echo " Enter Namespace \n "
     read namespace
     kubectl get secrets -n $namespace
     echo " Enter Secret Name \n "
     read secret
     kubectl describe secret $secret -n $namespace
     echo " Decoding Docker Registry Credentials \n "
     kubectl get secret $secret -n $namespace -o jsonpath={.data.*} | base64 --decode
     echo " \n "
fi
