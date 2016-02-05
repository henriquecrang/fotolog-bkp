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
grep -Po '(?<=src=")[^"]*(png|jpg)' $page > files$page/temp
#baixar imagens (jpg e png)
cd files$page
wget -i temp
rm temp

#mudar url das imagens para local


#encontrar endereço da proxima pagina

#mudar url de todas paginas /$user para local

#remover todos os outros links que nao funcionariam


#abrir loop para fazer isso até a última página


#bonus: baixar mosaico e suas subpaginas
