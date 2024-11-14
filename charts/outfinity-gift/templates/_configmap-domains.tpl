{{- /*
Template for Configmap.

Arguments to be passed are 
- $ (index 0)
- . (index 1)
- suffix (index 2)
- dictionary (index 3) for annotations used for defining helm hooks.

See https://blog.flant.com/advanced-helm-templating/
*/}}
{{- define "outfinity-gift.configmap-domains" -}}
{{- $ := index . 0 }}
{{- $suffix := index . 2 }}
{{- $annotations := index . 3 }}
{{- with index . 1 }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "outfinity-gift.fullname" . }}-domains{{ $suffix | default "" }}
  namespace: {{ template "outfinity-gift.namespace" . }}
  {{- with $annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "outfinity-gift.labels" . | nindent 4 }}
data:
  # e.g. 'vault.companyname.json'
  {{ required "config.vaultDomain must be set" .Values.config.vaultDomain }}.json: |-
{{- if .Values.config.overrides.vaultDomainConfigJson }}
{{ .Values.config.overrides.vaultDomainConfigJson | indent 4 }}
{{- else }}
    {
      "anchoring": {
        "type": "FS"
      },
      "enableBackup": true,
      "backupServerUrl": "http://s3-adapter:${{ required "s3AdapterConfig.port must be set" .Values.s3AdapterConfig.port }}/backup",
    }
{{- end }}

{{- end }}
{{- end }}