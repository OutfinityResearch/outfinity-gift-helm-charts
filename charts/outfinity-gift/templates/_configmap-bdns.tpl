{{- /*
Template for Configmap.

Arguments to be passed are 
- $ (index 0)
- . (index 1)
- suffix (index 2)
- dictionary (index 3) for annotations used for defining helm hooks.

See https://blog.flant.com/advanced-helm-templating/
*/}}
{{- define "outfinity-gift.configmap-bdns" -}}
{{- $ := index . 0 }}
{{- $suffix := index . 2 }}
{{- $annotations := index . 3 }}
  {{- with index . 1 }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "outfinity-gift.fullname" . }}-bdns{{ $suffix | default "" }}
  namespace: {{ template "outfinity-gift.namespace" . }}
  {{- with $annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "outfinity-gift.labels" . | nindent 4 }}
data:
  bdns.hosts: |-
    {
      "{{ .Values.config.domain }}": {
          "anchoringServices": [
              "$ORIGIN"
          ],
          "notifications": [
              "$ORIGIN"
          ]
      },
      "{{ .Values.config.subDomain }}": {
          "brickStorages": [
              "$ORIGIN"
          ],
          "anchoringServices": [
              "$ORIGIN"
          ],
          "notifications": [
              "$ORIGIN"
          ]
      },
      "{{ .Values.config.vaultDomain }}": {
          "replicas": [],
          "brickStorages": [
              "$ORIGIN"
          ],
          "anchoringServices": [
              "$ORIGIN"
          ],
          "notifications": [
              "$ORIGIN"
          ]
      }
    }

{{- end }}
{{- end }}
