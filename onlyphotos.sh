#!/bin/bash


function baixarFotos(){
url=$1
user=$2

wget $url -O pagina

#encontrar imagem principal e baixar
wget `grep -Po '(?<=src=")[^"]*(_f.jpg)' pagina`

#encontrar endereço da proxima pagina (fazer verificador para ultima pagina)
url=`grep -Po '<a class="arrow_change_photo arrow_change_photo_right" href="\K[^"]*(?=\/#profile_start)' pagina`

rm pagina

#roda pra proxima
baixarFotos $url $user

}

echo -n "Backup somente de fotos do fotolog.com! Entre com o nome de usuário: "
read user

mkdir $user
cd $user

url="http://www.fotolog.com/$user"

#chamar download

baixarFotos $url $user

