#!/bin/bash


function baixarFotos(){
url=$1
user=$2

wget $url -O pagina

#encontrar imagem principal e baixar
wget `grep -Po '(?<=content=")[^"]*(_f.jpg)' pagina | uniq`

grep -Po '(?<=content=")[^"]*(_f.jpg)' pagina | uniq >> listaimagens



#encontrar endereço da proxima pagina
url=`grep -Po '<a class="arrow_change_photo arrow_change_photo_right" href="\K[^"]*(?=\/#profile_start)' pagina`

rm pagina

#chamar próxima caso não esteja vazia
if [ -n "$url" ]; then
 baixarFotos $url $user
fi


}

echo -n "Backup somente de fotos do fotolog.com! Entre com o nome de usuário: "
read user

mkdir $user
cd $user

touch listaimagens

url="http://www.fotolog.com/$user"

#chamar download

baixarFotos $url $user

