{{- /*
Template for Secret.

Arguments to be passed are 
- $ (index 0)
- . (index 1)
- suffix (index 2)
- dictionary (index 3) for annotations used for defining helm hooks.

See https://blog.flant.com/advanced-helm-templating/
*/}}
{{- define "outfinity-gift.secret" -}}
{{- $ := index . 0 }}
{{- $suffix := index . 2 }}
{{- $annotations := index . 3 }}
{{- with index . 1 }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "outfinity-gift.fullname" . }}{{ $suffix | default "" }}
  namespace: {{ template "outfinity-gift.namespace" . }}
  {{- with $annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "outfinity-gift.labels" . | nindent 4 }}
type: Opaque
data:
  env.json: |-
{{- if .Values.config.overrides.envJson }}
{{ .Values.config.overrides.envJson | b64enc | indent 4 }}
{{- else }}
{{ include "outfinity-gift.envJson" . | b64enc | indent 4 }}
{{- end }}

  apihub.json: |-
{{- if .Values.config.overrides.apihubJson }}
{{ .Values.config.overrides.apihubJson | b64enc | indent 4 }}
{{- else }}
{{ include "outfinity-gift.apihubJson" . | b64enc | indent 4 }}
{{- end }}

  config.json: |
{{ include "outfinity-gift.s3AdapterConfigJson" . | b64enc | indent 4 }}
{{- end }}
{{- end }}