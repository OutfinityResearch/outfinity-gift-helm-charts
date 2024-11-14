# outfinity-gift

![Version: 1.0.16](https://img.shields.io/badge/Version-1.0.16-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for scheduling a pod. See [https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) |
| config.dev | string | `"true"` | Enable Dev mode |
| config.overrides | object | `{"apihubJson":"","bdnsHosts":"","envJson":"","vaultDomainConfigJson":""}` | The outfinity-gift version |
| config.overrides.apihubJson | string | `""` | Option to explitly set the apihub.json instead of using the default from [https://github.com/pharmaledgerassoc/outfinity-gift/blob/v1.3.1/apihub-root/external-volume/config/apihub.json](https://github.com/pharmaledgerassoc/outfinity-gift/blob/v1.3.1/apihub-root/external-volume/config/apihub.json). Note: If secretProviderClass.enabled=true, then this value is ignored as it is used/mounted from Secret Vault. <br/>outfinity-gift-86d4f7878-jrbfw Settings: [https://docs.google.com/document/d/1mg35bb1UBUmTpL1Kt4GuZ7P0K_FMqt2Mb8B3iaDf52I/edit#heading=h.z84gh8sclah3](https://docs.google.com/document/d/1mg35bb1UBUmTpL1Kt4GuZ7P0K_FMqt2Mb8B3iaDf52I/edit#heading=h.z84gh8sclah3) <br/> For SSO (not enabled by default): <br/> 1. "enableOAuth": true <br/> 2. "serverAuthentication": true <br/> 3. For SSO via OAuth with Azure AD, replace <TODO_*> with appropriate values.    For other identity providers (IdP) (e.g. Google, Ping, 0Auth), refer to documentation.    "redirectPath" must match the redirect URL configured at IdP <br/> 4. Add these values to "skipOAuth": "/leaflet-wallet/", "/directory-summary/", "/iframe/" |
| config.overrides.bdnsHosts | string | `""` | Centrally managed and provided BDNS Hosts Config. You must set this value in a non-sandbox environment! See [templates/_configmap-bdns.tpl](templates/_configmap-bdns.tpl) for default value. |
| config.overrides.envJson | string | `""` | Option to explitly override the env.json for APIHub instead of using the predefined template. Note 1: Usually not required to override. Note 2: If secretProviderClass.enabled=true, then this value is ignored as it is used/mounted from Secret Vault. |
| config.overrides.vaultDomainConfigJson | string | `""` | Option to explicitly override the config.json used for the vaultDomain instead of using the predefined template. Note: Usually not required |
| config.s3AccessKeyId | string | `""` |  |
| config.s3SecretAccessKey | string | `""` |  |
| config.ssoSecretsEncryptionKey | string | `"8d0BO3SUi1hLkuxYiw1Oo8fPRCSN/r0RknDXAYnhKro="` |  |
| config.stripeSecretKey | string | `""` |  |
| config.vaultDomain | string | `"vault.my-company"` | The Vault domain, should be vault.company, e.g. vault.my-company |
| extraResources | string | `nil` | An array of extra resources that will be deployed. This is useful e.g. for custom resources like SnapshotSchedule provided by [https://github.com/backube/snapscheduler](https://github.com/backube/snapscheduler). |
| fullnameOverride | string | `""` | fullnameOverride completely replaces the generated name. From [https://stackoverflow.com/questions/63838705/what-is-the-difference-between-fullnameoverride-and-nameoverride-in-helm](https://stackoverflow.com/questions/63838705/what-is-the-difference-between-fullnameoverride-and-nameoverride-in-helm) |
| imagePullSecrets | list | `[]` | Secret(s) for pulling an container image from a private registry. Used for all images. See [https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) |
| kubectl.image.pullPolicy | string | `"Always"` | Image Pull Policy |
| kubectl.image.repository | string | `"bitnami/kubectl"` | The repository of the container image containing kubectl |
| kubectl.image.sha | string | `"bba32da4e7d08ce099e40c573a2a5e4bdd8b34377a1453a69bbb6977a04e8825"` | sha256 digest of the image. Do not add the prefix "@sha256:" <br/> Defaults to image digest for "bitnami/kubectl:1.21.14", see [https://hub.docker.com/layers/kubectl/bitnami/kubectl/1.21.14/images/sha256-f9814e1d2f1be7f7f09addd1d877090fe457d5b66ca2dcf9a311cf1e67168590?context=explore](https://hub.docker.com/layers/kubectl/bitnami/kubectl/1.21.14/images/sha256-f9814e1d2f1be7f7f09addd1d877090fe457d5b66ca2dcf9a311cf1e67168590?context=explore) <!-- # pragma: allowlist secret --> |
| kubectl.image.tag | string | `"1.21.14"` | The Tag of the image containing kubectl. Minor Version should match to your Kubernetes Cluster Version. |
| kubectl.podSecurityContext | object | `{"fsGroup":65534,"runAsGroup":65534,"runAsUser":65534}` | Pod Security Context for the pod running kubectl. See [https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) |
| kubectl.resources | object | `{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | Resource constraints for the pre-builder and cleanup job |
| kubectl.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534}` | Security Context for the container running kubectl See [https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) |
| kubectl.ttlSecondsAfterFinished | int | `300` | Time to keep the Job after finished in case of an error. If no error occured the Jobs will immediately by deleted. If value is not set, then 'ttlSecondsAfterFinished' will not be set. |
| nameOverride | string | `""` | nameOverride replaces the name of the chart in the Chart.yaml file, when this is used to construct Kubernetes object names. From [https://stackoverflow.com/questions/63838705/what-is-the-difference-between-fullnameoverride-and-nameoverride-in-helm](https://stackoverflow.com/questions/63838705/what-is-the-difference-between-fullnameoverride-and-nameoverride-in-helm) |
| namespaceOverride | string | `""` | Override the deployment namespace. Very useful for multi-namespace deployments in combined charts |
| nodeSelector | object | `{}` | Node Selectors in order to assign pods to certain nodes. See [https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) |
| outfinityGift.deploymentStrategy.type | string | `"Recreate"` |  |
| outfinityGift.image.pullPolicy | string | `"Always"` | Image Pull Policy for the runner |
| outfinityGift.image.repository | string | `"assistos/outfinity-gift"` | The repository of the container image for the runner <!-- # pragma: allowlist secret --> |
| outfinityGift.image.sha | string | `"3fd47eab0604c4e73d1b2eca47503dcb4c99c3d481daae5b0e8f6e24d9c05d79"` | sha256 digest of the image. Do not add the prefix "@sha256:" Default to v1.3.1 <!-- # pragma: allowlist secret --> |
| outfinityGift.image.tag | string | `"1.0.0-rc1"` | Overrides the image tag whose default is the chart appVersion. Default to v1.3.1 |
| outfinityGift.livenessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/ready-probe","port":"http"},"initialDelaySeconds":20,"periodSeconds":20,"successThreshold":1,"timeoutSeconds":3}` | Liveness probe. See [https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| outfinityGift.podAnnotations | object | `{}` |  |
| outfinityGift.podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsUser":1000}` | Pod Security Context for the runner. See [https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) |
| outfinityGift.readinessProbe | object | `{"failureThreshold":10,"httpGet":{"path":"/ready-probe","port":"http"},"initialDelaySeconds":20,"periodSeconds":20,"successThreshold":1,"timeoutSeconds":3}` | Readiness probe. See [https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| outfinityGift.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"privileged":false,"readOnlyRootFilesystem":false,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | Security Context for the runner container See [https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) |
| persistence.accessModes | list | `["ReadWriteOnce"]` | AccessModes for the new PVC. See [https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.dataSource | object | `{}` | DataSource option for cloning an existing volume or creating from a snapshot for a new PVC. See [values.yaml](values.yaml) for more details. |
| persistence.deleteOnUninstall | bool | `true` | Boolean flag whether to delete the (new) PVC on uninstall or not. |
| persistence.existingClaim | string | `""` | The name of an existing PVC to use instead of creating a new one. |
| persistence.finalizers | list | `["kubernetes.io/pvc-protection"]` | Finalizers for the new PVC. See [https://kubernetes.io/docs/concepts/storage/persistent-volumes/#storage-object-in-use-protection](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#storage-object-in-use-protection) |
| persistence.selectorLabels | object | `{}` | Selector Labels for the new PVC. See [https://kubernetes.io/docs/concepts/storage/persistent-volumes/#selector](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#selector) |
| persistence.size | string | `"100Gi"` | Size of the volume for the new PVC |
| persistence.storageClassName | string | `""` | Name of the storage class for the new PVC. If empty or not set then storage class will not be set - which means that the default storage class will be used. |
| resources | object | `{}` | Resource constraints for the builder and runner |
| s3Adapter.image.pullPolicy | string | `"Always"` | Image Pull Policy for the S3 Adapter |
| s3Adapter.image.repository | string | `"assistos/s3-adapter"` | The repository of the container image for the S3 Adapter |
| s3Adapter.image.sha | string | `"3fd47eab0604c4e73d1b2eca47503dcb4c99c3d481daae5b0e8f6e24d9c05d79"` | sha256 digest of the image. Do not add the prefix "@sha256:" |
| s3Adapter.image.tag | string | `"1.0.0-rc1"` | The Tag of the image for the S3 Adapter |
| s3AdapterConfig.accessKeyId | string | `""` | The S3 Access Key ID |
| s3AdapterConfig.backupJournalFilePath | string | `"/outfinity-gift/apihub-root/external-volume/backup/backup-journal.txt"` |  |
| s3AdapterConfig.bucketName | string | `""` | The S3 Bucket Name |
| s3AdapterConfig.endpoint | string | `""` | The S3 Endpoint |
| s3AdapterConfig.port | int | `3000` |  |
| s3AdapterConfig.region | string | `""` | The S3 Region |
| s3AdapterConfig.secretAccessKey | string | `""` | The S3 Secret Access Key |
| s3AdapterConfig.watchList[0] | string | `"/outfinity-gift/apihub-root/external-volume/versionlessdsu"` |  |
| s3AdapterConfig.watchList[1] | string | `"/outfinity-gift/apihub-root/external-volume/lightDB"` |  |
| secretProviderClass.apiVersion | string | `"secrets-store.csi.x-k8s.io/v1"` | API Version of the SecretProviderClass |
| secretProviderClass.enabled | bool | `false` | Whether to use CSI Secrets Store (e.g. Azure Key Vault) instead of "traditional" Kubernetes Secret. NOTE: DO ENABLE, NOT TESTED YET! |
| secretProviderClass.spec | object | `{}` | Spec for the SecretProviderClass. Note: The orgAccountJson must be mounted as objectAlias orgAccountJson |
| service.annotations | object | `{}` | Annotations for the service. See AWS, see [https://kubernetes.io/docs/concepts/services-networking/service/#ssl-support-on-aws](https://kubernetes.io/docs/concepts/services-networking/service/#ssl-support-on-aws) For Azure, see [https://kubernetes-sigs.github.io/cloud-provider-azure/topics/loadbalancer/#loadbalancer-annotations](https://kubernetes-sigs.github.io/cloud-provider-azure/topics/loadbalancer/#loadbalancer-annotations) |
| service.loadBalancerIP | string | `""` | A static IP address for the LoadBalancer if type is LoadBalancer. Note: This only applies to certain Cloud providers like Google or [Azure](https://docs.microsoft.com/en-us/azure/aks/static-ip). [https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer). |
| service.loadBalancerSourceRanges | string | `nil` | A list of CIDR ranges to whitelist for ingress traffic to the service if type is LoadBalancer. If list is empty, Kubernetes allows traffic from 0.0.0.0/0 |
| service.port | int | `8080` | Port where the service will be exposed |
| service.type | string | `"ClusterIP"` | Either ClusterIP, NodePort or LoadBalancer for the runner See [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/) |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automountServiceAccountToken | bool | `false` | Whether automounting API credentials for a service account is enabled or not. See [https://docs.bridgecrew.io/docs/bc_k8s_35](https://docs.bridgecrew.io/docs/bc_k8s_35) |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created which is used by builder and runner. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Tolerations for scheduling a pod. See [https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| volumeSnapshots.apiVersion | string | `"v1"` | API Version of the "snapshot.storage.k8s.io" resource. See [https://kubernetes.io/docs/concepts/storage/volume-snapshots/](https://kubernetes.io/docs/concepts/storage/volume-snapshots/) |
| volumeSnapshots.className | string | `""` | The Volume Snapshot class name to use for the pre-upgrade and the final snapshot. It is stongly recommended to use a class with 'deletionPolicy: Retain' for the pre-upgrade and final snapshots. Otherwise you will loose the snapshot on your storage system if the Kubernetes VolumeSnapshot will be deleted (e.g. if the namespace will be deleted). See [https://kubernetes.io/docs/concepts/storage/volume-snapshot-classes/](https://kubernetes.io/docs/concepts/storage/volume-snapshot-classes/) |
| volumeSnapshots.finalSnapshotEnabled | bool | `false` | Whether to create final snapshot before delete. The name of the VolumeSnapshot will be "<helm release name>-final-<UTC timestamp YYYYMMDDHHMM>", e.g. "outfinity-gift-final-202206221213" |
| volumeSnapshots.preUpgradeEnabled | bool | `false` | Whether to create snapshots before helm upgrading or not. The name of the VolumeSnapshot will be "<helm release name>-upgrade-to-revision-<helm revision>-<UTC timestamp YYYYMMDDHHMM>", e.g. "outfinity-gift-upgrade-to-revision-19-202206221211" |
| volumeSnapshots.waitForReadyToUse | bool | `true` | Whether to wait until the VolumeSnapshot is ready to use. Note: On first snapshot this may take a while. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)
