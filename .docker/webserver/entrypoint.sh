#!/bin/sh
set -e

# Default to 'fr' if LANGUAGE is not set or empty
REQUESTED_LANG="${LANGUAGE:-fr}"

# Sanitize input: lowercase and keep only a-z (strictly prevents path traversal / injection)
CLEANED_LANG=$(printf "%s" "$REQUESTED_LANG" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z')

# Whitelist of valid supported languages
VALID_LANGUAGES="fr en ar de it es ja ko pl pt ru th vi zh"

SELECTED_LANG="fr"
for lang in $VALID_LANGUAGES; do
    if [ "$CLEANED_LANG" = "$lang" ]; then
        SELECTED_LANG="$lang"
        break
    fi
done

TARGET_FILE="/usr/share/nginx/html/index_${SELECTED_LANG}.html"

if [ -f "$TARGET_FILE" ]; then
    echo "[Entrypoint] Selected language: ${SELECTED_LANG} -> copying ${TARGET_FILE} to /usr/share/nginx/html/index.html"
    cp "$TARGET_FILE" /usr/share/nginx/html/index.html
else
    echo "[Entrypoint] Target file not found (${TARGET_FILE}), falling back to index_fr.html"
    cp /usr/share/nginx/html/index_fr.html /usr/share/nginx/html/index.html
fi

if [ "$#" -eq 0 ]; then
    exec nginx -g "daemon off;"
else
    exec "$@"
fi
