{{- /*
Template for homeContent.json ConfigMap.
*/}}
{{- define "outfinity-gift.configmap-home-content" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: home-content-config
  namespace: {{ template "outfinity-gift.namespace" . }}
  labels:
    {{- include "outfinity-gift.labels" . | nindent 4 }}
data:
  homeContent.json: |
    {
      "home_title": "Unforgettable Gift Experiences",
      "home_text": "Turn every moment into a cherished memory. Send personalized video messages that are more heartfelt and polished than traditional greetings through social media, SMS, phone calls, or messaging apps. It's a unique way to show you care. Plus, each gift card offers even more—contribute to meaningful causes and unlock access to a curated marketplace. Recipients can explore a variety of digital products and services, choosing gifts that truly resonate with them. Make every occasion not just memorable, but unforgettable.",
      "redeem_text": "Connect with loved ones, including yourself, through a creative gift that honours special moments. Enjoy these precious times!"
    }
{{- end }}