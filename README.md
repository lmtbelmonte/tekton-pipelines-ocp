# Pipelines with Tekton - Openshift Pipelines +  Openshift GitOps

Repo creado con los ejerecicios del libro GitOps-Cookbook de RedHat developer escrito por Natale Vinto y Alex Soto 
con algunos cambios y pruebas para funcionar en openshift.

## Pruebas en OpenShift del circuito Ci/Cd completo  en cicd-pipeline/
### Actualizar github secrets y user/pass de quay.io

Para hacer las pruebas varios repo en gir que contiene los ejemplos y en otro están los yaml tanto de los pipeline como de las tasks, esta sacado del libro de RedHat Developer GitOps CookBook de Natale Vinto

Este es el repo quee creado con los k8s yaml para configurar y crear los tasks/pipelines/pipelineruns en OpenShift , el libro esta mas basado en minikube y hay ligeras diferencias en temas de scc y de networking…

https://github.com/lmtbelmonte/tekton-pipelines-ocp.git

Hay varios directorios desde un simple build y push del artefacto al container repo (para estos ejemplos es quay.io)
/build-push hasta un cicd completo con git privado y despliegue, un webhook desde un repo de git , una modificación con kustomize 

LO primero que hay que configurar son los Secrets y RBAC roles para los serviceaccounts que van a hacer  el trabajo.
Siempre es más optimo a nivel de seguridad ir con el principio del mínimo permiso.

### Secrets necesarios para github y quay.io  ( tekton-pipelines-ocp/build-push)

* github-secret : user/pass  ( Basic auth para este ejemplo)
* container-registry-secret:  (dockerconfigjson)
 
### Service accounts para cada una de las operaciones

* tekton-bot-sa ( tiene que tener el git-secret adjuntado para poder hacer el pull)
* tekton-registry-sa (tiene que tener el container-registry-secret para poder hacer el push )
* tekton-deployer-sa ( Roles/Bindings para poder desplegar en k8s y el container-registry-secret)
* tekton-triggers-sa (necesita los roles y bindings necesarios)
	
### Roles y Bindings  ( tekton-pipelines-ocp/deploy-k8s)

* task-role.yaml  : Permisos "*" sobre pods, services, endpoints, configmaps, secrets, deploy, rs.
* task-role-bindidng : asociación a la Service account para deploy (tekton-deployer-sa)

### Persistent Volume para el workspace

necesitamos que la informacion este disponible entre tareas dentro del pipeline creamos un Claim 
* PVC : app-source

### Tekton-hub para las tareas que queramos usar del hub predefinidas 

```shell
tkn hub install task git-clone ( ojo con la version ,  ocp > 4.12 )
tkn hub install task maven
tkn hub install task buildah
tkn hub install task kubernetes-actions
```