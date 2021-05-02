#! /bin/bash
#
# @Juan Pierre Sánchez Cercado
#
# Abril 2021
#
# Fuciones de disco
#
# ----------------------------------------

#1 fsize-Donat un login calcular amb du l'ocupació del home de l'usuari. Cal obtenir el home del /etc/passwd.

function fsize(){
 login=$1
 home=$(grep "^$login:" /etc/passwd | cut -d: -f6)
 du -sh $home
 return 0

}


#2 loginargs-Aquesta funció rep logins i per a cada login es mostra l'ocupació de disc del home de l'usuari usant fsize. Verificar que es rep almenys un argument. Per a cada argument verificar si és un login vàlid, si no generra una traça d'error.

function loginargs(){
 # VErificamos que se recibe minimo un arg
 if [ $# -eq 0 ]; then
  echo "ERROR: num args no valid"
  return 1
 fi

 # VErificamos que cada login sea valido
 for login in $*
 do
  grep "^$login:" /etc/passwd > /dev/null
  if [ $? -ne 0 ]; then
   echo "Error: el login $login no es valid"
  else
   fsize $login
  fi
 done
 return 0

}


#3 loginfile-Rep com a argument un nom de fitxer que conté un lògin per línia. Mostrar l'ocupació de disc de cada usuari usant fsize. Verificar que es rep un argument i que és un regular file.

function loginfile(){
 if [ $# -ne 1 ]; then
  echo "Error: num args no valid"
  echo "USAGE: $0 file"
  return 1
 fi
 
 file=$1
 while read -r login
 do
  fsize $login
 done < $file

}


#4 






