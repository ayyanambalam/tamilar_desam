#!/usr/bin/env bash
set -euo pipefail

echo "== Tamilar Desam: CI build APK =="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="$WORK_DIR" python3 -c '
import os, re, base64, pathlib
s = os.environ.get("GOOGLE_SERVICES_JSON_BASE64","")
s = re.sub(r"\s+", "", s)
s += "=" * (-len(s) % 4)
data = base64.b64decode(s, validate=False)
path = pathlib.Path(os.environ["WORK_DIR"]) / "android" / "app" / "google-services.json"
path.write_bytes(data)
print("Wrote", path)
'
OUT_DIR="$ROOT_DIR/build-output"

rm -rf "$WORK_DIR" "$OUT_DIR"
mkdir -p "$WORK_DIR" "$OUT_DIR"

echo "Creating Flutter project in: $WORK_DIR"
pushd "$WORK_DIR" >/dev/null

flutter --version
flutter create . --org com.tamilardesam --project-name tamilar_desam

echo "Copying app sources..."
cp -f "$ROOT_DIR/pubspec.yaml" "$WORK_DIR/pubspec.yaml"
cp -f "$ROOT_DIR/analysis_options.yaml" "$WORK_DIR/analysis_options.yaml"
rm -rf "$WORK_DIR/lib" "$WORK_DIR/assets"
cp -R "$ROOT_DIR/lib" "$WORK_DIR/lib"
cp -R "$ROOT_DIR/assets" "$WORK_DIR/assets"

echo "Injecting google-services.json (from secret)..."
if [[ -z "${GOOGLE_SERVICES_JSON_BASE64:-}" ]]; then
  echo "ERROR: Missing GOOGLE_SERVICES_JSON_BASE64 secret."
  echo "Add it in GitHub repo Settings -> Secrets and variables -> Actions."
  exit 1
fi
mkdir -p "$WORK_DIR/android/app"

printf '%s' "$GOOGLE_SERVICES_JSON_BASE64" | tr -d '\n\r ' | base64 --decode --ignore-garbage > "$WORK_DIR/android/app/google-services.json"
echo "Fetching packages..."
flutter pub get

echo "Building debug APK..."
flutter build apk --debug

cp "$WORK_DIR/build/app/outputs/flutter-apk/app-debug.apk" "$OUT_DIR/app-debug.apk"

echo "APK ready at: $OUT_DIR/app-debug.apk"
popd >/dev/null

