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

#baixar css
mkdir styles
cd styles
wget -i ../../stylesurls

#baixar imgs do style tb

#baixar js
mkdir ../scripts
cd ../scripts
#wget -i ../../jsurls


url="http://fotolog.com/$user/$page"
cd ..
rm $user

## começa aqui loop para todas as páginas

#criar pasta para arquivos da pagina
wget $url
mkdir files$page


#mudar url dos css para local
#sed -i 's@http://fotolog.com/styles/\([^"]*"\)@style/\1@g' $page

#mudar url dos js para local
##sed -i 's@http://fotolog.com/scripts/\([^"]*"\)@scripts/\1@g' $page


#encontrar lista de imagens (jpg e png)
grep -Po '(?<=src=")[^"]*(jpg)' $page > files$page/tempimg
#baixar imagens (jpg e png)
cd files$page
wget -i tempimg


#mudar url das imagens para local
##varer lista de imagens em tempimg e fazer um sed removendo os caminhos

#apagar lista de imagens temporaria
##rm tempimg



#encontrar endereço da proxima pagina (fazer verificador para ultima pagina)
url=`grep -Po '<a class="arrow_change_photo arrow_change_photo_right" href="\K[^"]*(?=\/#profile_start)' ../$page`


#mudar url de todas paginas /$user para local
sed -e "s@http://www.fotolog.com/$user/@@g" -i ../$page

#remover todos os outros links que nao funcionariam (nao está tratando quando href nao eh o primeiro parametro)
## testar essa outra linha quando css e js estiverem tratados
### sed -i 's@href="http[^"]*"@href="#"@g' ../$page
sed -i 's@<a href="http[^>]*>@<a href="#">@g' ../$page

#remover div com alerta de fim do serviço



#bonus: baixar mosaico e suas subpaginas



