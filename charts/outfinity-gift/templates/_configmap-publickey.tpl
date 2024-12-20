{{- /*
Template for Public Key ConfigMap.
*/}}
{{- define "outfinity-gift.configmap-publickey" -}}
{{- $ := index . 0 }}
{{- $suffix := index . 2 }}
{{- $annotations := index . 3 }}
{{- with index . 1 }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "outfinity-gift.fullname" . }}-publickey{{ $suffix | default "" }}
  namespace: {{ template "outfinity-gift.namespace" . }}
  {{- with $annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "outfinity-gift.labels" . | nindent 4 }}
data:
  publicKey.txt: |-
{{ .Values.config.stripePublicKey | indent 4 }}
{{- end }}
{{- end }}
