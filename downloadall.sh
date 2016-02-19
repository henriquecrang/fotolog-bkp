#!/bin/bash


function baixarFotos(){
url=$1
user=$2

#baixa pagina com comentarios
wget $url -O pagina

#encontrar imagem principal e baixar
grep -Po '(?<=content=")[^"]*(_f.jpg)' pagina | uniq >> listaimagens

#baixa imagem principal
wget `tail -1 listaimagens`


#encontrar endereço da proxima pagina
url=`grep -Po '<a class="arrow_change_photo arrow_change_photo_right" href="\K[^"]*(?=\/#profile_start)' pagina`


nome=`echo $url | grep -Po '(?<=\/)[0-9]+(?=$)'`

mv pagina $nome.html

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

