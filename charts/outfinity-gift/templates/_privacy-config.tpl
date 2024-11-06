{{- /*
Template for privacy.txt ConfigMap.
*/}}
{{- define "outfinity-gift.configmap-privacy" -}}
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
  privacy.txt: |
    1. Introduction
    Welcome to TimeGift. We are committed to respecting the privacy of our users. This Privacy Policy outlines our practices concerning collecting, using, and protecting personal information.

    2. Information Collection
    To provide our gift-sending service, TimeGift requires certain personal information: the name of the sender and recipient, as they are part of the gift voucher. For support purposes, we also collect email addresses. The content of the gift is always encrypted; only the metadata about the gift is stored in a database.

    3. Use of Information
    The personal information collected is solely used to facilitate the gift-sending process and provide customer support. We do not use this information for any other marketing or commercial purposes. You can use invented or empty email addresses if you don't want any support in the future.

    4. Data Security
    We do not store encryption keys for the gift content. Consequently, TimeGift cannot access or recover gift content once it has been encrypted and sent.

    5. Encryption Key Retention
    During the gift creation, senders can explicitly consent to retain the encryption key. This is solely to recover the gift content if the gift voucher is lost. Without this consent, the encryption key will not be retained, making the gift unrecoverable after sending.

    6. Data Retention and Deletion
    Personal information is retained as long as necessary to fulfil the requested service and is securely deleted once it is no longer needed for service provision.

    7. Changes to This Policy
    TimeGift reserves the right to modify this Privacy Policy at any time. We will notify you of significant changes by posting the new policy on our website.

    8. Contact Us
    If you have any questions or concerns about our Privacy Policy, please contact us.
{{- end }}
{{- end }}