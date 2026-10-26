"""Build the public import ZIP from the reviewed XML; uses only Python stdlib."""
from pathlib import Path
import hashlib
import json
import zipfile
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parent
ALLOWED = {
    'HIDE_BARS_AA', 'FULLSCREEN', 'LANDSCAPE_VIDEO', 'VOICE_CONTROL_LANG',
    'HIDE_BARS', 'THEME_MAIN', 'FULLSCREEN_AA',
    'VOICE_CONTROl_ENABLED', 'VOICE_CONTROl_FB',
}
FILES = {
    'fermata.xml': ALLOWED,
    'tvm3u.xml': {'1#VIDEO', '1#NAME', '1#MAX_AGE', 'ID_COUNTER', '1#URL'},
    'medialib.xml': {'TV#M3UID#1', 'TV#SOURCE_COUNTER', 'TV#SOURCE_IDS'},
}

def build():
    target = ROOT / 'fermata-samsung-public-v1.zip'
    with zipfile.ZipFile(target, 'w') as archive:
        for name, allowed in FILES.items():
            source = ROOT / name
            tree = ET.parse(source)
            keys = [node.attrib['name'] for node in tree.getroot()]
            if tree.getroot().tag != 'map' or set(keys) != allowed or len(keys) != len(allowed):
                raise ValueError(f'{name}: keys differ from the reviewed allowlist')
            info = zipfile.ZipInfo(name, (2026, 10, 26, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            # Git may check text out with CRLF on Windows; keep ZIP bytes stable.
            archive.writestr(info, source.read_bytes().replace(b'\r\n', b'\n'))
    digest = hashlib.sha256(target.read_bytes()).hexdigest()
    manifest = {
        'fileName': target.name, 'schemaVersion': 1, 'size': target.stat().st_size,
        'sha256': digest, 'entries': list(FILES),
        'allowedKeys': {name: sorted(keys) for name, keys in FILES.items()},
        'deviceImportTest': 'Not yet tested on a phone; validate after native import',
    }
    (ROOT / 'preset.lock.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
    print(f'{target.name}: {digest}')

if __name__ == '__main__':
    build()
