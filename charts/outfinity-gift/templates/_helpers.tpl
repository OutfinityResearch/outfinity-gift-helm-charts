{{/*
Expand the name of the chart.
*/}}
{{- define "outfinity-gift.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "outfinity-gift.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "outfinity-gift.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "outfinity-gift.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "outfinity-gift.labels" -}}
helm.sh/chart: {{ include "outfinity-gift.chart" . }}
{{ include "outfinity-gift.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "outfinity-gift.selectorLabels" -}}
app.kubernetes.io/name: {{ include "outfinity-gift.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "outfinity-gift.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "outfinity-gift.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "outfinity-gift.pvc" -}}
{{- if .Values.persistence.existingClaim }}
{{- .Values.persistence.existingClaim }}
{{- else }}
{{- include "outfinity-gift.fullname" . }}
{{- end }}
{{- end }}

{{/*
Configuration env.json
*/}}
{{- define "outfinity-gift.envJson" -}}
{
  "PSK_TMP_WORKING_DIR": "tmp",
  "PSK_CONFIG_LOCATION": "../apihub-root/external-volume/config",
  "DEV": {{ required "config.dev must be set" .Values.config.dev | quote}},
  "VAULT_DOMAIN": {{ required "config.vaultDomain must be set" .Values.config.vaultDomain | quote}},
  "SSO_SECRETS_ENCRYPTION_KEY": {{ required "config.ssoSecretsEncryptionKey must be set" .Values.config.ssoSecretsEncryptionKey | quote}},
  "BDNS_ROOT_HOSTS": "http://127.0.0.1:8080",
  "OPENDSU_ENABLE_DEBUG": {{ required "config.dev must be set" .Values.config.dev | quote}},
  "STRIPE_SECRET_KEY": {{ required "config.stripeSecretKey must be set" .Values.config.stripeSecretKey | quote}},
  "SENDGRID_API_KEY": {{ required "config.sendgridApiKey must be set" .Values.config.sendgridApiKey | quote}},
  "SENDGRID_SENDER_EMAIL": {{ required "config.sendgridSenderEmail must be set" .Values.config.sendgridSenderEmail | quote}},
  "PDF_TO_HTML_CONVERTER_URL": {{ required "config.pdfToHtmlConverterUrl must be set" .Values.config.pdfToHtmlConverterUrl | quote}},
  "AUTH_API_PREFIX": {{ required "config.authApiPrefix must be set" .Values.config.authApiPrefix | quote}},
  "SERVERLESS_ID": {{ required "config.serverlessId must be set" .Values.config.serverlessId | quote}},
  "SERVERLESS_STORAGE": {{ required "config.serverlessStorage must be set" .Values.config.serverlessStorage | quote}},
  "LOGS_FOLDER": {{ required "config.logsFolder must be set" .Values.config.logsFolder | quote}},
  "AUDIT_FOLDER": {{ required "config.auditFolder must be set" .Values.config.auditFolder | quote}},
  "RP_ID": {{ required "config.rpId must be set" .Values.config.rpId | quote}},
  "ORIGIN": {{ required "config.origin must be set" .Values.config.origin | quote}},
  "APP_NAME": {{ required "config.appName must be set" .Values.config.appName | quote}}
}
{{- end }}

{{/*
Configuration apihub.json.
*/}}
{{- define "outfinity-gift.apihubJson" -}}
{
  "storage": "../apihub-root",
  "port": 8080,
  "workers": 1,
  "preventRateLimit": true,
  "activeComponents": [
    "bdns",
    "bricking",
    "anchoring",
    "proxy",
    "Gatekeeper",
    "outfinity-gift-api",
    "versionlessDSU",
    "secrets",
    "lightDBEnclave",
    "staticServer"
  ],
  "componentsConfig": {
    "outfinity-gift-api": {
      "module": "./../../outfinity-gift-apis",
      "function": "getAPIs"
    },
    "outfinity-gift-constants": {
      "module": "./../../outfinity-gift-apis",
      "function": "getConstants"
    },
    "versionlessDSU": {
      "module": "./components/versionlessDSU"
    },
    "Gatekeeper": {
      "module": "./../../Gatekeeper"
    },
    "staticServer": {
      "excludedFiles": [
        ".*.secret",
        ".*private"
      ]
    },
    "bricking": {},
    "anchoring": {}
  },
  "responseHeaders": {
    "X-Frame-Options": "SAMEORIGIN",
    "X-XSS-Protection": "1; mode=block"
  },
  "enableRequestLogger": true,
  "enableJWTAuthorisation": false,
  "enableSimpleAuth": false,
  "enableOAuth": false,
  "enableLocalhostAuthorization": false,
  "cacheDurations": [
    {"urlPattern":"/", "duration": 3600, "method": "equals"},
    {"urlPattern":"/outfinity-gift/getCategories", "duration": 3600},
    {"urlPattern":"/outfinity-gift/getPrivacyPolicy", "duration": 3600},
    {"urlPattern":"/outfinity-gift/getHomeCustomContent", "duration": 3600},
    {"urlPattern":"/outfinity-gift/getDemoGift", "duration": 3600},
    {"urlPattern":"/outfinity-gift/listCauses", "duration": 3600},
    {"urlPattern":"/assets", "duration": 3600},
    {"urlPattern":"/assets/video.mp4", "duration": 3600, "method": "equals"},
    {"urlPattern":"/scripts", "duration": 3600},
    {"urlPattern":"/admin-wallet/bundles/", "duration": 3600},
    {"urlPattern":"/style", "duration": 3600}
  ]
}
{{- end }}

{{- define "outfinity-gift.s3AdapterConfigJson" -}}
{
    "port": {{ required "s3AdapterConfig.port must be set" .Values.s3AdapterConfig.port }},
    "s3": {
        "endpoint": {{ required "s3AdapterConfig.endpoint must be set" .Values.s3AdapterConfig.endpoint | quote }},
        "bucketName": {{ required "s3AdapterConfig.bucketName must be set" .Values.s3AdapterConfig.bucketName | quote }},
        "region": {{ required "s3AdapterConfig.region must be set" .Values.s3AdapterConfig.region | quote }},
        "accessKeyId": {{ required "s3AdapterConfig.accessKeyId must be set" .Values.s3AdapterConfig.accessKeyId | quote }},
        "secretAccessKey": {{ required "s3AdapterConfig.secretAccessKey must be set" .Values.s3AdapterConfig.secretAccessKey | quote }}
    },
    "backupJournalFilePath": {{ required "s3AdapterConfig.backupJournalFilePath must be set" .Values.s3AdapterConfig.backupJournalFilePath | quote }},
    "watchList": [
        {{- range $index, $item := .Values.s3AdapterConfig.watchList }}
        {{- if $index }}, {{ end }}{{ $item | quote }}
        {{- end }}
    ]
}
{{- end }}

