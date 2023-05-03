export TRAEFIK_UI_USER=admin
export TRAEFIK_UI_PASS=dashboard
export DESTINATION_FOLDER=./USER/temp/traefik-ui-creds

mkdir -p ${DESTINATION_FOLDER}
echo $TRAEFIK_UI_USER >> ${DESTINATION_FOLDER}/traefik-ui-user.txt
echo $TRAEFIK_UI_PASS >> ${DESTINATION_FOLDER}/traefik-ui-pass.txt

htpasswd -Bbn ${TRAEFIK_UI_USER} ${TRAEFIK_UI_PASS} \
   > ${DESTINATION_FOLDER}/htpasswd

unset TRAEFIK_UI_USER TRAEFIK_UI_PASS DESTINATION_FOLDER