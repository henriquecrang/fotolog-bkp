#!/bin/bash

#passar nome de usuario
echo -n "Backup para fotolog.com! Entre com o nome de usuário: "
read user

mkdir $user
cd $user

# baixar pagina
wget www.fotolog.com/$user

#pegar o nome da primeira página
page=`grep -Po 'content="\K[^"]*([0-9]+)\/"' $user | grep -Po '[0-9]+(?=\/")'`

#criar index redirecionando para a primeira página
echo '<META http-equiv="refresh" content="1;URL=' $page '"> ' > index.html

mv $user $page

mkdir files$page

#encontrar lista de imagens (jpg e png)
grep -Po '(?<=src=")[^"]*(png|jpg)' $page > files$page/tempimg
#baixar imagens (jpg e png)
cd files$page
wget -i tempimg


#mudar url das imagens para local
##varer lista de imagens em tempimg e fazer um sed removendo os caminhos

#apagar lista de imagens temporaria
##rm tempimg

#tratar js e css
##baixar todos para pasta local e substituir urls


#encontrar endereço da proxima pagina
url=`grep -Po '<a class="arrow_change_photo arrow_change_photo_right" href="\K[^"]*(?=\/#profile_start)' ../$page`




#mudar url de todas paginas /$user para local

#remover todos os outros links que nao funcionariam


#abrir loop para fazer isso até a última página


#bonus: baixar mosaico e suas subpaginas
