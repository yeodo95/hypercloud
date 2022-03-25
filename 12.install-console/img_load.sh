pushd ./img
docker load < traefik_v2.5.4.tar
docker load < hypercloud-console_5.0.51.0.tar
docker load < jwt-decode_5.0.0.1.tar
popd

docker tag traefik:v2.5.4 ${REGISTRY}/traefik:v2.5.4
docker tag tmaxcloudck/hypercloud-console:5.0.51.0 ${REGISTRY}/tmaxcloudck/hypercloud-console:5.0.51.0
docker tag tmaxcloudck/jwt-decode:5.0.0.1 ${REGISTRY}/tmaxcloudck/jwt-decode:5.0.0.1

docker push ${REGISTRY}/traefik:v2.5.4
docker push ${REGISTRY}/tmaxcloudck/hypercloud-console:5.0.51.0
docker push ${REGISTRY}/tmaxcloudck/jwt-decode:5.0.0.1